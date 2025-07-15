//
//  AddFeedingView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import SwiftUI

struct EditEquipmentView: View {
    let isEditing: Bool
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    @State private var equipment = EquipmentModel()
    @State private var showingDatePicker = false
    @State private var showImagePicker = false
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showSourceSheet = false

    init(equipment: EquipmentModel? = nil) {
        if let equipment = equipment {
            self._equipment = State(initialValue: equipment)
            isEditing = true
        } else {
            self._equipment = State(initialValue: EquipmentModel())
            isEditing = false
        }
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 15) {
                    Text("Equipment Photo")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                        .padding(.top)
                    Button {
                        showSourceSheet = true
                    } label: {
                        ZStack {
                            VStack {
                                Image(systemName: "camera.fill")
                                    .foregroundStyle(.lightGray)
                                    .padding()
                                    .background(
                                        Circle()
                                            .fill(.lightGray.opacity(0.2))
                                    )
                                Text("Tap to add photo")
                                    .foregroundStyle(.lightGray)
                                    .font(.system(size: 14, weight: .medium))
                            }
                            if let data = equipment.imageData, let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                        }
                        .frame(minHeight: 200)
                        .frame(maxWidth: .infinity)
                        .background(.darkFrame)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray, style: .init(lineWidth: 1, dash: [3, 3]))
                        }
                    }
                    .padding(.bottom)
                    Text("Equipment Type")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                    HStack (spacing: 15) {
                        TypePickView(type: .bat, selectedType: $equipment.type)
                        TypePickView(type: .gloves, selectedType: $equipment.type)
                        TypePickView(type: .shoes, selectedType: $equipment.type)
                    }
                    HStack (spacing: 15) {
                        TypePickView(type: .pads, selectedType: $equipment.type)
                        TypePickView(type: .helmet, selectedType: $equipment.type)
                        TypePickView(type: .other, selectedType: $equipment.type)
                    }
                    .padding(.bottom, 20)
                    Text("Equipment Name")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                    TextField("", text: $equipment.name, prompt: Text("e.g., MRF Genius").foregroundColor(.lightGray))
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .regular))
                        .darkFramed(isBordered: true)
                    Text("Brand")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                    TextField("", text: $equipment.brand, prompt: Text("e.g., MRF").foregroundColor(.lightGray))
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .regular))
                        .darkFramed(isBordered: true)
                    HStack (spacing: 15) {
                        VStack (alignment: .leading) {
                            Text("Size")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.white)
                            TextField("", text: $equipment.size, prompt: Text("Enter size").foregroundColor(.lightGray))
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .regular))
                                .darkFramed(isBordered: true)
                        }
                        VStack (alignment: .leading) {
                            Text("Weight")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.white)
                            TextField("", text: $equipment.weight, prompt: Text("Enter count").foregroundColor(.lightGray))
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .regular))
                                .darkFramed(isBordered: true)
                        }
                    }
                    .padding(.bottom)
                    Text("Purchase Information")
                        .font(.system(size: 14))
                        .foregroundStyle(.yellowMain)
                        .padding(.bottom, 5)
                    HStack (spacing: 15) {
                        VStack (alignment: .leading) {
                            Text("Purchase Date")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.lightGray)
                                .multilineTextAlignment(.leading)
                            Button {
                                showingDatePicker = true
                            } label: {
                                Text(formatter.string(from: equipment.purchaseDate))
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .darkFramed(isBordered: true)
                            }

                        }
                        VStack (alignment: .leading) {
                            Text("Price, ₹")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.lightGray)
                            TextField("", text: $equipment.price, prompt: Text("Enter count").foregroundColor(.lightGray))
                                .foregroundStyle(.white)
                                .darkFramed(isBordered: true)
                        }
                    }
                    .padding(.bottom, 20)
                    Text("Maintenance Schedule")
                        .font(.system(size: 14))
                        .foregroundStyle(.yellowMain)
                        .padding(.bottom, 5)
                    Text("Service Frequency")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.lightGray)
                        .multilineTextAlignment(.leading)
                    Menu {
                        ForEach(TimeFrequency.allCases, id: \.self) { frequency in
                            Button(action: {
                                equipment.serviceFrequency = frequency
                            }) {
                                Text(frequency == .none ? "Select a frequency" : frequency.rawValue)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                            }
                        }
                    } label: {
                        HStack {
                            Text(equipment.serviceFrequency == .none ? "Select a frequency" : equipment.serviceFrequency.rawValue)
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .foregroundColor(.white)
                        .darkFramed(isBordered: true)
                    }
                    .padding(.bottom, 5)
                    Text("Replacement Frequency")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.lightGray)
                        .multilineTextAlignment(.leading)
                    Menu {
                        ForEach(TimeFrequency.allCases, id: \.self) { frequency in
                            Button(action: {
                                equipment.replacementsFrequency = frequency
                            }) {
                                Text(frequency == .none ? "Select a frequency" : frequency.rawValue)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                            }
                        }
                    } label: {
                        HStack {
                            Text(equipment.replacementsFrequency == .none ? "Select a frequency" : equipment.replacementsFrequency.rawValue)
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .foregroundColor(.white)
                        .darkFramed(isBordered: true)
                    }
                    Text("Usage Tracking")
                        .font(.system(size: 12))
                        .foregroundStyle(.lightGray)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Button {
                            equipment.usageTracking = .matches
                        } label: {
                            Text("Matches")
                                .font(.system(size: 12))
                                .foregroundStyle(equipment.usageTracking == .matches ? .white : .lightGray)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(equipment.usageTracking == .matches ? .redMain : .lightFrame)
                                )
                                .multilineTextAlignment(.leading)
                        }
                        Button {
                            equipment.usageTracking = .practice
                        } label: {
                            Text("Practice")
                                .font(.system(size: 12))
                                .foregroundStyle(equipment.usageTracking == .practice ? .white : .lightGray)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(equipment.usageTracking == .practice ? .redMain : .lightFrame)
                                )
                                .multilineTextAlignment(.leading)
                        }
                        Button {
                            equipment.usageTracking = .hours
                        } label: {
                            Text("Hours")
                                .font(.system(size: 12))
                                .foregroundStyle(equipment.usageTracking == .hours ? .white : .lightGray)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(equipment.usageTracking == .hours ? .redMain : .lightFrame)
                                )
                                .multilineTextAlignment(.leading)
                        }

                    }
                    .padding(.bottom)
                    Text("Current Condition")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    HStack {
                        ConditionPickView(condition: .excellent, selectedCondition: $equipment.condition)
                        ConditionPickView(condition: .good, selectedCondition: $equipment.condition)
                        ConditionPickView(condition: .fair, selectedCondition: $equipment.condition)
                        ConditionPickView(condition: .poor, selectedCondition: $equipment.condition)
                    }

                }
                .padding(.horizontal, 20)
                .padding(.top, 80)
                .padding(.bottom, 80)
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
                        if isEditing {
                            if let index = userService.equipment.firstIndex(where: { $0.id == equipment.id }) {
                                userService.equipment[index] = equipment
                            }
                        } else {
                            userService.equipment.append(equipment)
                        }
                        dismiss()
                    } label: {
                        Text("Save Equipment")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.redMain)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top)
                .padding(.bottom, getSafeAreaBottom()+8)
                .background(
                    Color(.darkFrame)
                        .clipShape(RoundedCorners(radius: 30, corners: [.topLeft, .topRight]))
                )
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .customHeader(title: isEditing ? "Edit Equipment" : "Add Equipment", isDismiss: true)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .background(.backgroundMain)
        .onAppear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first,
               let nav = window.rootViewController?.children.first as? UINavigationController {
                nav.interactivePopGestureRecognizer?.isEnabled = true
                nav.interactivePopGestureRecognizer?.delegate = nil
            }
        }
        .sheet(isPresented: $showingDatePicker) {
            CustomDatePickerSheet(selectedDate: $equipment.purchaseDate)
        }
        .confirmationDialog("Select Source", isPresented: $showSourceSheet, titleVisibility: .visible) {
            Button("Camera") {
                pickerSource = .camera
                showImagePicker = true
            }
            Button("Photo Library") {
                pickerSource = .photoLibrary
                showImagePicker = true
            }
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: pickerSource) { selectedImage in
                equipment.imageData = selectedImage
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}

struct TypePickView: View {
    let type: EquipmentType
    @Binding var selectedType: EquipmentType

    var body : some View {
        Button {
            selectedType = type
        } label: {
            VStack {
                type.image
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                Text(type.rawValue)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
            }
            .colorFramed(color: selectedType == type ? .redMain : .lightFrame)
        }
    }
}


struct ConditionPickView: View {
    let condition: EquipmentCondition
    @Binding var selectedCondition: EquipmentCondition

    var body : some View {
        Button {
            selectedCondition = condition
        } label: {
            HStack {
                (Text(condition.image) + Text(" ") + Text(condition.rawValue))
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
            }
            .frame(height: 30)
            .colorFramed(color: selectedCondition == condition ? .green : .lightFrame)
        }
    }
}


#Preview {
    EditEquipmentView()
        .environmentObject(UserService())
}
