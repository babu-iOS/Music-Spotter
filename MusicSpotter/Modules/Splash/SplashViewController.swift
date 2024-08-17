//
//  SplashViewController.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let userName = UserDefaults.standard.string(forKey: "UserName"), !userName.isEmpty {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as? HomeViewController{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SignInViewController")as? SignInViewController{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
