//
//  CreateAccountController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/24/24.
//

import UIKit

class CreateAccountController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let usernameText = UITextField()
    
    private let passwordText = UITextField()
    
    private let pfpText = UITextField()
    
    private let loginButton = UIButton()
    
    private let errorMessage = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupTitle()
        setupUsername()
        setupPassword()
        setupPfpText()
        setupButton()
    }
    
    func setupTitle() {
        titleLabel.text = "Create an account"
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.textColor = UIColor.black
        
        view.addSubview(titleLabel)
        
        titleLabel
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor
                .constraint(equalTo:
                                view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.centerXAnchor
                .constraint(equalTo:
                                view.centerXAnchor)
        ])
    }
    
    func setupUsername() {
        usernameText.text = "Username"
        usernameText.textColor = UIColor.black
        usernameText.isOpaque = true
        usernameText.addTarget(self, action: #selector(editUsernameText), for: .editingDidBegin)
        usernameText.borderStyle = .roundedRect
        
        view.addSubview(usernameText)
        
        usernameText
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameText.topAnchor
                .constraint(equalTo: titleLabel.bottomAnchor),
            usernameText.centerXAnchor
                .constraint(equalTo: view.centerXAnchor),
            usernameText.widthAnchor.constraint(equalToConstant: 200),
            usernameText.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupPassword() {
        passwordText.text = "Password"
        passwordText.textColor = UIColor.black
        passwordText.isOpaque = true
        passwordText.addTarget(self, action: #selector(editPasswordText), for: .editingDidBegin)
        passwordText.borderStyle = .roundedRect
        
        view.addSubview(passwordText)
        
        passwordText
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordText.topAnchor
                .constraint(equalTo: usernameText.bottomAnchor),
            passwordText.centerXAnchor
                .constraint(equalTo: view.centerXAnchor),
            passwordText.widthAnchor.constraint(equalToConstant: 200),
            passwordText.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupPfpText() {
        pfpText.text = "Profile Picture (Optional)"
        pfpText.textColor = UIColor.black
        pfpText.isOpaque = true
        pfpText.addTarget(self, action: #selector(editPfpText), for: .editingDidBegin)
        pfpText.borderStyle = .roundedRect
        
        view.addSubview(pfpText)
        
        pfpText
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pfpText.topAnchor
                .constraint(equalTo: passwordText.bottomAnchor),
            pfpText.centerXAnchor
                .constraint(equalTo: view.centerXAnchor),
            pfpText.widthAnchor.constraint(equalToConstant: 200),
            pfpText.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton() {
        loginButton.setTitle("Create Account", for: .normal)
        loginButton.setTitleColor(.systemBackground, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(pushLoginVC), for: .touchUpInside)
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: pfpText.bottomAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func editUsernameText() {
        usernameText.isOpaque = false
        usernameText.text = ""
    }
    
    @objc private func editPasswordText() {
        passwordText.isOpaque = false
        passwordText.text = ""
    }
    
    @objc private func editPfpText() {
        pfpText.isOpaque = false
        pfpText.text = ""
    }
    
    func setupErrorMessage() {
        errorMessage.text = "Username or password invalid"
        errorMessage.textColor = UIColor.red
        errorMessage.font = UIFont.systemFont(ofSize: 20)
        
        view.addSubview(errorMessage)
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessage.topAnchor.constraint(equalTo: loginButton.bottomAnchor)
        ])
    }
    
    @objc private func pushLoginVC() {
        NetworkManager.shared.createUser(username: usernameText.text!, password: passwordText.text!, pfp: pfpText.text!, skin: "default") { [weak self] user in
            guard let self = self else { return }
            LoginController.user_id = user.id
            print(LoginController.user_id)
            DispatchQueue.main.async {
                // Perform UI updates such as...
                let loginController = LoginController()
                loginController.navigationItem.setHidesBackButton(true, animated: true)
                self.navigationController?.pushViewController(loginController, animated: true)
            }
        }
    }
}
