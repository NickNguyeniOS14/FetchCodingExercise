//
//  HTTPURLResponse+Ext.swift
//  FetchHiring
//
//  Created by Nick Nguyen on 10/19/20.
//

import Foundation

extension HTTPURLResponse {
    var isOK: Bool {
        (200...299).contains(statusCode)
    }
}
