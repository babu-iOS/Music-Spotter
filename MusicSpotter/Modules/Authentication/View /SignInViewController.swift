//
//  SignInViewController.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var pwShowHideImage:UIImageView!
    
    let viewModel = AuthenticationviewModel()
    private var pwIsHide = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func newAccountAction(_ sender:UIButton){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")as? SignUpViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func pwShowHideTapped(_ sender: UIButton) {
        pwIsHide = !pwIsHide
        pwShowHideImage.image = pwIsHide ? UIImage(named: "eyeLash") : UIImage(named: "lightEye")
        PasswordTextField.isSecureTextEntry = pwIsHide ? true : false
    }
    @IBAction func loginAction(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = PasswordTextField.text, !password.isEmpty else {
            showAlert(message: "Email or password cannot be empty", tittle: "Error")
            return
        }
        
        CoreDataManager.shared.fetchUserCredentials(email: email) { (fetchedEmail, fetchedPassword,fetchedName)  in
            if let fetchedEmail = fetchedEmail, let fetchedPassword = fetchedPassword ,let fetchedName = fetchedName{
                if fetchedEmail == email && fetchedPassword == password {
                    print("Login successful! Welcome, \(email)")
                    UserDefaults.standard.set(email, forKey: "UserEmail")
                    UserDefaults.standard.set(fetchedName, forKey: "UserName")
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                        vc.userName = fetchedName
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    print("Invalid email or password")
                    self.showAlert(message: "Invalid email or password", tittle: "Error")
                }
            } else {
                print("User not found")
                self.showAlert(message: "Invalid Login credentials, please check your email & password", tittle: "User not found")
            }
        }
    }
}

