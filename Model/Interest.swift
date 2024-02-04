//
//  Interest.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 01/02/2024.
//

import Foundation

class Interest: Identifiable, ObservableObject{
    init(name: String, taux: String, montant: String, operations: [Operation] = [], id: Int) {
        self.name = name
        self.taux = taux
        self.montant = montant
        self.operations = operations
        self.id = id
    }
    var name: String
    var taux: String
    var montant: String
    var operations: [Operation]
    var id: Int
    
    func calculInterêts() {
        
    }
}
