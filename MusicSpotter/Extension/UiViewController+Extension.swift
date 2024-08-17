//
//  UiViewController+Extension.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(message: String,tittle:String) {
            let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
   
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
