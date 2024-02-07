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
            NavigationSplitView {
                VStack {
                    Text("Mes livrets")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 25)
                        .foregroundStyle(Color.white)
                    if(stockedInterest.interests.count > 0) {
                    }
                    ForEach(stockedInterest.interests) { interest in
                        let index = stockedInterest.interests.firstIndex(where: { $0.id == interest.id })
                        NavigationLink {
                            InterestDetail(index: index!)
                        } label: {
                            HStack {
                                Text(stockedInterest.interests[index!].name)
                                Spacer()
                                Text(">")
                            }
                            .padding(.bottom, 20)
                            .padding(.horizontal, 20)
                            .font(.title2)
                            .foregroundStyle(Color.white)
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0x4A / 255, green: 0x4E / 255, blue: 0x69 / 255).edgesIgnoringSafeArea(.all))
            } detail: {
                Text("Liste des livrets")
                    .font(.title)
                    .bold()
                    .padding(.top, 25)
            }
    }
}

#Preview {
    InterestList()
        .environment(StockedInterest())
}
