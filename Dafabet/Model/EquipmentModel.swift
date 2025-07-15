//
//  RecipeModel.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import Foundation
import SwiftUI

struct EquipmentModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String = ""
    var brand: String = ""
    var size: String = ""
    var weight: String = ""
    var purchaseDate: Date = Date()
    var price: String = ""
    var serviceFrequency: TimeFrequency = .none
    var replacementsFrequency: TimeFrequency = .none
    var usageTracking: EquipmentUsageTracking = .matches
    var condition: EquipmentCondition = .excellent
    var type: EquipmentType = .bat
    var imageData: Data?

    var replacementDate: Date? {
        guard replacementsFrequency != .none else { return nil }
        return replacementsFrequency.nextDate(from: purchaseDate)
    }

    var computedNextMaintenanceDate: Date? {
        let calendar = Calendar.current
        let now = Date()
        let replacement = replacementDate

        var service: Date? = nil
        if serviceFrequency != .none {
            var next = purchaseDate
            while let potential = calendar.date(byAdding: serviceFrequency.interval, to: next),
                  calendar.compare(potential, to: now, toGranularity: .day) == .orderedAscending,
                  replacement == nil || calendar.compare(potential, to: replacement!, toGranularity: .day) == .orderedAscending
            {
                next = potential
            }


            if let nextPotential = calendar.date(byAdding: serviceFrequency.interval, to: next),
               replacement == nil || calendar.compare(nextPotential, to: replacement!, toGranularity: .day) != .orderedDescending {
                service = nextPotential
            }
        }
        switch (service, replacement) {
        case (nil, nil):
            return nil
        case (let s?, nil):
            return s
        case (nil, let r?):
            return r
        case (let s?, let r?):
            return min(s, r)
        }
    }

    var maintenanceStatusText: String {
        let now = Date()

        if let replacement = replacementDate, now > replacement {
            return "Urgent"
        }

        if let next = computedNextMaintenanceDate {
            if Calendar.current.compare(next, to: now, toGranularity: .day) == .orderedSame {
                return "Today"
            }

            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: next, relativeTo: now)
        }

        return ""
    }

    var maintenanceStatusColor: Color {
        let now = Date()
        if let replacement = replacementDate, now > replacement {
            return .redMain
        }
        return .yellowMain
    }

}

enum EquipmentCondition: String, CaseIterable, Codable {
    case excellent = "Excellent"
    case good = "Good"
    case fair = "Fair"
    case poor = "Poor"

    var color: Color {
        switch self {
        case .excellent:
            return .green
        case .good:
            return .white
        case .fair:
            return .orange
        case .poor:
            return .red
        }
    }

    var image: Image {
        switch self {
        case .excellent:
            Image(systemName: "checkmark")
        case .good:
            Image(systemName: "hand.thumbsup.fill")
        case .fair:
            Image(systemName: "exclamationmark")
        case .poor:
            Image(systemName: "xmark")
        }
    }
}

enum EquipmentUsageTracking: String, CaseIterable, Codable {
    case matches = "Matches"
    case practice = "Practice"
    case hours = "Hours"
}

enum TimeFrequency: String, CaseIterable, Codable {
    case none = "None"
    case everyweek = "Every week"
    case everytwoweeks = "Every 2 weeks"
    case everythreeweeks = "Every 3 weeks"
    case everymonth = "Every month"
    case everytwomonths = "Every 2 months"
    case everythreemonths = "Every 3 months"
    case everyfourmonths = "Every 4 months"
    case everyfivemonths = "Every 5 months"
    case everyhalfyear = "Every half year"
    case everyyear = "Every year"

    var interval: DateComponents {
        switch self {
        case .none: return DateComponents()
        case .everyweek: return DateComponents(weekOfYear: 1)
        case .everytwoweeks: return DateComponents(weekOfYear: 2)
        case .everythreeweeks: return DateComponents(weekOfYear: 3)
        case .everymonth: return DateComponents(month: 1)
        case .everytwomonths: return DateComponents(month: 2)
        case .everythreemonths: return DateComponents(month: 3)
        case .everyfourmonths: return DateComponents(month: 4)
        case .everyfivemonths: return DateComponents(month: 5)
        case .everyhalfyear: return DateComponents(month: 6)
        case .everyyear: return DateComponents(year: 1)
        }
    }

    func nextDate(from date: Date) -> Date? {
        Calendar.current.date(byAdding: self.interval, to: date)
    }
}

enum EquipmentType: String, CaseIterable, Codable {
    case bat = "Bat"
    case gloves = "Gloves"
    case shoes = "Shoes"
    case pads = "Pads"
    case helmet = "Helmet"
    case other = "Other"

    var image: Image {
        switch self {
        case .bat:
            Image("bat")
        case .gloves:
            Image("gloves")
        case .shoes:
            Image("shoes")
        case .pads:
            Image("pads")
        case .helmet:
            Image("helmet")
        case .other:
            Image(systemName: "plus")
        }
    }
}
