//
//  UITableViewController+Ext.swift
//  FetchHiring
//
//  Created by Nick Nguyen on 10/19/20.
//

import UIKit

extension UITableViewController {
    func presentErrorAlertOnMainThread(for error: NetworkError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(localizedError: error)
            self.present(alert, animated: true, completion: nil)
        }
    }

    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
