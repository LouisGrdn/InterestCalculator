//
//  InterestDetail.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 04/02/2024.
//

import SwiftUI

struct InterestDetail: View {
    @Environment(\.editMode) private var editMode
    @State var interest: Interest
    
    let dateFormat =  Date.FormatStyle()
        .year()
        .month(.wide)
        .day()
        .locale(Locale(identifier: "fr_FR"))
    
    var body: some View {
        VStack {
            HStack {
                EditButton()
            }
            if(editMode?.wrappedValue == .inactive){
                Text("Détails")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 20)
                Text("Montant : \(interest.montant)")
                    .font(.title3)
                    .padding(.bottom, 10)
                Text("Taux : \(interest.taux)")
                    .font(.title3)
                    .padding(.bottom, 10)
                Divider()
                if(interest.operations.count != 0) {
                    Text("Opérations")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 5)
                    ForEach(interest.operations) { operation in
                        Text("Opération N°\(operation.id+1)")
                        Text("Type : \(operation.type.rawValue.capitalized)")
                        Text("Montant : \(operation.montant)€")
                        Text("Date : \(operation.date.formatted(dateFormat))")
                        Divider()
                    }
                }
            }
            else {
                InterestEditor(interest: $interest)
            }
        }
    }
}

#Preview {
    InterestDetail(interest: StockedInterest().interests[0])
}
