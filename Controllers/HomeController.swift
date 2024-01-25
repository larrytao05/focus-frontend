//
//  LoginController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/23/24.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: Properties(view)
    
    private let nameLabel = UILabel()
    
    private let profileImageView = UIImageView()
    
    private let startButton = UIButton()
    
    private let settingsButton = UIButton()

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        

        setupProfileImage()
        setupLabel()
        setupStartButton()
        setupSettingsButton()
    }

    func setupLabel() {
        nameLabel.text = "Welcome"
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        nameLabel.textColor = UIColor.black
        
        view.addSubview(nameLabel)
        
        nameLabel
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor
                .constraint(equalTo:
                                profileImageView.bottomAnchor),
            nameLabel.centerXAnchor
                .constraint(equalTo:
                view.centerXAnchor)
        ])
    }
    
    func setupProfileImage() {
        profileImageView.image = UIImage(named: "ninja")
        profileImageView.layer.cornerRadius = 10
        profileImageView.layer.masksToBounds = true
        
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 24),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 256),
            profileImageView.widthAnchor.constraint(equalToConstant: 256)
        ])
    }
    
    func setupStartButton() {
        startButton.setTitle("Start Focusing", for: .normal)
        startButton.setTitleColor(.systemBackground, for: .normal)
        startButton.backgroundColor = .black
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(pushStartVC), for: .touchUpInside)
        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func pushStartVC() {
        NetworkManager.shared.createSession(user_id: LoginController.user_id) { [weak self] user in
            guard self != nil else {return}
        }
        let sessionController = SessionController()
        sessionController.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.pushViewController(sessionController, animated: true)
    }
    
    func setupSettingsButton() {
        settingsButton.setImage(UIImage(named: "menu"), for: .normal)
        settingsButton.addTarget(self, action: #selector(pushSettingsVC), for: .touchUpInside)
        
        view.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),
            settingsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func pushSettingsVC() {
        let settingsController = SettingsController()
        navigationController?.pushViewController(settingsController, animated: true)
    }
}
