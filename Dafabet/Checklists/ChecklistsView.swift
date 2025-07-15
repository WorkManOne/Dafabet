//
//  RecipesView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import SwiftUI

enum ChecklistFilter: String, CaseIterable {
    case all = "All"
    case `default` = "Default"
    case custom = "Custom"
}

struct ChecklistsView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    @State private var selectedFilter: ChecklistFilter = .all

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 10) {
                    if selectedFilter == .all || selectedFilter == .default {
                        Text("Default Checklists")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(userService.checklists.filter { $0.type == .default }) { checklist in
                            if let index = userService.checklists.firstIndex(where: { $0.id == checklist.id }) {
                                NavigationLink {
                                    ChecklistDetailView(checklist: $userService.checklists[index])
                                } label: {
                                    ChecklistPreView(checklist: checklist)
                                }
                            }
                        }
                    }
                    if selectedFilter == .all || selectedFilter == .custom {
                        Text("Custom Checklists")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(userService.checklists.filter { $0.type == .custom }) { checklist in
                            if let index = userService.checklists.firstIndex(where: { $0.id == checklist.id }) {
                                NavigationLink {
                                    ChecklistDetailView(checklist: $userService.checklists[index])
                                } label: {
                                    ChecklistPreView(checklist: checklist)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 120)
                .padding(.bottom, 200)
            }
            VStack {
                HStack {
                    ForEach(ChecklistFilter.allCases, id: \.self) { filter in
                        Button {
                            withAnimation {
                                selectedFilter = filter
                            }
                        } label: {
                            Text(filter.rawValue)
                                .font(.system(size: 14))
                                .foregroundStyle(selectedFilter == filter ? .white : .lightGray)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(
                                    Capsule()
                                        .fill(selectedFilter == filter ? .redMain : .lightFrame)
                                )
                        }
                    }
                }
                .padding(.top, 70)
                .shadow(color: .darkFrame, radius: 15)
                .shadow(color: .darkFrame, radius: 15)
                Spacer()
                HStack {
                    NavigationLink {
                        EditChecklistView()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .foregroundStyle(.yellowMain)
                                .font(.system(size: 16))
                            Text("Create New Checklist")
                                .foregroundStyle(.white)
                                .font(.system(size: 16))
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(colors: [.redMain, .darkFrame], startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 90)
                }
            }
        }
        .customHeader(title: "Checklists")
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .onAppear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first,
               let nav = window.rootViewController?.children.first as? UINavigationController {
                nav.interactivePopGestureRecognizer?.isEnabled = true
                nav.interactivePopGestureRecognizer?.delegate = nil
            }
        }
        .background(.backgroundMain)
    }

}

#Preview {
    ChecklistsView()
        .environmentObject(UserService())
}
