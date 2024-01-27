//
//  CharacterController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/6/24.
//

import UIKit

class CharacterController: UIViewController {
    
    let titleLabel = UILabel()
    
    let characterImage = UIImageView()
    
    let levelLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupTitleLabel()
        setupCharacterImage()
        setupLevelLabel()
    }
    
    func setupTitleLabel() {
        titleLabel.text = "My Character"
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.textColor = UIColor.black
        
        view.addSubview(titleLabel)
        
        titleLabel
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupCharacterImage() {
        characterImage.image = UIImage(named: "ninja")
        characterImage.layer.cornerRadius = 10
        characterImage.layer.masksToBounds = true
        
        view.addSubview(characterImage)
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            characterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: 256),
            characterImage.widthAnchor.constraint(equalToConstant: 256)
        ])
    }
    
    func setupLevelLabel() {
        NetworkManager.shared.fetchUser(user_id: LoginController.user_id)
            { [weak self] user in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        // Perform UI updates such as...
                        self.levelLabel.text = "Level: " + String(user.lvl)
                    }
        }
        levelLabel.font = UIFont.systemFont(ofSize: 24)
        levelLabel.textColor = UIColor.black
        
        view.addSubview(levelLabel)
        
        levelLabel
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            levelLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 24),
            levelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
