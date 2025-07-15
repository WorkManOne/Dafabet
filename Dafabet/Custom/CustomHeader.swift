//
//  CustomHeader.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 11.07.2025.
//

import SwiftUI

extension View {
    func customHeader(title: String, description: String? = nil, isDismiss: Bool = false) -> some View {
        self
            .overlay {
                CustomHeader(title: title, description: description, isDismiss: isDismiss)
            }
    }
}

struct CustomHeader: View {
    var title: String
    var description: String?
    var isDismiss: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text(title)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    if let description = description {
                        Text(description)
                            .font(.system(size: 12))
                            .foregroundColor(.lightGray)
                    }
                }
                HStack {
                    if isDismiss {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 20)
                    }
                    Spacer()
                }
            }
            .padding(.top, 70)
            .padding(.bottom, 20)
            .background(
                Color(.yellowMain.opacity(0.2))
                    .clipShape(RoundedCorners(radius: 30, corners: [.bottomLeft, .bottomRight]))
                    .overlay {
                        Color(.darkFrame)
                            .clipShape(RoundedCorners(radius: 29, corners: [.bottomLeft, .bottomRight]))
                            .padding([.leading, .trailing, .bottom], 1)
                    }
            )

            Spacer()
        }
        .ignoresSafeArea()


    }
}

#Preview {
    CustomHeader(title: "Home", isDismiss: true)
        .background(.black)
}
