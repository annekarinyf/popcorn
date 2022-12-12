//
//  ShowsUIComposer.swift
//  Popcorn
//
//  Created by Anne on 12/12/22.
//

import PopcornCore

public final class ShowsUIComposer {
    
    var ref: ShowRefreshViewController?
    public init() {}
    
    public func showsComposed(
        with showLoader: ShowLoader,
        imageLoader: ImageDataLoader
    ) -> ShowsViewController {
        let refreshController = ShowRefreshViewController(showLoader: showLoader)
        ref = refreshController
        let showsViewController = ShowsViewController()
        showsViewController.title = ShowsPresenter.title
        
        refreshController.onRefresh = adaptShowsToCellControllers(forwardingTo: showsViewController, loader: imageLoader)
        
        refreshController.refresh()
        
        return showsViewController
    }
    
    private func adaptShowsToCellControllers(forwardingTo controller: ShowsViewController, loader: ImageDataLoader) -> ([Show]) -> Void {
        return { [weak controller] show in
            controller?.tableModel = show.map { model in
                ShowCellController(viewModel: ShowViewModelMapper.map(model), imageLoader: loader)
            }
        }
    }
}
