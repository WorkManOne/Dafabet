//
//  CustomDatePickers.swift
//  ChickenFeed
//
//  Created by Кирилл Архипов on 28.06.2025.
//

import SwiftUI

let formatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "MM/dd/yyyy"
    return df
}()

struct CustomDatePickerSheet: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text("Select Date")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                VStack {
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .colorScheme(.dark)
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.redMain)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.lightFrame)
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

struct CustomTimePickerSheet: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text("Select Time")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                VStack {
                    DatePicker(
                        "Select Time",
                        selection: $selectedDate,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .colorScheme(.dark)
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.darkFrame)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.gray)
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    CustomDatePickerSheet(selectedDate: .constant(.now))
    CustomTimePickerSheet(selectedDate: .constant(.now))
}
