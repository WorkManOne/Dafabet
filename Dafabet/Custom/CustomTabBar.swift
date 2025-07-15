//
//  CustomTabBar.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            Spacer()
            TabBarButton(icon: Image("home"), title: "Home", index: 0, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image("checklist"), title: "Lists", index: 1, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image("calculator"), title: "Tools", index: 2, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image("profile"), title: "Profile", index: 3, selectedTab: $selectedTab)
            Spacer()
        }
        .padding(.top, 20)
        .padding(.bottom, getSafeAreaTop()+8)
        .background(
            Color(.darkFrame)
                .clipShape(RoundedCorners(radius: 30, corners: [.topLeft, .topRight]))
        )
        .ignoresSafeArea(edges: .bottom)
    }

    private func getSafeAreaTop() -> CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return 44
        }
        return window.safeAreaInsets.bottom
    }
}



struct TabBarButton: View {
    let icon: Image
    let title: String
    let index: Int
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            VStack(spacing: 4) {
                icon
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text(title)
                    .font(.system(size: 12))
            }
            .foregroundColor(selectedTab == index ? .yellowMain : .lightGray)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(selectedTab == index ? .redMain : .clear)
            )
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(0))
        .ignoresSafeArea()
        .background(.black)
}
