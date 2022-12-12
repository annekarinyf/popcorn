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
    private let model: Show
    private let imageLoader: ImageDataLoader

    public init(model: Show, imageLoader: ImageDataLoader) {
        self.model = model
        self.imageLoader = imageLoader
    }

    func view() -> UITableViewCell {
        let cell = ShowCell()
        cell.nameLabel.text = model.name
        cell.summaryLabel.text = model.summary

        let loadImage = { [weak self, weak cell] in
            guard let self = self else { return }

            self.task = self.imageLoader.loadImageData(from: self.model.url) { [weak cell] result in
                let data = try? result.get()
                let image = data.map(UIImage.init) ?? nil
                cell?.showImageView.image = image
            }
        }

        loadImage()

        return cell
    }
    
    func preload() {
        task = imageLoader.loadImageData(from: model.url) { _ in }
    }

    func cancelLoad() {
        task?.cancel()
    }
}

