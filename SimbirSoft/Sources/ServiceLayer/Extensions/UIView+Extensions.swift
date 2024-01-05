//
//  UIView+Extensions.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
