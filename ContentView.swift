//
//  ContentView.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 01/02/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment (StockedInterest.self) var stockedInterest
    @State private var selection: Tab = .interest
    
    enum Tab {
        case interest
        case list
    }
    var body: some View {
        TabView(selection: $selection) {
            FormView().environment(stockedInterest)
                .tabItem { Label("Calculateur", systemImage: "plusminus.circle") }
                .tag(Tab.interest)
            InterestList()
                .environment(stockedInterest)
                .tabItem {
                    Label("Liste", systemImage: "list.bullet.circle")
                }
                .tag(Tab.list)
        }
    }
}

#Preview {
    ContentView()
        .environment(StockedInterest())
}
