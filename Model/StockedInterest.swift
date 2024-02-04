//
//  InterestList.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 03/02/2024.
//

import Foundation


@Observable
class StockedInterest: ObservableObject{
    var interests: [Interest] = [
        Interest(
            name: "Livret A",
            taux: "10.0",
            montant: "10000",
            operations: [Operation(type: Operation.Oper.versement, montant: "150", date: Date(), id: 0)],
            id: 0)]
}
