//
//  ShowsUIComposer.swift
//  Popcorn
//
//  Created by Anne on 12/12/22.
//

import Foundation
import PopcornCore

public final class ShowsUIComposer {
    
    public init() {}
    
    public func showsComposed(
        with showLoader: ShowLoader,
        imageLoader: ImageDataLoader
    ) -> ShowsViewController {
        let refreshController = ShowRefreshViewController(showLoader: showLoader)
        let showsViewController = ShowsViewController(refreshController: refreshController)
        showsViewController.title = ShowsPresenter.title
        
        refreshController.onRefresh = adaptShowsToCellControllers(forwardingTo: showsViewController, loader: imageLoader)
        
        return showsViewController
    }
    
    private func adaptShowsToCellControllers(forwardingTo controller: ShowsViewController, loader: ImageDataLoader) -> ([Show]) -> Void {
        return { [weak controller] show in
            DispatchQueue.main.async {
                controller?.tableModel = show.map { model in
                    ShowCellController(viewModel: ShowViewModelMapper.map(model), imageLoader: loader)
                }
            }
        }
    }
}
