//
//  ModuleLesson.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 24/08/22.
//

import Foundation

class Lesson: ObservableObject {

    @Published var image: String
    @Published var hasStar: Bool

    let letters: [String]
    var isBlocked: Bool

    init(image: String, letters: [String], isBlocked: Bool = true, hasStar: Bool = false) {
        self.image = image
        self.letters = letters
        self.isBlocked = isBlocked
        self.hasStar = hasStar
    }
}
