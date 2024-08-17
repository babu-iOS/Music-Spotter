//
//  AuthenticationviewModel.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import Foundation

enum ValidationResult {
    case success
    case failure(message: String)
}

class AuthenticationviewModel {
    func validateFieldsForLogin(email: String?, password: String?) -> ValidationResult {
           guard let email = email, !email.isEmpty else {
               return .failure(message: "Please enter an email address")
           }
           
           guard let password = password, !password.isEmpty else {
               return .failure(message: "Please enter a password")
           }
           
           guard isValidEmail(email) else {
               return .failure(message: "Please enter a valid email address")
           }
           
           return .success
       }
    func validateFieldsForRegister(username: String?, email: String?, password: String?, confirmPassword: String?) -> ValidationResult {
        guard let username = username, !username.isEmpty else {
            return .failure(message: "Please enter a username")
        }
        guard isValidUsername(username) else {
            return .failure(message: "Username must be at least 3 characters long and contain only alphanumeric characters and underscores")
        }
        
        guard let email = email, !email.isEmpty else {
            return .failure(message: "Please enter an email address")
        }
        
        guard isValidEmail(email) else {
            return .failure(message: "Please enter a valid email address")
        }
        
        guard let password = password, !password.isEmpty else {
            return .failure(message: "Please enter a password")
        }
        
        guard let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {
            return .failure(message: "Please confirm your password")
        }
        
        guard isValidPassword(password) else {
            return .failure(message: "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character")
        }
        
        guard password == confirmPassword else {
            return .failure(message: "Passwords do not match")
        }
        
        return .success
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    private func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^[a-zA-Z0-9_]{3,}$"
        return NSPredicate(format: "SELF MATCHES %@", usernameRegex).evaluate(with: username)
    }
}

