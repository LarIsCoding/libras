//
//  HomeScreenView.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 24/08/22.
//

import SwiftUI

struct HomeScreenView: View {

    @StateObject var viewModel = HomeViewModel()
    @State var lessonStarted = false

    var body: some View {
        ScrollView {
            title
                .padding(.bottom)
            ModuleComponent(
                moduleLessons: viewModel.lessonManager.modules[0],
                startLesson: { _ in
                    lessonStarted.toggle()
                }
            )
            Spacer()
        }
        .padding()
        .background(Color.background())
        .sheet(isPresented: $lessonStarted) {
            ExerciseView()
        }
    }

    var title: some View {
        HStack {
            Text("Aulas")
                .foregroundColor(Color.text())
                .font(.system(.largeTitle))
                .fontWeight(.bold)
            Spacer()
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
