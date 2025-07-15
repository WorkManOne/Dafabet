//
//  CalculatorModel.swift
//  ChickenFeed
//
//  Created by Кирилл Архипов on 29.06.2025.
//

import Foundation
import SwiftUI

struct CalculatorModel: Codable {
    var isCalculated: Bool = false

    var skillLevel: SkillLevel = .intermediate
    var playingStyle: PlayingStyle = .powerPlayer
    var batWeight: Int = 1150
    var playingConditions: PlayingConditions = .moderate
    var recommendedTensionRange: ClosedRange<Int> {
        var minTension = 20
        var maxTension = 25

        switch skillLevel {
        case .beginner:
            minTension -= 2
            maxTension -= 2
        case .advanced:
            minTension += 2
            maxTension += 2
        default: break
        }

        switch playingStyle {
        case .powerPlayer:
            minTension -= 1
        case .controlPlayer:
            minTension += 1
            maxTension += 1
        default: break
        }

        switch playingConditions {
        case .hot:
            minTension += 1
            maxTension += 1
        case .cold:
            minTension -= 1
            maxTension -= 1
        default: break
        }

        return minTension...maxTension
    }

    var recommendedTensionString: String {
        let range = recommendedTensionRange
        return "\(range.lowerBound)-\(range.upperBound)"
    }

    var fineTuneBase: Int = 450

    var fineTuneGrams: Int {
        switch playingStyle {
        case .powerPlayer:
            return fineTuneBase + 25
        case .controlPlayer:
            return fineTuneBase - 25
        case .finessePlayer:
            return fineTuneBase - 10
        default: return fineTuneBase
        }
    }

    var fineTuneString: String {
        "\(fineTuneGrams)"
    }

    var description: String {
        switch playingStyle {
        case .powerPlayer:
            return "Optimized for aggressive and powerful play"
        case .controlPlayer:
            return "Tuned for control, precision, and consistency"
        case .allrounder:
            return "Balanced setup for all-around performance"
        case .finessePlayer:
            return "Tailored for finesse, touch, and feel"
        }
    }
}

enum SkillLevel: String, Codable {
    case beginner
    case intermediate
    case advanced

    var benefit: String {
        switch self {
        case .beginner:
            return "Forgiving tension for easier control."
        case .intermediate:
            return "Balanced performance for improving skills."
        case .advanced:
            return "Enhanced precision for experienced players."
        }
    }
}

enum PlayingStyle: String, Codable {
    case powerPlayer = "Power Player"
    case controlPlayer = "Control Player"
    case allrounder = "All-Rounder"
    case finessePlayer = "Finesse Player"

    var image: Image {
        switch self {
        case .powerPlayer:
            Image("powerPlayer")
        case .controlPlayer:
            Image("controlPlayer")
        case .allrounder:
            Image("allrounder")
        case .finessePlayer:
            Image("finessePlayer")
        }
    }

    var benefit: String {
        switch self {
        case .powerPlayer:
            return "Maximized power for aggressive shots."
        case .controlPlayer:
            return "Increased control for accurate placement."
        case .allrounder:
            return "Balanced setup for versatile play."
        case .finessePlayer:
            return "Fine touch and feel for tactical shots."
        }
    }
}
enum PlayingConditions: String, Codable {
    case cold = "Cold"
    case moderate = "Moderate"
    case hot = "Hot"

    var image: Image {
        switch self {
        case .cold:
            Image("cold")
        case .moderate:
            Image("moderate")
        case .hot:
            Image("hot")
        }
    }

    var benefit: String {
        switch self {
        case .cold:
            return "Tension optimized for low elasticity."
        case .moderate:
            return "Standard setup for all-around performance."
        case .hot:
            return "Tension compensates for string loosening."
        }
    }
}
