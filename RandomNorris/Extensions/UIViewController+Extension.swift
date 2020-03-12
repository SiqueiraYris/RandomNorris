//
//  UIViewController+Extension.swift
//  RandomNorris
//
//  Created by Siqueira on 12/03/20.
//  Copyright © 2020 Siqueira. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
