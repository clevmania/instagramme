//
//  LoginViewController.swift
//  instagram
//
//  Created by Icelod on 11/10/20.
//  Copyright © 2020 Icelod. All rights reserved.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {
    private let usernameOrEmailField : UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = Constants.cornerRadius
        field.placeholder = Constants.emailPlaceholder
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
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
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle(Constants.login, for: .normal)
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let headerView : UIView = {
        let header = UIView()
        header.clipsToBounds = true
        header.backgroundColor = .red
        let headerBackgroundImage = UIImageView(image: UIImage(named: "instagram_gradient"))
        header.addSubview(headerBackgroundImage)
        
        return header
    }()
    
    private let termsConditionButton : UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle(Constants.createAccount, for: .normal)
        return button
    }()
    
    private func setContentView(){
        view.backgroundColor = .systemBackground
        view.addSubview(usernameOrEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(headerView)
        view.addSubview(termsConditionButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else { return }
        
        guard let backgroundView = headerView.subviews.first else { return }
        
        backgroundView.frame = headerView.bounds
        
        let logoImageView = UIImageView(image: UIImage(named: "logo_white"))
        headerView.addSubview(logoImageView)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x: headerView.width / 4, y : view.safeAreaInsets.top, width: headerView.width / 2.0, height: headerView.height - view.safeAreaInsets.top)
    }
    
    override func viewDidLayoutSubviews() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/3.0)
        usernameOrEmailField.frame = CGRect(x: 25, y: headerView.bottom + 50, width: view.width - 50, height: 52)
        passwordField.frame = CGRect(x: 25, y: usernameOrEmailField.bottom + 10, width: view.width - 50, height: 52)
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 20, width: view.width - 50, height: 52)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width - 50, height: 52)
        
        termsConditionButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 100, width: view.width - 20, height: 50)
        
        privacyButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 50, width: view.width - 20, height: 50)
        configureHeaderView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        termsConditionButton.addTarget(self, action : #selector(termsButtonPressed), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(privacyButtonPressed), for: .touchUpInside)
        

        usernameOrEmailField.delegate = self
        passwordField.delegate = self
        setContentView()
    }
    
    @objc private func loginButtonPressed(){
        usernameOrEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let usernameOrEmail = usernameOrEmailField.text, !usernameOrEmail.isEmpty,
            let passField = passwordField.text, !passField.isEmpty, passField.count >= 8 else {
            return
        }
        
        var username: String? , email: String?
        
        if isValidEmail(email: usernameOrEmail) {
            email = usernameOrEmail
        }else {
            username = usernameOrEmail
        }
        
        AuthManager.loginUser(email: email, username: username, password: passField) { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                }else {
                    let alert = UIAlertController(title: "Login Error", message: "Invalid username or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc private func termsButtonPressed(){
        guard let termsUrl = URL(string: Constants.instagramTermsAndCondition) else { return }
        let webViewVC = SFSafariViewController(url: termsUrl)
        present(webViewVC, animated: true)
    }
    
    @objc private func privacyButtonPressed(){
        guard let privacyUrl = URL(string: Constants.instagramPrivacyPolicy) else { return }
        let privacyVC = SFSafariViewController(url: privacyUrl)
        present(privacyVC, animated: true)
    }
    
    @objc private func createAccountButtonPressed(){
        present(RegisterViewController(), animated: true)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

}


extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameOrEmailField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField {
            loginButtonPressed()
        }
        return true
    }
}
