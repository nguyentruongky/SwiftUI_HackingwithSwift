//
//  ContentView.swift
//  WeSplit
//
//  Created by Ky Nguyen on 6/3/20.
//  Copyright © 2020 Ky Nguyen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var peopleIndex = 0
    @State private var percentIndex = 0
    let percentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        return Double(amount) ?? 0
    }
    var tipAmount: Double {
        return Double(percentages[percentIndex]) / 100 * totalAmount
    }
    var grandTotal: Double {
        return totalAmount + tipAmount
    }
    var totalPerPerson: Double {
        return grandTotal / Double(peopleIndex + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $peopleIndex) {
                        ForEach(2 ..< 5) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you leave")) {
                    Picker("Tip percentage", selection: $percentIndex) {
                        ForEach(0 ..< percentages.count) {
                            Text("\(self.percentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    HStack {
                        Text("Order amount: ")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("$\(amount)")
                    }
                    HStack {
                        Text("Tip amount: ")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("$\(tipAmount, specifier: "%.2f")")
                    }
                    HStack {
                        Text("Total pay: ")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("$\(grandTotal, specifier: "%.2f")")
                    }
                    HStack {
                        Text("Total per person: ")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("$\(totalPerPerson, specifier: "%.2f")")
                    }
                }
                
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
