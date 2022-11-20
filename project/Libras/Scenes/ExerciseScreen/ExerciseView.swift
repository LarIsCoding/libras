//
//  ExerciseView.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 16/08/22.
//

import SwiftUI

struct ExerciseView: View {
    @StateObject private var viewModel = ExerciseViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            CameraPreview()
            background
            if viewModel.mustShowCorrectModal {
                VStack {
                    Spacer()
                    CorrectModalView(viewModel: viewModel)
                    Spacer()
                }
            } else {
                letterCard
                    .padding(.top, 80)
            }
        }
        .ignoresSafeArea()
    }

    var background: some View {
        Image("fundo")
            .resizable()
            .scaledToFit()
    }

    var letterCard: some View {
        VStack {
            Text("Faça a letra")
                .foregroundColor(Color.text())
                .font(.system(size: 17))
            Text(viewModel.letter)
                .foregroundColor(Color.text())
                .font(.system(size: 50))
        }
            .padding(.horizontal, 100)
            .padding(.vertical, 15)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.background())
            }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
