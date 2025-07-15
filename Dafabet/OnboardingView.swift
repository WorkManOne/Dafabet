//
//  OnboardingView.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var userService: UserService
    @State private var selectedIndex = 0

    var body: some View {
        VStack {
            Image("icon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay {
                    LinearGradient(colors: [.black, .clear, .clear], startPoint: .bottom, endPoint: .top)
                }
                .overlay {
                    VStack {
                        Spacer()
                        Text("Welcome to Your Cricket Journey!")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.bottom)
                    }
                }
            Text("Let's set up your profile and explore the powerful features designed for cricket players like you.")
                .foregroundStyle(.lightGray)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            TabView (selection: $selectedIndex) {
                TipView(image: Image("equipment"), color: .redMain, title: "Equipment Tracker", description: "Monitor your cricket gear condition, maintenance schedules, and replacement timing", items: ["Bat condition monitoring", "Gloves & shoes tracking"])
                    .tag(0)
                TipView(image: Image("calculator"), color: .yellowMain, title: "String Calculator", description: "Find optimal string tension based on your playing style and skill level", items: ["Personalized recommendations", "Playing style analysis"])
                    .tag(1)
                TipView(image: Image("checklist"), color: .redMain, title: "Smart Checklists", description: "Pre-game, training, and custom checklists to keep you prepared", items: ["Match day preparation", "Custom checklist creation"])
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            Spacer()
            HStack {
                Button {
                    userService.isFirstLaunch = false
                } label: {
                    Text("Skip for Now")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .bold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.lightFrame)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Button {
                    if selectedIndex == 2 {
                        userService.isFirstLaunch = false
                    } else {
                        withAnimation {
                            selectedIndex = selectedIndex + 1
                        }
                    }
                } label: {
                    Text(selectedIndex == 2 ? "Get started" : "Next")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .bold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.redMain)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(20)
            .padding(.bottom, 30)
            .background(.darkFrame)
            .clipShape(
                RoundedCorners(corners: [.topLeft, .topRight])
            )
        }
        .ignoresSafeArea()
    }
}

struct TipView: View {
    let image: Image
    let color: Color
    let title: String
    let description: String
    let items: [String]

    var body: some View {
        HStack (alignment: .top) {
            image
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundStyle(color)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.opacity(0.2))
                )
                .padding(.trailing, 5)
            VStack (alignment: .leading) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
                Text(description)
                    .foregroundStyle(.lightGray)
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
                ForEach (items, id: \.self) { item in
                    Text("✓ \(item)")
                        .foregroundStyle(.yellowMain)
                        .font(.system(size: 12))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 1)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .darkFramed()
        .padding(.horizontal, 20)
    }
}

#Preview {
    OnboardingView()
        .background(.black)
        .environmentObject(UserService())
}
