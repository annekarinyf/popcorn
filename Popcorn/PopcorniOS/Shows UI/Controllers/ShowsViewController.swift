//
//  ShowsViewController.swift
//  PopcorniOS
//
//  Created by Anne on 12/12/22.
//

import PopcornCore
import UIKit

public final class ShowsViewController: UITableViewController {
    private var refreshController: ShowRefreshViewController?
    public var tableModel = [ShowCellController]() {
        didSet { tableView.reloadData() }
    }
    
    convenience init(refreshController: ShowRefreshViewController) {
        self.init()
        self.refreshController = refreshController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 90
        refreshControl = refreshController?.view
        refreshController?.refresh()
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view()
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> ShowCellController {
        return tableModel[indexPath.row]
    }
}
