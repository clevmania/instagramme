//
//  RegisterViewController.swift
//  instagram
//
//  Created by Icelod on 11/10/20.
//  Copyright © 2020 Icelod. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let userNameField : UITextField = {
        let userField = UITextField()
        userField.layer.cornerRadius = Constants.cornerRadius
        userField.placeholder = Constants.userNamePlaceholder
        userField.returnKeyType = .next
        userField.leftViewMode = .always
        userField.leftView = UIView(frame: CGRect(x: 0, y:0, width: 10, height:0))
        userField.autocapitalizationType = .none
        userField.autocorrectionType = .no
        userField.layer.masksToBounds = true
        userField.backgroundColor = .secondarySystemBackground
        userField.layer.borderWidth = 1
        userField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return userField
    }()
    
    private let emailAddressField : UITextField = {
        let emailField = UITextField()
        emailField.layer.cornerRadius = Constants.cornerRadius
        emailField.placeholder = Constants.emailPlaceholder
        emailField.returnKeyType = .next
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y:0, width: 10, height:0))
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.layer.masksToBounds = true
        emailField.backgroundColor = .secondarySystemBackground
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return emailField
    }()
    
    private let passwordField : UITextField = {
        let passField = UITextField()
        passField.layer.cornerRadius = Constants.cornerRadius
        passField.placeholder = Constants.passwordPlaceholder
        passField.returnKeyType = .continue
        passField.leftViewMode = .always
        passField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passField.autocapitalizationType = .none
        passField.autocorrectionType = .no
        passField.layer.masksToBounds = true
        passField.isSecureTextEntry = true
        passField.backgroundColor = .secondarySystemBackground
        passField.layer.borderWidth = 1.0
        passField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return passField
    }()
    
    private let registerButton : UIButton = {
        let registerButton = UIButton()
        registerButton.setTitle(Constants.register, for: .normal)
        registerButton.layer.masksToBounds = true
        registerButton.backgroundColor = .systemGreen
        registerButton.layer.cornerRadius = Constants.cornerRadius
        registerButton.setTitleColor(.white, for: .normal)
        return registerButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        emailAddressField.delegate = self
        userNameField.delegate = self
        passwordField.delegate = self
        setContentView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        userNameField.frame = (CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: view.width - 40, height: 50))
        emailAddressField.frame = CGRect(x: 20, y: userNameField.bottom + 10, width: view.width - 40, height: 50)
        passwordField.frame = (CGRect(x: 20, y: emailAddressField.bottom + 10, width: view.width - 40, height: 50))
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom + 20, width: view.width - 40, height: 50)
    }
    
    private func setContentView(){
        view.backgroundColor = .systemBackground
        view.addSubview(userNameField)
        view.addSubview(emailAddressField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
    }
    
    @objc private func registerButtonPressed(){
        userNameField.resignFirstResponder()
        emailAddressField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let username = userNameField.text , !username.isEmpty,
            let emailAddress = emailAddressField.text, !emailAddress.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        AuthManager.registerUser(username: username, email: emailAddress, password: password) { isUserRegistered in
            DispatchQueue.main.async {
                if isUserRegistered {
                    
                }else {
                    
                }
            }
        }
    }

}


extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailAddressField.becomeFirstResponder()
        } else if textField == emailAddressField {
            passwordField.becomeFirstResponder()
        }else {
            registerButtonPressed()
        }
        return true
    }
}
