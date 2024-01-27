//
//  HistoryController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/25/24.
//

import UIKit

class HistoryController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let sessionsLabel = UILabel()
    
    private let totalTimeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        NetworkManager.shared.fetchUser(user_id: LoginController.user_id)
            { [weak self] user in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        // Perform UI updates such as...
                        self.setupTitleLabel()
                        self.setupSessionsLabel(text: String(user.sessions.count))
                        self.setupTotalTimeLabel(text: String(user.time))
                    }
        }
    }
    
    func setupTitleLabel() {
        titleLabel.text = "My History"
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
    
    func setupSessionsLabel(text: String) {
        sessionsLabel.text = "Total sessions: " + text
        sessionsLabel.font = UIFont.systemFont(ofSize: 24)
        sessionsLabel.textColor = UIColor.black
        
        view.addSubview(sessionsLabel)
        
        sessionsLabel
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sessionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            sessionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupTotalTimeLabel(text: String) {
        totalTimeLabel.text = "Total time focused: " + text
        totalTimeLabel.font = UIFont.systemFont(ofSize: 24)
        totalTimeLabel.textColor = UIColor.black
        
        view.addSubview(totalTimeLabel)
        
        totalTimeLabel
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalTimeLabel.topAnchor.constraint(equalTo: sessionsLabel.bottomAnchor, constant: 24),
            totalTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
