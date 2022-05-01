import Foundation
import Shared_DataLoader
import SwiftUI

public struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var viewModel: AsyncImageViewModel
    private let placeholder: Placeholder
    private let url: URL

    public init(
        url: URL,
        viewModel: AsyncImageViewModel,
        @ViewBuilder placeholder: () -> Placeholder
    ) {
        
        self.url = url
        self.viewModel = AsyncImageViewModel(imageLoader: RemoteImageLoader())
        self.placeholder = placeholder()
    }

    public var body: some View {
        content
            .onAppear(perform: { viewModel.load(url: url) })
    }

    private var content: some View {
        Group {
            if viewModel.image != nil {
                Image(uiImage: viewModel.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}
