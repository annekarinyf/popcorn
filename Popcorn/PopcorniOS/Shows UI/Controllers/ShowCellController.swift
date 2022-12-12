//
//  ShowCellController.swift
//  PopcorniOS
//
//  Created by Anne on 12/12/22.
//

import PopcornCore
import UIKit

public final class ShowCellController {
    private var task: ImageDataLoaderTask?
    private let viewModel: ShowViewModel
    private let imageLoader: ImageDataLoader

    public init(viewModel: ShowViewModel, imageLoader: ImageDataLoader) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
    }

    func view() -> UITableViewCell {
        let cell = ShowCell()
        cell.nameLabel.text = viewModel.name
        cell.summaryLabel.text = viewModel.summary

        let loadImage = { [weak self, weak cell] in
            guard let self = self else { return }

            self.imageLoader.loadImageData(from: self.viewModel.imageURL!) { [weak cell] result in
                let data = try? result.get()
                let image = data.map(UIImage.init) ?? nil
                DispatchQueue.main.async {
                    cell?.showImageView.image = image
                }
            }
        }

        loadImage()

        return cell
    }
    
    func preload() {
        //task = imageLoader.loadImageData(from: model.url) { _ in }
    }

    func cancelLoad() {
        task?.cancel()
    }
}

