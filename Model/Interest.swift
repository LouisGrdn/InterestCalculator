//
//  Interest.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 01/02/2024.
//

import Foundation

class Interest: Identifiable, ObservableObject{
    init(name: String, taux: String, montant: String, operations: [Operation] = [], id: Int, date: Date = Date()) {
        self.name = name
        self.taux = taux
        self.montant = montant
        self.operations = operations
        self.id = id
        self.date = date
    }
    var name: String
    var taux: String
    var montant: String
    var operations: [Operation]
    var id: Int
    var date: Date
    
    func calculInterest() -> Int{
        let formatter =  StockedInterest.getDateFormatter()
        let startDate = self.date
        let endDate = self.date + self.date.distance(to: formatter.date(from: "31/12/\(self.date.formatted(Date.FormatStyle().year()))")!)
        var date: Date = self.date
        var interest: Float = 0
        
        var m = Float(self.montant)
        for operation in operations {
            if(operation.date < endDate) {
                date = operation.findEffectiveDate(startDate: self.date)
                let days = Float(Int(startDate.distance(to: date))/60/60/24)
                
//                if(days >= 15) {
                    interest += (m! * days * Float(taux)!) / 36000
//                }
                
                if(operation.type == .depot) {
                    m! += Float(operation.montant)!
                }
                else {
                    m! -= Float(operation.montant)!
                }
            }
        }
        let days = Float(Int(date.distance(to: endDate))/60/60/24)
        interest += (m! * days * Float(taux)!) / 36000
        return Int(interest.rounded())
//        formatter.dateFormat = "dd/MM/yyyy"
//        let startDate = formatter.date(from: "01/01/2024")
//        let endDate = formatter.date(from: "26/12/2024")
//        var date: Date = startDate!
//        var interest: Float = 0
//        
//        var m = Float(self.montant)
//        for operation in operations {
//            date = operation.findEffectiveDate()
//            let days = Float(Int(startDate!.distance(to: date))/60/60/24)
//            
//            if(days >= 15) {
//                interest += (m! * days * Float(taux)!) / 36000
//            }
//            
//            if(operation.type == .depot) {
//                m! += Float(operation.montant)!
//            }
//            else {
//                m! -= Float(operation.montant)!
//            }
//        }
//        let days = Float(Int(date.distance(to: endDate!))/60/60/24)
//        interest += (m! * days * Float(taux)!) / 36000
//        return Int(interest.rounded())
    }
}
