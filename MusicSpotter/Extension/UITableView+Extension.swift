//
//  UITableView+Extension.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import Foundation
import UIKit

extension UITableView {
    func setTableHeaderFromNib(_ nibName: String) {
        if let headerView = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView {
            tableHeaderView = headerView
        }
    }
    
    func setTableFooterFromNib(_ nibName: String) {
        if let footerView = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView {
            tableFooterView = footerView
        }
    }
    func registerCellNib(_ cellClass: AnyClass) {
        let nib = UINib(nibName: String(describing: cellClass), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func scrollToBottomCell(animated: Bool = true) {
        let sections = numberOfSections
        if sections > 0 {
            let rows = numberOfRows(inSection: sections - 1)
            if rows > 0 {
                let indexPath = IndexPath(row: rows - 1, section: sections - 1)
                scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    func reloadData(withAnimation animation: UITableView.RowAnimation) {
        UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.reloadData()
        }, completion: nil)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
}
