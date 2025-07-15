//
//  ContentView.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 11.07.2025.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TabView (selection: $selectedTab) {
                    HomeView(navigateListTab: { selectedTab = 1 }, navigateToolTab: { selectedTab = 2 } )
                        .tag(0)
                    ChecklistsView()
                        .tag(1)
                    CalculatorView()
                        .tag(2)
                    ProfileView()
                        .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserService())
}
