//
//  User .swift
//  Focus
//
//  Created by Larry Tao on 12/21/23.
//

import Foundation

struct User: Codable {
    var id: Int
    var username: String
    var pfp: String
    var skin: String
    var time: Float
    var lvl: Int
    var sessions: [Session]
}

struct UserResponse: Codable {
    var users: [User]
}
