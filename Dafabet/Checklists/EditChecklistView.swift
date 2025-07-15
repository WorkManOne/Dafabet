//
//  AddRecipeView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import SwiftUI

struct EditChecklistView: View {
    let isEditing: Bool
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    @State private var checklist = ChecklistModel()
    @State private var isEditingItem = false

    init(checklist: ChecklistModel? = nil) {
        if let checklist = checklist {
            self._checklist = State(initialValue: checklist)
            isEditing = true
        } else {
            self._checklist = State(initialValue: ChecklistModel())
            isEditing = false
        }
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 15) {
                    Text("Checklist Name")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                    if checklist.type == .default {
                        Text(checklist.name)
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .darkFramed()
                            .padding(.bottom, 20)
                    } else {
                        TextField("", text: $checklist.name, prompt: Text("Pre-Match Preparation").foregroundColor(.lightGray))
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.lightFrame)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray)
                            }
                            .padding(.bottom, 20)
                    }
                    HStack {
                        Text("Checklist Items")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(checklist.items.count) items")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom, 5)
                    ForEach (Array(checklist.items.enumerated()), id: \.element.id) { index, item in
                        VStack (alignment: .leading) {
                            HStack {
                                Button {
                                    withAnimation {
                                        guard index < checklist.items.count else { return }
                                        checklist.items[index].isCompleted.toggle()
                                    }
                                } label: {
                                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(item.isCompleted ? .yellowMain : .redMain)
                                        .font(.system(size: 20))
                                }
                                VStack (alignment: .leading) {
                                    if item.isEditing {
                                        TextField("", text: Binding(
                                            get: { checklist.items[index].name },
                                            set: { checklist.items[index].name = $0 }
                                        ), prompt: Text("Item Name").foregroundColor(.lightGray))
                                        .foregroundStyle(.white)
                                        .font(.system(size: 16))
                                        .lightFramed()
                                    } else {
                                        Text(item.name)
                                            .foregroundStyle(.white)
                                            .font(.system(size: 16))
                                            .padding(.bottom, 4)
                                    }
                                    if item.isEditing {
                                        TextField("", text: Binding(
                                            get: { checklist.items[index].description },
                                            set: { checklist.items[index].description = $0 }
                                        ), prompt: Text("Item Description").foregroundColor(.lightGray), axis: .vertical)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 12))
                                        .lightFramed()
                                    } else {
                                        Text(item.description)
                                            .foregroundStyle(.lightGray)
                                            .font(.system(size: 12))
                                    }
                                }
                                Spacer()
                                Button {
                                    withAnimation {
                                        guard index < checklist.items.count else { return }
                                        checklist.items[index].isEditing.toggle()
                                    }
                                } label: {
                                    Image("pencil")
                                        .resizable()
                                        .renderingMode(.template)
                                        .frame(width: 15, height: 15)
                                        .foregroundStyle(.yellowMain)
                                }
                                Button {
                                    withAnimation {
                                        guard index < checklist.items.count else { return }
                                        checklist.items.remove(at: index)
                                    }
                                } label: {
                                    Image("trashcan")
                                        .resizable()
                                        .renderingMode(.template)
                                        .frame(width: 15, height: 15)
                                        .foregroundStyle(.redMain)
                                }
                            }
                            .padding(.bottom, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .darkFramed(isBordered: true)
                        .padding(.vertical, 3)
                    }
                    Button {
                        withAnimation {
                            checklist.items.append(ChecklistItemModel())
                        }
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add New Item")
                        }
                        .font(.system(size: 16))
                        .foregroundStyle(.lightGray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.lightFrame)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, style: .init(lineWidth: 1, dash: [3, 3]))
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 80)

            }
            VStack {
                Spacer()
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.lightFrame)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Button {
                        for index in 0..<checklist.items.count {
                            checklist.items[index].isEditing = false
                        }
                        if isEditing {
                            if let index = userService.checklists.firstIndex(where: { $0.id == checklist.id }) {
                                userService.checklists[index] = checklist
                            }
                        } else {
                            userService.checklists.append(checklist)
                        }
                        dismiss()
                    } label: {
                        Text("Save Checklist")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.redMain)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal, 5)
                .padding(.bottom, 20)
                .darkFramed()
            }
            .ignoresSafeArea()
        }
        .customHeader(title: isEditing ? "Edit Checklist" : "Create New Checklist", isDismiss: true)
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
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}


#Preview {
    EditChecklistView()
        .environmentObject(UserService())
}
