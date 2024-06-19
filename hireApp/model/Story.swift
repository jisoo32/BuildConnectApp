//
//  File.swift
//  hireApp
//
//  Created by snlcom on 6/12/24.
//

import Foundation

struct Story: Identifiable {
    let id = UUID()
    let user: User
    var hasSeen: Bool = false
    var isMyStory: Bool = false
}
