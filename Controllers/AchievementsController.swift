//
//  SettingsController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/6/24.
//

import UIKit

class AchievementsController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let tableView = UITableView()
    
    private var achievements : [Achievement] = [
        Achievement(name: "Log in", completed: false),
        Achievement(name: "Reach level 1", completed: false)
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
        tableView.register(AchievementTableViewCell.self, forCellReuseIdentifier: AchievementTableViewCell.reuse)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

// MARK: - UITableView Delegate

extension AchievementsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - UITableView DataSource

extension AchievementsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AchievementTableViewCell.reuse, for: indexPath) as? AchievementTableViewCell {
            let data = achievements[indexPath.row]
            cell.configure(name: data.name, completed: data.completed)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
