//
//  ShowRefreshViewController.swift
//  PopcorniOS
//
//  Created by Anne on 12/12/22.
//

import Foundation
import PopcornCore
import UIKit

public final class ShowRefreshViewController: NSObject {
    private(set) lazy var view: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }()
    
    private let showLoader: ShowLoader
    
    public init(showLoader: ShowLoader) {
        self.showLoader = showLoader
    }
    
    public var onRefresh: (([Show]) -> Void)?
    
    @objc func refresh() {
        view.beginRefreshing()
        showLoader.load { [weak self] result in
            if let shows = try? result.get() {
                self?.onRefresh?(shows)
            }
            DispatchQueue.main.async {
                self?.view.endRefreshing()
            }
        }
    }
}
