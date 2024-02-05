//
//  FormView.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 01/02/2024.
//

import SwiftUI

struct FormView: View {
    @Environment (StockedInterest.self) var stockedInterest
    // Compteur
    @State private var count = 0
    // Etat initial
    @State private var montant: String = ""
    @State private var taux: String = ""
    @State private var name: String = ""
    // Opérations
    @State private var montantsOpe: [String] = []
    @State private var datesOpe: [Date] = []
    @State private var typeOpe: [Operation.Oper] = []
    // Enregistrement
    @State private var validation: Bool = false
    
    // Liste des opérations rentrées
    @State private var operations: [Operation] = []
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Calculateur d'intérêt")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 20)
                Text("Intitulé Livret")
                    .font(.title2)
                TextField("Livret", text:$name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                    .keyboardType(.decimalPad)
                Text("Montant")
                    .font(.title2)
                TextField("Montant", text:$montant)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                    .keyboardType(.decimalPad)
                Text("Taux")
                    .font(.title2)
                TextField("Taux", text: $taux)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .keyboardType(.decimalPad)
                Button("Ajouter un versement / dépôt") {
                    count += 1
                    montantsOpe.append("")
                    datesOpe.append(Date())
                    typeOpe.append(.retrait)
                }
                .buttonStyle(.bordered)
                .padding(.bottom, 10)
                ForEach(montantsOpe.indices, id: \.self) { index in
                    OperationView(
                        selected: $typeOpe[index],
                        montant: $montantsOpe[index],
                        date: $datesOpe[index])
                }
                Button("Valider") {
                    if(montant != "" && taux != ""){
                        validation = true
                        for i in 0..<montantsOpe.count {
                            if(montantsOpe[i] != ""){
                                operations.append(
                                    Operation(
                                        type: typeOpe[i],
                                        montant: montantsOpe[i],
                                        date: datesOpe[i],
                                        id: i))
                            }
                        }
                        stockedInterest.interests.append(
                            Interest(
                                name: name,
                                taux: taux,
                                montant: montant,
                                operations: operations,
                                id: stockedInterest.interests.count)
                        )
                        montant = ""
                        taux = ""
                        datesOpe = []
                        montantsOpe = []
                        typeOpe = []
                    }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 20))
                if(validation) {
                    Text("Opération enregistrée avec succés !")
                }
                
                
            }
            .padding()
        }
    }
}

#Preview {
    FormView()
        .environment(StockedInterest())
}
