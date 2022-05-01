import Combine
import UIKit

public class ExercisesViewController: UICollectionViewController {
    
    private let viewModel: ExercisesViewModel
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Exercise>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Exercise>
    
    private var dataSource: DataSource?
    private var cancellables: Set<AnyCancellable> = []
    private(set) var loadingIndicator = UIActivityIndicatorView(style: .large)
    private(set) var infoLabel = UILabel()
    
    public init(viewModel: ExercisesViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: Self.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Exercises"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        self.collectionView.isHidden = true
        addLoadingIndicator()
        configureCollectionView()
        addInfoLabel()
        
        // Bindings
        viewModel
            .$isLoading
            .sink { [weak self] showLoadingIndicator in
                if showLoadingIndicator {
                    self?.infoLabel.isHidden = true
                    self?.collectionView.isHidden = true
                    self?.loadingIndicator.startAnimating()
                    
                } else {
                    self?.collectionView.isHidden = false
                    self?.loadingIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
        viewModel
            .$isShowingError
            .sink { [weak self] showError in
                if showError {
                    self?.collectionView.isHidden = true
                    self?.loadingIndicator.isHidden = true
                    self?.showInfoLabel(message: "Sorry, something bad happened :(")
                    
                }
            }
            .store(in: &cancellables)
        
        viewModel
            .$exercises
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] exercises in
                if exercises.isEmpty == false {
                    self?.infoLabel.isHidden = true
                    self?.applySnapshot(from: exercises)
                } else {
                    self?.showInfoLabel(message: "Sorry, there are no available exercises")
                }
            }
            .store(in: &cancellables)
        
        // Load Exercises
        viewModel.loadExercises()
        
    }
    
    private func addInfoLabel() {
        infoLabel.isHidden = true
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = .systemFont(ofSize: 18, weight: .light)
        
        view.addSubview(infoLabel)
        
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func showInfoLabel(message: String) {
        infoLabel.text = message
        infoLabel.isHidden = false
    }
    
    private func addLoadingIndicator() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true

        view.addSubview(loadingIndicator)

        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func configureCollectionView() {
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)

        let registration = UICollectionView.CellRegistration<CustomCell, Exercise> { cell, indexPath, exercise in
            cell.viewModel = CustomCellViewModel(exercise: exercise, imageLoader: self.viewModel.imageLoader)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Exercise>(
            collectionView: collectionView
        ) { collectionView, indexPath, exercise in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: exercise)
        }
    
    }
    
    func applySnapshot(from exercises: [Exercise]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([0])
        snapshot.appendItems(exercises)
        
        dataSource?.apply(snapshot)
    }
    
    private static func createLayout() -> UICollectionViewLayout {
        let appearance = UICollectionLayoutListConfiguration.Appearance.plain
        return UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: appearance)
            config.backgroundColor = .clear
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }
}

extension ExercisesViewController {
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let exercise = dataSource?.itemIdentifier(for: indexPath) else { return }
        viewModel.onExerciseVariationSelected(exercise)
    }
}
