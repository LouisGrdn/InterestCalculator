//
//  InterestView.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 03/02/2024.
//

import SwiftUI

struct InterestList: View {
    @Environment (StockedInterest.self) var stockedInterest
    var body: some View {
        VStack {
            NavigationSplitView {
                Text("Liste des livrets")
                    .font(.title)
                    .bold()
                    .padding(.vertical, 25)
                if(stockedInterest.interests.count > 0) {
                }
                ForEach(stockedInterest.interests) { interest in
                    NavigationLink {
                        InterestDetail(interest: interest)
                    } label: {
                        HStack {
                            Text(interest.name)
                            Spacer()
                            Text(">")
                        }
                        .padding(.horizontal, 20)
                        .font(.title3)
                        .foregroundStyle(Color.black)
                    }
                }
                Spacer()
            } detail: {
                Text("Liste des livrets")
                    .font(.title)
                    .bold()
                    .padding(.top, 25)
            }
        }
    }
}

#Preview {
    InterestList()
        .environment(StockedInterest())
}