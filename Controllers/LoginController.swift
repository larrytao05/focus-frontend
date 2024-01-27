//
//  ViewController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/6/24.
//

import UIKit

class LoginController: UIViewController {
    static var user_id = 1
    
    static var loggedIn = false
    
    private let titleLabel = UILabel()
    
    private let usernameText = UITextField()
    
    private let passwordText = UITextField()
    
    private let loginButton = UIButton()
    
    private let errorMessage = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupTitle()
        setupUsername()
        setupPassword()
        setupButton()
    }
    
    func setupTitle() {
        titleLabel.text = "Log in"
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
                .constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
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
                .constraint(equalTo: usernameText.bottomAnchor, constant: 24),
            passwordText.centerXAnchor
                .constraint(equalTo: view.centerXAnchor),
            passwordText.widthAnchor.constraint(equalToConstant: 200),
            passwordText.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.systemBackground, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(pushHomeVC), for: .touchUpInside)
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 24),
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
    
    @objc private func pushHomeVC() {
        NetworkManager.shared.login(username: usernameText.text ?? "", password: passwordText.text ?? "") { [weak self] user in
                guard let self = self else { return }
            LoginController.user_id = user.id
            DispatchQueue.main.async {
                // Perform UI updates such as...
                let homeController = HomeController()
                homeController.navigationItem.setHidesBackButton(true, animated: true)
                self.navigationController?.pushViewController(homeController, animated: true)
            }
        }
    }
    
}

