//
//  SignUpViewController.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var pwShowHideImage:UIImageView!
    @IBOutlet weak var ConfirmPwShowHideImage:UIImageView!
    
    let viewModel = AuthenticationviewModel()
    private var pwIsHide = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    private func setupTextFields(){
        [userNameTextField,emailTextField,passwordTextField,confirmPasswordTF].forEach({$0?.delegate = self})
        [userNameTextField,emailTextField,passwordTextField].forEach({$0?.returnKeyType = .next})
        confirmPasswordTF.returnKeyType = .done
    }
    
    @IBAction func oldAccountAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pwShowHideTapped(_ sender: UIButton) {
        togglePasswordVisibility(for: passwordTextField, with: sender, and: pwShowHideImage)
    }
    @IBAction func confirmPwShowHideTapped(_ sender: UIButton) {
        togglePasswordVisibility(for: confirmPasswordTF, with: sender, and: ConfirmPwShowHideImage)
    }
    func togglePasswordVisibility(for textField: UITextField, with button: UIButton, and imageView: UIImageView) {
        textField.isSecureTextEntry.toggle()
        imageView.image = textField.isSecureTextEntry ? UIImage(named: "eyeLash") : UIImage(named: "lightEye")
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if let username = userNameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = confirmPasswordTF.text{
            switch viewModel.validateFieldsForRegister(username: username, email: email, password: password, confirmPassword: confirmPassword) {
            case .success:
                CoreDataManager.shared.saveUser(username: username, email: email, password: password)
                self.navigationController?.popViewController(animated: true)
                break
            case .failure(let message):
                showAlert(message: message, tittle: "Error")
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameTextField :
            emailTextField.becomeFirstResponder()
            break
        case emailTextField :
            passwordTextField.becomeFirstResponder()
            break
        case passwordTextField :
            confirmPasswordTF.becomeFirstResponder()
            break
        case confirmPasswordTF :
            confirmPasswordTF.resignFirstResponder()
            signUpButtonTapped(UIButton())
            break
        default:
            hideKeyboardWhenTappedAround()
            break
        }
        return true
    }
}
