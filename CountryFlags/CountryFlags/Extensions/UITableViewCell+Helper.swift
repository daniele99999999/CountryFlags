//
//  UITableViewCell+Helper.swift
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        "\(String(describing: self))-reuseIdentifier"
    }
}

