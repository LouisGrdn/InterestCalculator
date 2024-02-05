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
    
    var body: some View {
        VStack {
                Picker("Type", selection: $selected) {
                    Text("Retrait").tag(Operation.Oper.retrait)
                    Text("Dépôt").tag(Operation.Oper.depot)
                }
                .pickerStyle(.palette)
                TextField("Montant", text: $montant)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            DatePicker("Date de l'opération",
                       selection: $date,
                       displayedComponents: [.date])
        }
        .padding(.horizontal, 30)
    }
}

//#Preview {
//    OperationView()
//}
