//
//  RecipePreView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 28.06.2025.
//

import SwiftUI

struct ChecklistPreView: View {
    @EnvironmentObject var userService: UserService
    var checklist: ChecklistModel

    var body: some View {
        VStack {
            HStack (alignment: .top) {
                if checklist.type == .default {
                    if checklist.name == "Match Day" {
                        Image("trofy")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.white)
                            .frame(width: 25, height: 25)
                            .padding()
                            .background(
                                Circle()
                                    .fill(.redMain)
                            )
                    } else if checklist.name == "Training Session" {
                        Image("gantel")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.black)
                            .frame(width: 25, height: 25)
                            .padding()
                            .background(
                                Circle()
                                    .fill(.yellowMain)
                            )
                    } else {
                        Image("money")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.yellowMain)
                            .frame(width: 25, height: 25)
                            .padding()
                            .background(
                                Circle()
                                    .fill(.lightFrame)
                            )
                    }
                } else {
                    Text(checklist.name.initials)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            Circle()
                                .fill(
                                    LinearGradient(colors: [.redMain, .yellowMain], startPoint: .leading, endPoint: .trailing)
                                )
                        )
                }

                VStack (alignment: .leading) {
                    Text(checklist.name)
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                        .padding(.bottom, 1)
                        .padding(.top, 3)
                        .multilineTextAlignment(.leading)
                    Text("\(checklist.items.count) items")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                }
                Spacer()
                VStack (alignment: .trailing) {
                    Text(checklist.type.rawValue)
                        .font(.system(size: 12))
                        .foregroundStyle(checklist.type == .default ? .white : .redMain)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(checklist.type == .default ? .lightFrame : .redMain.opacity(0.2))
                        )
                    CustomProgressBar(progress: Double(checklist.items.count(where: { $0.isCompleted } )) / Double(checklist.items.count == 0 ? 1 : checklist.items.count))
                        .frame(width: 70)
                    Text("\(checklist.items.count(where: { $0.isCompleted } ))/\(checklist.items.count) completed")
                        .font(.system(size: 12))
                        .foregroundStyle(.lightGray)
                }
                .padding(.bottom, 5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Rectangle()
                .fill(.lightFrame)
                .frame(height: 1)
                .padding(.bottom, 5)
            HStack {
                if checklist.type == .custom {
                    Button {
                        withAnimation {
                            if let index = userService.checklists.firstIndex(where: { $0.id == checklist.id } ) {
                                userService.checklists.remove(at: index)
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "trash.fill")
                            Text("Delete")
                        }
                        .foregroundStyle(.lightGray)
                        .font(.system(size: 12))
                    }
                }
                Spacer()
                NavigationLink {
                    EditChecklistView(checklist: checklist)
                } label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                        Text("Edit")
                    }
                    .foregroundStyle(.yellowMain)
                    .font(.system(size: 12))
                }
            }
        }
        .darkFramed()
    }
}

#Preview {
    ChecklistPreView(checklist: ChecklistModel(name: "Training with fee", type: .default, items: []))
        .background(.backgroundMain)
}
