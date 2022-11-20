//
//  CorrectModal.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 19/08/22.
//

import SwiftUI

struct CorrectModalView: View {
    @ObservedObject var viewModel: ExerciseViewModel

    var body: some View {
        VStack {
            Text(viewModel.getTitleText())
                .foregroundColor(Color.text())
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .padding(.bottom)
            Text(viewModel.getBodyText())
                .foregroundColor(Color.text())
                .font(.system(size: 17))
                .padding(.bottom, 30)
            Image(viewModel.getImageName())
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .padding(.bottom, 30)
            Button(
                action: {
                    viewModel.mustShowCorrectModal = false
                    viewModel.generateRandomLetter()
                },
                label: {
                    Text("Novo Desafio")
                        .foregroundColor(Color.text())
                        .fontWeight(.semibold)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.theme())
                        }
                }
            )
        }
        .padding(40)
        .padding(.horizontal, 15)
        .background() {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.background())
        }
    }
}

struct CorrectModalView_Previews: PreviewProvider {
    static var previews: some View{
        ZStack {
            Color.black
                .ignoresSafeArea()
            CorrectModalView(viewModel: ExerciseViewModel())
        }
    }
}
