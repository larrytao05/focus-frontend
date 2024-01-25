//
//  SessionController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/6/24.
//

import UIKit

class SessionController: UIViewController {
    
    let profileImageView = UIImageView()
    
    let stopButton = UIButton()
    
    let timerLabel = UILabel()
    
    var timer = Timer()
    
    var timerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        setupProfileImage()
        
        setupTimerLabel()
        
        setupStopButton()
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
    
    func setupStopButton() {
        stopButton.setTitle("Stop Focusing", for: .normal)
        stopButton.setTitleColor(.systemBackground, for: .normal)
        stopButton.backgroundColor = .black
        stopButton.layer.cornerRadius = 10
        stopButton.addTarget(self, action: #selector(pushHomeVC), for: .touchUpInside)
        
        view.addSubview(stopButton)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 200),
            stopButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupTimerLabel() {
        timerLabel.text = "00:00:00"
        timerLabel.font = UIFont.systemFont(ofSize: 24)
        timerLabel.textColor = UIColor.black
        
        view.addSubview(timerLabel)
        
        timerLabel
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor
                .constraint(equalTo:
                                profileImageView.bottomAnchor),
            timerLabel.centerXAnchor
                .constraint(equalTo:
                view.centerXAnchor)
        ])
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        timerCount = timerCount + 1
        let time = secondsToHoursMinutesSeconds(seconds: timerCount)
        updateTimerLabel(hours: time.0, minutes: time.1, seconds: time.2)
    }
    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60))
    }
    
    private func updateTimerLabel(hours: Int, minutes: Int, seconds: Int) {
        var timeString = ""
        timeString += String(format: "%2d", hours)
        timeString += " : "
        timeString += String(format: "%2d", minutes)
        timeString += " : "
        timeString += String(format: "%2d", seconds)
        timerLabel.text = timeString
    }
    
    @objc private func pushHomeVC() {
        NetworkManager.shared.endSession(user_id: LoginController.user_id) { [weak self] user in
            guard self != nil else {return}
        }
        let homeController = HomeController()
        homeController.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.pushViewController(homeController, animated: true)
        timer.invalidate()
    }
}
