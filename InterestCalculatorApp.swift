//
//  InterestCalculatorApp.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 01/02/2024.
//

import SwiftUI

@main
struct InterestCalculatorApp: App {
    @State private var stockedInterest = StockedInterest()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(stockedInterest)
        }
    }
}
