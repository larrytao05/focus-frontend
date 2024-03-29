//
//  SettingsController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/6/24.
//

import UIKit

class SettingsController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let tableView = UITableView()
    
    private var settings : [Setting] = [
        Setting(name: "My Character", image: "ninja"),
        Setting(name: "History", image: "clock"),
        Setting(name: "Friends", image: "friend"),
        Setting(name: "Achievements", image: "achievement"),
        Setting(name: "Settings", image: "settings"),
        Setting(name: "Log out", image: "logout")
    ]
    
    
    // Things to include: Character, History, Friends, Achievements, Settings
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        setupTitleLabel()
        setupTableView()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Achievements"
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.textColor = UIColor.black
        
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuse)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let characterController = CharacterController()
            navigationController?.pushViewController(characterController, animated: true)
        } else if indexPath.row == settings.count - 1 {
            let startController = StartController()
            startController.navigationItem.setHidesBackButton(true, animated: true)
            navigationController?.pushViewController(startController, animated: true)
        } else if indexPath.row == 1 {
            let historyController = HistoryController()
            navigationController?.pushViewController(historyController, animated: true)
        } else if indexPath.row == 3 {
            let achievementsController = AchievementsController()
            navigationController?.pushViewController(achievementsController, animated: true)
        } else if indexPath.row == 2 {
            let friendController = FriendController()
            navigationController?.pushViewController(friendController, animated: true)
        }
    }
    
}

// MARK: - UITableView Delegate

extension SettingsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - UITableView DataSource

extension SettingsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuse, for: indexPath) as? SettingTableViewCell {
            let data = settings[indexPath.row]
            cell.configure(name: data.name, image: data.image)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
