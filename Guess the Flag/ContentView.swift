//
//  ContentView.swift
//  Guess the Flag
//
//  Created by danny hernandez on 2/7/25.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland",
                     "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var correctCountry = ""
    
    @State private var score = 0
    @State private var attempt = 1
    @State private var gameOver = false
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            .padding()
        }
        .alert(Text("Game Over"), isPresented: $gameOver) {
            Button("Restart game", action: restartGame)
        } message: {
            Text("Your final score was \(score)")
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Attempt \(attempt)/8 Your score is \(score)")
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong thats the flag for \(countries[number])"
        }
        if attempt == 8 {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion () {
        attempt += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 1..<3)
    }
    
    func restartGame () {
        attempt = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 1..<3)
    }
}

#Preview {
    ContentView()
}
