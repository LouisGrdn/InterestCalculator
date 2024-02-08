//
//  OperationView.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 01/02/2024.
//

import SwiftUI

struct OperationView: View {
    
    
    
    @Binding var selected: Operation.Oper
    @Binding var montant: String
    @Binding var date: Date
    @Binding var startDate: Date
    
    var isAdding: Bool = false
    
    let formatter = StockedInterest.getDateFormatter()
    
    
    var body: some View {
        let year = startDate.formatted(Date.FormatStyle().year())
        VStack {
                Picker("Type", selection: $selected) {
                    Text("Retrait").foregroundStyle(.red).tag(Operation.Oper.retrait)
                    Text("Dépôt").tag(Operation.Oper.depot)
                }
                .colorInvert()
                    .colorMultiply(Color.white)
                .pickerStyle(.segmented)
                TextField("Montant", text: $montant)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            if(isAdding) {
                DatePicker("Date de l'opération",
                           selection: $date, in: startDate...,
                           displayedComponents: [.date])
                .datePickerStyle(.automatic)
                .colorInvert()
                .colorMultiply(Color.white)
            }
            else {
                DatePicker("Date de l'opération",
                           selection: $date, in: startDate...formatter.date(from: "31/12/\(year)")!,
                           displayedComponents: [.date])
                .datePickerStyle(.automatic)
                .colorInvert()
                .colorMultiply(Color.white)
            }
        }
        .padding(.horizontal, 30)
    }
}

//#Preview {
//    OperationView()
//}
