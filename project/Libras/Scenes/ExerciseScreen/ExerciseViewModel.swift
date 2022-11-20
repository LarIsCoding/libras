//
//  GameViewModel.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 15/08/22.
//

import SwiftUI

class ExerciseViewModel: ObservableObject {

    private let handSignManager = HandSignManager.shared

    @Published var letter: String = ""
    @Published var mustShowCorrectModal: Bool = false
    @Published var isRightAnswer: Bool = false

    init() {
        handSignManager.setDetectionCallback(signDetected)
        generateRandomLetter()
    }

    func generateRandomLetter() {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXY"
        self.letter = String(letters.randomElement() ?? "A")
    }

    func signDetected(detectedLetter: String) {
        DispatchQueue.main.async {
            self.isRightAnswer = detectedLetter == self.letter
            self.mustShowCorrectModal = true
        }
    }

    func getTitleText() -> String {
        if isRightAnswer {
            return "Parabéns!"
        }
        return "Resposta Errada"
    }

    func getBodyText() -> String {
        if isRightAnswer {
            return "Você fez a letra \(letter) corretamente"
        }
        return "Essa não é a letra \(letter)"
    }

    func getImageName() -> String {
        if isRightAnswer {
            return "right-answer"
        }
        return "wrong-answer"
    }
}
