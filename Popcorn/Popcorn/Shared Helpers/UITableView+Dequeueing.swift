//
//  UITableView+Dequeueing.swift
//  Popcorn
//
//  Created by Anne on 11/12/22.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
