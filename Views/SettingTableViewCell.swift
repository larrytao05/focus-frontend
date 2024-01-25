//
//  SettingTableViewCell.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/6/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    private let settingImageView = UIImageView()
    private let settingNameLabel = UILabel()
    
    static let reuse = "SettingTableViewCellReuse"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupImageView()
        
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, image: String) {
        settingImageView.image = UIImage(named: image)
        settingNameLabel.text = name
    }
    
    private func setupImageView() {
        settingImageView.contentMode = .scaleAspectFit
        settingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(settingImageView)
        
        NSLayoutConstraint.activate([
            settingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            settingImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingImageView.widthAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    private func setupLabel() {
        settingNameLabel.textColor = .black
        settingNameLabel.font = .systemFont(ofSize: 15, weight: .medium)
        settingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(settingNameLabel)
        
        NSLayoutConstraint.activate([
            settingNameLabel.leadingAnchor.constraint(equalTo: settingImageView.trailingAnchor, constant: 8),
            settingNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingNameLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
