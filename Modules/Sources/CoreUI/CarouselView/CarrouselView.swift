import Foundation
import Shared_DataLoader
import SwiftUI

public struct CarrouselView: View {
    @ObservedObject private var viewModel: CarrouselViewModel
    
    public init(
        viewModel: CarrouselViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        TabView {
            showImages()
        }
        .tabViewStyle(PageTabViewStyle())
    }
    
    private func showImages() -> some View {
        Group {
            if viewModel.imageURLs.count > 0 {
                ForEach(viewModel.imageURLs, id: \.absoluteString) { imageURL in
                    ZStack {
                        Color.clear
                        AsyncImage(
                            url: imageURL,
                            viewModel: .init(imageLoader: RemoteImageLoader()),
                            placeholder: { ProgressView() }
                        )
                            .scaledToFit()
                    }
                }
            } else {
                noImagePlaceholder
            }
        }
    }
    
    private var noImagePlaceholder: some View {
        ZStack {
            Image(uiImage: UIImage(named: "default-placeholder")!)
                .resizable()
                .scaledToFill()
                .opacity(0.4)
            
            Text("No images found")
                .foregroundColor(.primary)
                .bold()
        }
    }
}
