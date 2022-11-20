//
//  LessonManager.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 24/08/22.
//

import Foundation

class LessonManager {

    static let shared = LessonManager()

    let modules = [
        [
            Lesson(image: "A1", letters: ["A", "B", "C", "D", "E"]),
            Lesson(image: "A2", letters: ["F", "G", "H", "I", "J"]),
            Lesson(image: "A3", letters: ["K", "L", "M", "N", "O"]),
            Lesson(image: "A4", letters: ["P", "Q", "R", "S", "T"]),
            Lesson(image: "A4", letters: ["U", "V", "W", "X", "Y"])
        ]
    ]
}
