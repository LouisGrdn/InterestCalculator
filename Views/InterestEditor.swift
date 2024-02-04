//
//  InterestEditor.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 04/02/2024.
//

import SwiftUI

struct InterestEditor: View {
    @Binding var interest: Interest
    
    @State private var montantsOpe: [String] = []
    @State private var datesOpe: [Date] = []
    @State private var typeOpe: [Operation.Oper] = []
    
    
    
    var body: some View {
        Text("Montant")
            .font(.title2)
        TextField("Montant", text:$interest.montant)
            .multilineTextAlignment(.center)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom)
            .keyboardType(.decimalPad)
        Text("Taux")
            .font(.title2)
        TextField("Taux", text: $interest.taux)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .padding(.bottom)
            .keyboardType(.decimalPad)
        ForEach(interest.operations.indices, id:\.self) { index in
            OperationView(
                selected: $interest.operations[index].type,
                montant: $interest.operations[index].montant,
                date: $interest.operations[index].date)
        }
        Button("Ajouter un versement / dépôt") {
            montantsOpe.append("")
            datesOpe.append(Date())
            typeOpe.append(.versement)
        }
        ForEach(montantsOpe.indices, id: \.self) { index in
            OperationView(
                selected: $typeOpe[index],
                montant: $montantsOpe[index],
                date: $datesOpe[index])
        }
        .buttonStyle(.bordered)
        .padding(.bottom, 10)
    }
}

//#Preview {
//    InterestEditor()
//}
