//
//  ContentView.swift
//  WeSplit
//
//  Created by Eugène Kiriloff on 30/01/2025.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 10
  @FocusState var isKeyboardFocused: Bool

  private let currency = Locale.current.currency?.identifier ?? "USD"
  private let peopleNumbers = Array(2...100)
  private let tipChoices = [10, 15, 20, 25, 0]

  private var totalAmount: Double {
    let grandTotal = checkAmount * (1 + Double(tipPercentage) / 100)
    return grandTotal / Double(numberOfPeople)
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Check amount") {
          TextField(
            "Enter check amount",
            value: $checkAmount,
            format: .currency(code: currency)
          )
          .keyboardType(.decimalPad)
          .focused($isKeyboardFocused)
        }

        Section {
          Picker(
            "Number of people",
            selection: $numberOfPeople) {
              ForEach(peopleNumbers, id: \.self) {
                Text("\($0) people")
              }
            }
        }

        Section("Tip amount") {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(tipChoices, id: \.self) {
              Text($0, format: .percent)
            }
          }
          .pickerStyle(.segmented)
        }

        Section("Each one pays") {
          Text(totalAmount, format: .currency(code: currency))
        }
      }
      .navigationTitle("WeSplit")
      .toolbar {
        if isKeyboardFocused {
          Button("Done") {
            isKeyboardFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
