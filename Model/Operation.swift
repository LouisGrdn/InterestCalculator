//
//  Operation.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 02/02/2024.
//

import Foundation

class Operation: Identifiable {
    
    enum Oper: String, CaseIterable, Identifiable {
        case retrait, depot
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
    
    
    func findEffectiveDate(startDate: Date) -> Date {
        let oneDay: TimeInterval = 24 / 3600
        let days = (startDate.distance(to: self.date) / 3600 / 24).truncatingRemainder(dividingBy: 15)
        if(self.type == .retrait){
            return self.date - days * oneDay * 3600 * 24
        }
        else if(self.type == .depot) {
            return self.date + days * 3600 * 24
        }
        return self.date
    }
}
