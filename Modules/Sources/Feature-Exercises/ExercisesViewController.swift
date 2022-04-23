import Combine
import UIKit

public class ExercisesViewController: UICollectionViewController {
    
    private let viewModel: ExercisesViewModel
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Exercise>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Exercise>
    
    private var dataSource: DataSource?
    private var cancellables: Set<AnyCancellable> = []
    
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
        configureCollectionView()
        viewModel.loadExercises()
        
        viewModel
            .$exercises
            .sink { [weak self] exercises in
                self?.applySnapshot(from: exercises)
            }
            .store(in: &cancellables)
    }
    
    private func configureCollectionView() {
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)

        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Exercise> { cell, indexPath, exercise in
            var content = cell.defaultContentConfiguration()
            content.text = exercise.title
            if let data = exercise.image,
                let image = UIImage(data: data) {
                content.image = image
            } else {
                content.image = UIImage(named: "default-placeholder")
            }
            content.imageProperties.maximumSize = CGSize(width: 30, height: 30)
            cell.contentConfiguration = content
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
