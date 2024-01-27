//
//  AchievementTableViewCell.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/25/24.
//

import UIKit

class AchievementTableViewCell: UITableViewCell {
    
    private let contentLabel = UILabel()
    
    static let reuse = "SettingTableViewCellReuse"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, completed: Bool) {
        contentLabel.text = name + ": " + String(completed)
    }
    
    private func setupLabel() {
        contentLabel.textColor = .black
        contentLabel.font = .systemFont(ofSize: 15, weight: .medium)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
