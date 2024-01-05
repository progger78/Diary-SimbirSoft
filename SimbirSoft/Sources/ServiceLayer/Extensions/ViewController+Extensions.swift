//
//  ViewController+Extensions.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "ok", style: .default))
            self.present(alert, animated: true)
        }
    }
}
