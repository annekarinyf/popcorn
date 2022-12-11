//
//  ShowCellController.swift
//  Popcorn
//
//  Created by Anne on 11/12/22.
//

import PopcornCore
import UIKit

public protocol ShowCellControllerDelegate {
    func didRequestShow()
    func didCancelShowRequest()
}

final class ShowCellController: NSObject {
    private let viewModel: ShowViewModel
    private let delegate: ShowCellControllerDelegate
    private var cell: ShowCell?
    
    init(viewModel: ShowViewModel, delegate: ShowCellControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
}

extension ShowCellController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        cell?.setup(
            with: .init(
                image: nil,
                name: viewModel.name,
                summary: viewModel.summary
            )
        )
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.cell = cell as? ShowCell
        delegate.didRequestShow()
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelLoad()
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        delegate.didRequestShow()
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        cancelLoad()
    }
    
    private func cancelLoad() {
        releaseCellForReuse()
        delegate.didCancelShowRequest()
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
}
