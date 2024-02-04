//
//  Operation.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 02/02/2024.
//

import Foundation

class Operation: Identifiable {
    
    enum Oper: String, CaseIterable, Identifiable {
        case versement, depot
        var id: Self {self}
    }
    
    init(type: Oper, montant: String, date: Date, id:Int) {
        self.type = type
        self.montant = montant
        self.date = date
        self.id = id
    }
    
    var type: Oper
    var montant: String
    var date: Date
    var id: Int
}
