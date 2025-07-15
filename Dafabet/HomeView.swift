//
//  HomeView.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 11.07.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userService: UserService
    let navigateListTab: () -> Void
    let navigateToolTab: () -> Void
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 15) {
                VStack {
                    HStack {
                        Text("Player Stats")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                        Spacer()
//                        Text("This Month")
//                            .font(.system(size: 12))
//                            .foregroundStyle(.yellowMain)
                    }
                    HStack {
                        VStack {
                            Text("Matches")
                                .font(.system(size: 12))
                                .foregroundStyle(.lightGray)
                            Text("\(userService.equipment.count(where: {$0.usageTracking == .matches } ))")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                        }
                        .lightFramed()
                        VStack {
                            Text("Practice")
                                .font(.system(size: 12))
                                .foregroundStyle(.lightGray)
                            Text("\(userService.equipment.count(where: {$0.usageTracking == .practice } ))")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                        }
                        .lightFramed()
                        VStack {
                            Text("Hours")
                                .font(.system(size: 12))
                                .foregroundStyle(.lightGray)
                            Text("\(userService.equipment.count(where: {$0.usageTracking == .hours } ))")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                        }
                        .lightFramed()
                    }
                }
                .darkFramed()
                HStack {
                    Text("Equipment Tracker")
                        .font(.system(size: 18))
                        .foregroundStyle(.white)
                    Spacer()
                    NavigationLink {
                        EditEquipmentView()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add")
                        }
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.redMain)
                        )
                    }
                }
                LazyVStack(spacing: 10) {
                    ForEach(userService.equipment) { equipment in
                        NavigationLink {
                            EditEquipmentView(equipment: equipment)
                        } label: {
                            EquipmentPreView(equipment: equipment)
                        }
                        .contextMenu {
                            Button {
                                withAnimation {
                                    if let index = userService.equipment.firstIndex(where: { $0.id == equipment.id } ) {
                                        userService.equipment.remove(at: index)
                                    }
                                }
                            } label: {
                                Text("Delete")
                            }
                        }
                    }
                }
                HStack {
                    Text("Checklists")
                        .font(.system(size: 18))
                        .foregroundStyle(.white)
                    Spacer()
                    Button {
                        withAnimation {
                            navigateListTab()
                        }
                    } label: {
                        HStack {
                            Text("View All")
                            Image(systemName: "chevron.right")

                        }
                        .font(.system(size: 12))
                        .foregroundStyle(.yellowMain)
                    }
                }
                LazyVStack(spacing: 10) {
                    ForEach(userService.checklists.prefix(2)) { checklist in
                        if let index = userService.checklists.firstIndex(where: { $0.id == checklist.id }) {
                            NavigationLink {
                                ChecklistDetailView(checklist: $userService.checklists[index])
                            } label: {
                                VStack {
                                    HStack (alignment: .top) {
                                        VStack (alignment: .leading) {
                                            Text(checklist.name)
                                                .font(.system(size: 16))
                                                .foregroundStyle(.white)
                                                .padding(.bottom, 1)
                                                .padding(.top, 3)
                                                .multilineTextAlignment(.leading)
                                            Text("\(checklist.items.count) items")
                                                .font(.system(size: 12))
                                                .foregroundStyle(.lightGray)
                                        }
                                        Spacer()
                                        Text("\(checklist.items.count(where: { $0.isCompleted } ))/\(checklist.items.count)")
                                            .font(.system(size: 16))
                                            .foregroundStyle(checklist.items.count(where: { $0.isCompleted } ) == checklist.items.count ? .black : .white)
                                            .padding()
                                            .background {
                                                Circle()
                                                    .fill(checklist.items.count(where: { $0.isCompleted } ) == checklist.items.count ? .yellowMain : .redMain)
                                            }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .darkFramed()
                            }
                        }
                    }
                    NavigationLink {
                        EditChecklistView()
                    } label: {
                        HStack {
                            (Text(Image(systemName: "plus")) +  Text(" Create Custom Checklist"))
                                .font(.system(size: 16))
                                .foregroundStyle(.lightGray)
                                .frame(minHeight: 80)
                                .frame(maxWidth: .infinity)
                                .background(.darkFrame)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, style: .init(lineWidth: 1, dash: [3, 3]))
                                }
                        }
                    }
                    HStack {
                        VStack (alignment: .leading, spacing: 15) {
                            Text("String Calculator")
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                            Text("Find your perfect tension based on your play style")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            Button {
                                withAnimation {
                                    navigateToolTab()
                                }
                            } label: {
                                Text("Calculate Now")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.black)
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.yellowMain)
                                    )
                            }
                        }
                        Spacer()
                        Image("calculator")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(colors: [.redMain, .darkFrame], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 80)
            .padding(.bottom, 90)
        }
        .customHeader(title: "Home")
        .background(.backgroundMain)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")

    }
}

#Preview {
    HomeView(navigateListTab: {}, navigateToolTab: {})
        .environmentObject(UserService())
}
