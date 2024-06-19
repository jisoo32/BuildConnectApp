

import Foundation

struct Story: Identifiable {
    let id = UUID()
    let user: User
    var hasSeen: Bool = false
    var isMyStory: Bool = false
}
