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
    
    let formatter = DateFormatter()
    
    func findEffectiveDate() -> Date {
        let day = self.date.formatted(Date.FormatStyle().day())
        var month = self.date.formatted(Date.FormatStyle().month(.twoDigits))
        let year = self.date.formatted(Date.FormatStyle().year())
        formatter.dateFormat = "dd/MM/yyyy"
        if(self.type == .retrait) {
            if(Int(day)! > 15) {
                return formatter.date(from: "15/\(month)/\(year)")!
            }
            else if(Int(day)! > 1 && Int(day)! < 15) {
                return formatter.date(from: "01/\(month)/\(year)")!
            }
        }
        else {
            if(Int(day)! > 15) {
                month = "\(Int(month)!+1)"
                return formatter.date(from: "01/\(month)/\(year)")!
            }
            else if(Int(day)! > 1 && Int(day)! < 15) {
                return formatter.date(from: "15/\(month)/\(year)")!
            }
        }
        return self.date
    }
}
