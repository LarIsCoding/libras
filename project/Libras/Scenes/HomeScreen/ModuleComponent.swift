//
//  ModuleComponent.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 24/08/22.
//

import SwiftUI

struct ModuleComponent: View {

    let moduleLessons: [Lesson]
    let startLesson: ((Int) -> ())

    var body: some View {
        ZStack {
            VStack {
                title
                    .padding(.bottom, 0.3)
                lessonsCompleted
                ScrollView(.horizontal) {
                    lessonsList
                }
            }
            .padding()
            .background {
                background
            }
        }
    }

    var title: some View {
        HStack {
            Text("Aprendendo o alfabeto")
                .foregroundColor(Color.text())
                .font(.system(.title3))
                .fontWeight(.bold)
            Spacer()
        }
    }

    var lessonsCompleted: some View {
        HStack {
            Text("3/5")
                .foregroundColor(Color.text())
                .font(.system(.callout))
                .fontWeight(.regular)
            Spacer()
        }
    }

    var lessonsList: some View {
        HStack {
            ForEach((0...4), id: \.self) { id in
                Button(
                    action: {
                        startLesson(id)
                    },
                    label: {
                        Image(moduleLessons[id].image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .padding(.horizontal, 5)
                    }
                )
            }
        }
    }

    var background: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.theme(), style: StrokeStyle(lineWidth: 2, dash: [5]))
            .foregroundColor(.white)
    }
}

struct ModuleComponent_Previews: PreviewProvider {
    static var previews: some View {
        ModuleComponent(moduleLessons: [], startLesson: { _ in })
            .padding()
    }
}
