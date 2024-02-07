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
    @Binding var isEditing: Bool

    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text("Intitulé Livret")
                    .font(.title2)
                    .foregroundStyle(.white)
                TextField("Livret", text:$interest.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                    .keyboardType(.decimalPad)
                Text("Montant")
                    .font(.title2)
                    .foregroundStyle(.white)
                TextField("Montant", text:$interest.montant)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                    .keyboardType(.decimalPad)
                Text("Taux")
                    .font(.title2)
                    .foregroundStyle(.white)
                TextField("Taux", text: $interest.taux)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .keyboardType(.decimalPad)
                Spacer()
            }
            .padding(.horizontal , 20)
//            VStack {
//                ForEach(interest.operations.indices, id:\.self) { index in
//                    Text("Opération N°\(index+1)")
//                        .font(.title3)
//                        .underline()
//                        .foregroundStyle(.white)
//                    OperationView(
//                        selected: $interest.operations[index].type,
//                        montant: $interest.operations[index].montant,
//                        date: $interest.operations[index].date)
//                }
//            }
//            .padding(.horizontal, 20)
//            Button("Ajouter un versement / dépôt") {
//                montantsOpe.append("")
//                datesOpe.append(Date())
//                typeOpe.append(.retrait)
//            }
//            .buttonStyle(.borderedProminent)
//            .foregroundStyle(.white)
//            ForEach(montantsOpe.indices, id: \.self) { index in
//                OperationView(
//                    selected: $typeOpe[index],
//                    montant: $montantsOpe[index],
//                    date: $datesOpe[index])
//                
//            }
//            .padding(.bottom, 10)
            
        }
    }
}

//#Preview {
//    InterestEditor()
//}
