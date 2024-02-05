//
//  InterestEditor.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 04/02/2024.
//

import SwiftUI

struct InterestEditor: View {
    @Binding var interest: Interest
    
    @Binding var montantsOpe: [String]
    @Binding var datesOpe: [Date]
    @Binding var typeOpe: [Operation.Oper]

    
    var body: some View {
        VStack {
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
                typeOpe.append(.retrait)
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
}

//#Preview {
//    InterestEditor()
//}
