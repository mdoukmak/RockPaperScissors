//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Muhammad Doukmak on 7/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var shouldWin = Bool.random()
    @State private var aiMoveIndex = Int.random(in: 0..<3)
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var round = 1
    private let maxRounds = 10

    private let moves = ["🪨", "📄", "✂️"]
    private let winningMoves = ["📄", "✂️", "🪨"]

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text(shouldWin ? "Win" : "Lose")
                .font(.largeTitle.bold())
                .foregroundColor(.secondary)
            Text(moves[aiMoveIndex])
                .font(.system(size: 64))
                .padding()
                .background(.indigo)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            HStack(spacing: 20) {
                ForEach(moves, id: \.self) { move in
                    Button {
                        selectMove(move)
                    } label: {
                        Text(move)
                            .font(.system(size: 54))
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 5)
                    }

                }
            }
            Text("Score: \(score)")
                .font(.title3)
            Spacer()
            Text("Round: \(round)/\(maxRounds)")
            Spacer()
            Spacer()
        }
        .padding()
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Ok") { }
        } message: {
            Text(alertMessage)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mint.opacity(0.5))
    }

    private func selectMove(_ move: String) {
        let result: String
        if (shouldWin &&
           move == winningMoves[aiMoveIndex]) || (!shouldWin && move != winningMoves[aiMoveIndex]) {
                score += 1
                result = "Correct"
        } else {
            result = "Wrong"
        }
        if round == maxRounds {
            alertTitle = "Game Over"
            alertMessage = "Your score was \(score)"
        } else {
            alertMessage = result
            alertTitle = ""
        }
        showAlert = true
        aiMoveIndex = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        round = (round + 1) % (maxRounds + 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
