//
//  SettingsController.swift
//  FocusFrontend
//
//  Created by Larry Tao on 1/6/24.
//

import UIKit

class FriendController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let tableView = UITableView()
    
    private let requestsButton = UIButton(type: .system)
    
    private let friendsButton = UIButton(type: .system)
    
    private let addFriendButton = UIButton(type: .system)
    
    private let requestsView = UITableView()
    
    private var friends : [Setting] = [
        Setting(name:"Friend 1", image:"ninja")
    ]
    
    private var requests: [Setting] = [
        Setting(name: "Friend 2", image: "ninja")
    ]
    
    private var displayingFriends = true
    
    private let acceptRequestButton = UIButton(type: .custom)
    
    private let rejectRequestButton = UIButton(type: .custom)
    
    private var sender = ""
    
    private let usernameText = UITextField()
    
    private let sendRequestButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        setupTitleLabel()
        setupFriendsButton()
        setupRequestsButton()
        setupAddFriendButton()
        setupTableView()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Friends"
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.textColor = UIColor.black
        
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func setupUsername() {
        usernameText.text = "Username"
        usernameText.textColor = UIColor.black
        usernameText.isOpaque = true
        usernameText.addTarget(self, action: #selector(editUsernameText), for: .editingDidBegin)
        usernameText.borderStyle = .roundedRect
        
        view.addSubview(usernameText)
        
        usernameText
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameText.topAnchor
                .constraint(equalTo: friendsButton.bottomAnchor, constant: 24),
            usernameText.centerXAnchor
                .constraint(equalTo: view.centerXAnchor),
            usernameText.widthAnchor.constraint(equalToConstant: 200),
            usernameText.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func editUsernameText() {
        usernameText.isOpaque = false
        usernameText.text = ""
    }
    
    private func setupFriendsButton() {
        friendsButton.setTitle("Friends", for: .normal)
        friendsButton.setTitleColor(.black, for: .normal)
        friendsButton.backgroundColor = .systemBackground
        friendsButton.layer.cornerRadius = 10
        friendsButton.addTarget(self, action: #selector(displayFriends), for: .touchUpInside)
        
        view.addSubview(friendsButton)
        friendsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = NSLayoutConstraint(item: friendsButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1/3, constant: 0)
        trailingConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            friendsButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            friendsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    @objc private func displayFriends() {
        displayingFriends = true
        requestsView.removeFromSuperview()
        acceptRequestButton.removeFromSuperview()
        rejectRequestButton.removeFromSuperview()
        usernameText.removeFromSuperview()
        sendRequestButton.removeFromSuperview()
        setupTableView()
    }
    
    private func setupRequestsButton() {
        requestsButton.setTitle("Requests", for: .normal)
        requestsButton.setTitleColor(.black, for: .normal)
        requestsButton.backgroundColor = .systemBackground
        requestsButton.layer.cornerRadius = 10
        requestsButton.addTarget(self, action: #selector(displayRequests), for: .touchUpInside)
        
        view.addSubview(requestsButton)
        requestsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = NSLayoutConstraint(item: requestsButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 2/3, constant: 0)
        trailingConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            requestsButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            requestsButton.leadingAnchor.constraint(equalTo: friendsButton.trailingAnchor)
        ])
    }
    
    @objc private func displayRequests() {
        displayingFriends = false
        tableView.removeFromSuperview()
        usernameText.removeFromSuperview()
        sendRequestButton.removeFromSuperview()
        setupRequestsView()
        NetworkManager.shared.fetchUser(user_id: LoginController.user_id) { [weak self] user in
            guard self != nil else { return }
            //requests = user.requests
            }
    }
    
    private func setupAddFriendButton() {
        addFriendButton.setTitle("Add Friend", for: .normal)
        addFriendButton.setTitleColor(.black, for: .normal)
        addFriendButton.backgroundColor = .systemBackground
        addFriendButton.layer.cornerRadius = 10
        addFriendButton.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
        
        view.addSubview(addFriendButton)
        addFriendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addFriendButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            addFriendButton.leadingAnchor.constraint(equalTo: requestsButton.trailingAnchor),
            addFriendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
    @objc private func addFriend() {
        if displayingFriends {
            tableView.removeFromSuperview()
        } else {
            requestsView.removeFromSuperview()
        }
        setupUsername()
        setupSendRequestButton()
    }
    
    private func setupSendRequestButton() {
        sendRequestButton.setTitle("Send Request", for: .normal)
        sendRequestButton.setTitleColor(.systemBackground, for: .normal)
        sendRequestButton.backgroundColor = .black
        sendRequestButton.layer.cornerRadius = 10
        sendRequestButton.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        
        view.addSubview(sendRequestButton)
        sendRequestButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sendRequestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendRequestButton.topAnchor.constraint(equalTo: usernameText.bottomAnchor, constant: 24),
            sendRequestButton.widthAnchor.constraint(equalToConstant: 200),
            sendRequestButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func sendRequest() {
        var username = ""
        NetworkManager.shared.fetchUser(user_id: LoginController.user_id)  { [weak self] user in
            guard self != nil else { return }
            username = user.username
        }
        NetworkManager.shared.addFriend(sender: username, receiver: usernameText.text!) { [weak self] user in
            guard self != nil else { return }
            }
    }
    
    private func setupTableView() {
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuse)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: friendsButton.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupRequestsView() {
        requestsView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuse)
        requestsView.dataSource = self
        requestsView.delegate = self
        
        view.addSubview(requestsView)
        requestsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            requestsView.topAnchor.constraint(equalTo: friendsButton.bottomAnchor),
            requestsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            requestsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            requestsView.trailingAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupAcceptButton(indexPath: IndexPath) {
        acceptRequestButton.frame = CGRect(origin: requestsView.cellForRow(at: indexPath)!.frame.origin, size: CGSize(width: 40, height: 40))
        acceptRequestButton.layer.cornerRadius = 10
        acceptRequestButton.layer.borderWidth = 5
        acceptRequestButton.clipsToBounds = true
        acceptRequestButton.layer.borderColor = UIColor.green.cgColor
        // acceptRequestButton.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
        acceptRequestButton.addTarget(self, action: #selector(acceptRequest), for: .touchUpInside)
        
        view.addSubview(acceptRequestButton)
        acceptRequestButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            acceptRequestButton.centerYAnchor.constraint(equalTo: requestsView.cellForRow(at: indexPath)!.centerYAnchor),
            acceptRequestButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 24)
        ])

    }
    
    private func setupRejectButton(indexPath: IndexPath) {
        rejectRequestButton.frame = CGRect(origin: requestsView.cellForRow(at: indexPath)!.frame.origin, size: CGSize(width: 40, height: 40))
        rejectRequestButton.layer.cornerRadius = 10
        rejectRequestButton.layer.borderWidth = 5
        rejectRequestButton.clipsToBounds = true
        rejectRequestButton.layer.borderColor = UIColor.red.cgColor
        // acceptRequestButton.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
        rejectRequestButton.addTarget(self, action: #selector(rejectRequest), for: .touchUpInside)
        
        view.addSubview(rejectRequestButton)
        rejectRequestButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rejectRequestButton.centerYAnchor.constraint(equalTo: acceptRequestButton.centerYAnchor),
            rejectRequestButton.leadingAnchor.constraint(equalTo: acceptRequestButton.trailingAnchor, constant: 24)
        ])
    }
    
    @objc private func acceptRequest() {
//        NetworkManager.shared.acceptFriendRequest(sender: <#T##String#>, receiver: <#T##String#>, completion: <#T##(User) -> Void#>)
    }
    
    @objc private func rejectRequest() {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.requestsView {
            self.sender = requests[indexPath.row].name
            setupAcceptButton(indexPath: indexPath)
            setupRejectButton(indexPath: indexPath)
        }

    }
    
}

// MARK: - UITableView Delegate

extension FriendController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - UITableView DataSource

extension FriendController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return friends.count
        }
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuse, for: indexPath) as? SettingTableViewCell {
            var data: Setting;
            if tableView == self.tableView {
                data = friends[indexPath.row]
            } else {
                data = requests[indexPath.row]
            }
            cell.configure(name: data.name, image: data.image)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
