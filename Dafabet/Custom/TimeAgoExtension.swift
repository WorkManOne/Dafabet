//
//  TimeAgoExtension.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 11.07.2025.
//

import Foundation

extension Date {
    func timeAgoString(to date: Date = .now) -> String {
        let calendar = Calendar.current
        let days = calendar.dateComponents([.day], from: self, to: date).day ?? 0

        switch days {
        case 0..<7:
            return "\(days) " + pluralForm(days, one: "day", few: "days", many: "days")
        case 7..<28:
            let weeks = days / 7
            return "\(weeks) " + pluralForm(weeks, one: "week", few: "weeks", many: "weeks")
        default:
            let months = days / 30
            return "\(months) " + pluralForm(months, one: "month", few: "months", many: "months")
        }
    }
}

func pluralForm(_ count: Int, one: String, few: String, many: String) -> String {
    if count == 1 {
        return one
    } else {
        return many
    }
}
