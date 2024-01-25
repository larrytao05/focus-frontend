//
//  Session.swift
//  Focus
//
//  Created by Larry Tao on 12/31/23.
//

import Foundation

struct Session: Codable {
    var id: Int
    var start: Float
    var timeElapsed: Float
    var active: Bool
    var user: Int
}

struct SessionResponse: Codable {
    var sessions: [Session]
}
