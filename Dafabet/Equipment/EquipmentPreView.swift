//
//  FeedingPreView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import SwiftUI

struct EquipmentPreView: View {
    var equipment: EquipmentModel

    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top) {
                ZStack {
                    Color.black
                    if let data = equipment.imageData, let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack (alignment: .leading, spacing: 10) {
                    Text(equipment.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                    Text(equipment.type.rawValue)
                        .foregroundStyle(.lightGray)
                        .font(.system(size: 12))
                }
                .padding(.top, 7)
                Spacer()
                VStack (alignment: .trailing, spacing: 10) {
                    Text(equipment.condition.rawValue)
                        .foregroundStyle(equipment.condition.color)
                        .font(.system(size: 12))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(equipment.condition.color.opacity(0.2))
                        )
                    Text("Used for \(equipment.purchaseDate.timeAgoString())")
                        .foregroundStyle(.lightGray)
                        .font(.system(size: 12))
                }
            }
            Rectangle()
                .fill(.lightFrame)
                .frame(height: 1)
                .padding(.top, 5)
            HStack {
                Text("Next maintenance")
                    .foregroundStyle(.lightGray)
                    .font(.system(size: 12))
                Spacer()
                Text(equipment.maintenanceStatusText)
                    .foregroundStyle(equipment.maintenanceStatusColor)
                    .font(.system(size: 12))
            }
            .padding(.top, 5)
        }
        .darkFramed()
    }
}

#Preview {
    EquipmentPreView(equipment: EquipmentModel(name: "Silient bat", type: .bat))
}
