//
//  InitialForm.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 12/02/2024.
//

import SwiftUI

struct InitialForm: View {
    
    @Binding var montant: String
    @Binding var taux: String
    @Binding var name: String
    @Binding var date: Date
    
    var body: some View {
        Text("Calculateur")
            .font(.title)
            .bold()
            .padding(.bottom, 20)
            .foregroundStyle(.white)
        Text("Intitulé Livret")
            .font(.title2)
            .foregroundStyle(.white)
        TextField("Livret", text:$name)
            .multilineTextAlignment(.center)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom)
            .submitLabel(.done)
        Text("Montant")
            .font(.title2)
            .foregroundStyle(.white)
        TextField("Montant", text:$montant)
            .multilineTextAlignment(.center)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom)
            .keyboardType(.decimalPad)
        Text("Taux")
            .font(.title2)
            .foregroundStyle(.white)
        TextField("Taux", text: $taux)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .padding(.bottom)
            .keyboardType(.decimalPad)
        DatePicker("Date de création",
                   selection: $date,
                   displayedComponents: [.date])
        .padding(.bottom, 20)
        .colorInvert()
        .colorMultiply(Color.white)
        .environment(\.locale, Locale(identifier: "fr"))
    }
}
