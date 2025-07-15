//
//  RecipeDetailView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import SwiftUI

struct ChecklistDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var checklist: ChecklistModel

    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading) {
                    HStack {
                        Text("Progress")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(Int(Double(checklist.items.count(where: { $0.isCompleted } )) / Double(checklist.items.count == 0 ? 1 : checklist.items.count) * 100))% Complete")
                            .font(.system(size: 14))
                            .foregroundStyle(.yellowMain)
                    }
                    .animation(.easeOut(duration: 1), value: checklist.items.count(where: { $0.isCompleted }))
                    CustomGradientProgressBar(progress: Double(checklist.items.count(where: { $0.isCompleted } )) / Double(checklist.items.count == 0 ? 1 : checklist.items.count))
                        .animation(.easeOut(duration: 1), value: checklist.items.count(where: { $0.isCompleted }))
                        .padding(.bottom)
                    ForEach(Array(checklist.items.enumerated()), id: \.element.id) { index, item in
                        VStack (alignment: .leading) {
                            HStack {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(item.isCompleted ? .yellowMain : .redMain)
                                    .font(.system(size: 20))
                                VStack (alignment: .leading) {
                                    Text(item.name)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 16))
                                        .strikethrough(item.isCompleted)
                                    Text(item.description)
                                        .foregroundStyle(.lightGray)
                                        .font(.system(size: 12))
                                }
                                .opacity(item.isCompleted ? 0.5 : 1)
                                Spacer()
                                Button {
                                    withAnimation {
                                        checklist.items[index].isCompleted = true
                                    }
                                } label: {
                                    Text(item.isCompleted ? "Completed" : "Mark Done")
                                        .font(.system(size: 12))
                                        .foregroundStyle(item.isCompleted ? .lightGray : .white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background {
                                            RoundedRectangle(cornerRadius: 20).fill(item.isCompleted ? .clear : .redMain)
                                        }
                                }
                                .disabled(item.isCompleted)
                            }
                            .animation(.easeInOut, value: item.isCompleted)
                            .padding(.bottom, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .darkFramed()
                        .padding(.leading, 4)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.yellowMain)
                        }
                        .padding(.vertical, 3)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 90)
            }
            VStack {
                Spacer()
                NavigationLink {
                    EditChecklistView(checklist: checklist)
                } label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.yellowMain)
                        Text("Edit")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.redMain)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 5)
                .padding(.bottom, 20)
                .darkFramed()
            }
            .ignoresSafeArea()
        }
        .customHeader(title: checklist.name, description: "\(checklist.items.count) items • \(checklist.items.count(where: {$0.isCompleted} )) completed", isDismiss: true)
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
    ChecklistDetailView(checklist: .constant(ChecklistModel()))
}
