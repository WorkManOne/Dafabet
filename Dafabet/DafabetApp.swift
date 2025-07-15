//
//  DafabetApp.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 11.07.2025.
//

import SwiftUI

@main
struct DafabetApp: App {
    @ObservedObject var userService = UserService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userService)
                .preferredColorScheme(.dark)
                .fullScreenCover(isPresented: .constant(userService.isFirstLaunch)) {
                    OnboardingView()
                        .environmentObject(userService)
                }
//                .onAppear {
//                    calculator.calculateFeeded(feedings: userData.feedings)
//                    NotificationCenter.default.addObserver(
//                        forName: .NSCalendarDayChanged,
//                        object: nil,
//                        queue: .main
//                    ) { _ in
//                        calculator.calculateFeeded(feedings: userData.feedings)
//                    }
//                }
//                .onDisappear {
//                    NotificationCenter.default.removeObserver(self, name: .NSCalendarDayChanged, object: nil)
//                }
        }
    }
}


