//
//  UserDataModel.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import Foundation
import SwiftUI

class UserService: ObservableObject {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    @AppStorage("isNotificationEnabled") var isNotificationEnabled: Bool = false

    @Published var equipment: [EquipmentModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(equipment), forKey: "equipment")
        }
    }
    @Published var checklists: [ChecklistModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(checklists), forKey: "checklists")
        }
    }
    @Published var calculator: CalculatorModel {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(calculator), forKey: "calculator")
        }
    }

    init() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "equipment"),
           let decoded = try? JSONDecoder().decode([EquipmentModel].self, from: data) {
            equipment = decoded
        } else {
            equipment = []
        }
        if let data = userDefaults.data(forKey: "checklists"),
           let decoded = try? JSONDecoder().decode([ChecklistModel].self, from: data) {
            checklists = decoded
        } else {
            checklists = [
                ChecklistModel(name: "Match Day", type: .default),
                ChecklistModel(name: "Training Session", type: .default),
                ChecklistModel(name: "Training with Fee", type: .default)
            ]
        }
        if let data = userDefaults.data(forKey: "calculator"),
           let decoded = try? JSONDecoder().decode(CalculatorModel.self, from: data) {
            calculator = decoded
        } else {
            calculator = CalculatorModel()
        }
    }

    func reset() {
        isFirstLaunch = true
        isNotificationEnabled = false
        equipment = []
        checklists = []
    }

    func toggleNotifications(to newValue: Bool, onDenied: @escaping () -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .denied:
                    onDenied()
                    self.isNotificationEnabled = false
                    NotificationManager.shared.removeScheduledNotifications()

                case .notDetermined:
                    NotificationManager.shared.requestPermission { granted in
                        DispatchQueue.main.async {
                            self.isNotificationEnabled = granted && newValue
                            if self.isNotificationEnabled {
                                NotificationManager.shared.scheduleNotification()
                            } else {
                                NotificationManager.shared.removeScheduledNotifications()
                            }
                        }
                    }

                case .authorized, .provisional, .ephemeral:
                    self.isNotificationEnabled = newValue
                    if newValue {
                        NotificationManager.shared.scheduleNotification() // << Здесь — если включено
                    } else {
                        NotificationManager.shared.removeScheduledNotifications()
                    }

                @unknown default:
                    self.isNotificationEnabled = false
                    NotificationManager.shared.removeScheduledNotifications()
                }
            }
        }
    }

}
