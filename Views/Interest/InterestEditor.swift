//
//  InterestEditor.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 04/02/2024.
//

import SwiftUI

struct InterestEditor: View {
    @Binding var interest: Interest
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
                DatePicker("Date de création",
                           selection: $interest.date,
                           displayedComponents: [.date])
                .padding(.bottom, 20)
                .colorInvert()
                .colorMultiply(Color.white)
                .environment(\.locale, Locale(identifier: "fr"))
            }
            .padding(.horizontal , 20)
            
        }
    }
}

//#Preview {
//    InterestEditor()
//}
