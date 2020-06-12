//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ky Nguyen on 6/11/20.
//  Copyright © 2020 Ky Nguyen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var didUserSelect = false

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        didUserSelect = false
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of ")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
                
                Text("Your score is: \(self.userScore)")
                    .foregroundColor(.white)
                
                ForEach(0 ..< 3) { number in
                    ZStack {
                        Button(action: {
                            if self.didUserSelect { return }
                            self.flagTapped(number)
                            self.didUserSelect = true
                        }, label: {
                            Image(self.countries[number]).renderingMode(.original)
                                .shadow(color: .black, radius: 2)
                                .opacity(self.didUserSelect == false ? 1 : (number == self.correctAnswer ? 1 : 0.2))
                            }).disabled(self.didUserSelect)
                        if (self.didUserSelect) {
                            Text(number == self.correctAnswer ? "✅" : "❌")
                        }
                    }
                }
                
                Button(action: {
                    self.askQuestion()
                }, label: {
                    Text("Next")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                        .frame(width: 180, height: 60, alignment: .center)
                })
                    .background(Color.white)
                    .cornerRadius(30)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
