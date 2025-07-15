//
//  StringComponent.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 15.07.2025.
//

import Foundation

extension String {
    var initials: String {
        self
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty && $0.first!.isLetter }
            .compactMap { $0.first }
            .prefix(2)
            .map { String($0).uppercased() }
            .joined()
    }
}
