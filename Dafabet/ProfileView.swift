//
//  SettingsView.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    @State private var showNotificationAlert = false

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 15) {
                VStack (alignment: .leading){
                    Text("App Settings")
                        .foregroundStyle(.white)
                        .font(.system(size: 18))
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                    HStack {
                        Image("bell")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.lightFrame)
                            )
                        Text("Notifications")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                            .padding(.bottom, 1)
                        Toggle("", isOn: Binding(
                            get: { userService.isNotificationEnabled },
                            set: { newValue in
                                userService.toggleNotifications(to: newValue) {
                                    showNotificationAlert = true
                                }
                            }
                        ))
                        .toggleStyle(CustomToggleStyle())
                    }
                }
                .darkFramed()
                .padding(.bottom)
            }
            .padding(.horizontal, 20)
            .padding(.top, 80)
        }
        .customHeader(title: "Profile")
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .alert("Notifications Disabled", isPresented: $showNotificationAlert) {
            Button("Open Settings") {
                NotificationManager.shared.openAppSettings()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("To enable notifications, please allow them in Settings.")
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserService())
        .background(.black)
}


#Preview {
    NavigationStack {
        NavigationLink("Settings") {
            ProfileView()
                .environmentObject(UserService())
                .background(.black)
        }
    }
}
