//
//  StartController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/24/24.
//

import UIKit

class StartController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let createAccountButton = UIButton()
    
    private let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupTitle()
        setupCreateAccountButton()
        setupLoginButton()
    }
    
    func setupTitle() {
        titleLabel.text = "FOCUS"
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
    
    func setupCreateAccountButton() {
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.systemBackground, for: .normal)
        createAccountButton.backgroundColor = .black
        createAccountButton.layer.cornerRadius = 10
        createAccountButton.addTarget(self, action: #selector(pushCreateAccountVC), for: .touchUpInside)
        
        view.addSubview(createAccountButton)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            createAccountButton.widthAnchor.constraint(equalToConstant: 200),
            createAccountButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.systemBackground, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(pushLoginVC), for: .touchUpInside)
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 24),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func pushCreateAccountVC() {
        let createAccountVC = CreateAccountController()
        // createAccountVC.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.pushViewController(createAccountVC, animated: true)
    }
    
    @objc private func pushLoginVC() {
        let loginVC = LoginController()
        // loginVC.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
