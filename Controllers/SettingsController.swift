//
//  SettingsController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/6/24.
//

import UIKit

class SettingsController: UIViewController {
    
    private let tableView = UITableView()
    
    private var settings : [Setting] = [
        Setting(name: "My Character", image: "character"),
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
        
        setupTableView()
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
        }
        if indexPath.row == settings.count - 1 {
            let startController = StartController()
            startController.navigationItem.setHidesBackButton(true, animated: true)
            navigationController?.pushViewController(startController, animated: true)
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
