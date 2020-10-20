//
//  UIAlertController+Ext.swift
//  FetchHiring
//
//  Created by Nick Nguyen on 10/19/20.
//

import UIKit

extension UIAlertController {
    convenience init(localizedError: LocalizedError) {
        let title = localizedError.errorDescription
        let message = localizedError.recoverySuggestion

        self.init(title: title,
                  message:message,
                  preferredStyle:.alert)
    }
}
