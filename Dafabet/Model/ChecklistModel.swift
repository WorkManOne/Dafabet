//
//  FeedingModel.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import Foundation
import SwiftUI

struct ChecklistModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String = ""
    var type: ChecklistType = .custom
    var items: [ChecklistItemModel] = []
}

struct ChecklistItemModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String = ""
    var description: String = ""
    var isCompleted: Bool = false
    var isEditing: Bool = false
}

enum ChecklistType: String, CaseIterable, Codable {
    case `default` = "Default"
    case custom = "Custom"
}
