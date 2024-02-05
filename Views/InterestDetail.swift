//
//  InterestDetail.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 04/02/2024.
//

import SwiftUI

struct InterestDetail: View {
    @Environment(\.editMode) private var editMode
    @Environment(StockedInterest.self) var stockedInterests
    var index: Int
    @State private var montantsOpe: [String] = []
    @State private var datesOpe: [Date] = []
    @State private var typeOpe: [Operation.Oper] = []
    
    let dateFormat =  Date.FormatStyle()
        .year()
        .month(.wide)
        .day()
        .locale(Locale(identifier: "fr_FR"))
    
    var body: some View {
        @State var interest: Interest = stockedInterests.interests[index]
        VStack {
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
                Text("Intérêts Générés : \(interest.calculInterest())")
            }
            else {
                InterestEditor(
                    interest: $interest,
                    montantsOpe: $montantsOpe,
                    datesOpe: $datesOpe,
                    typeOpe: $typeOpe)
                
                .onAppear() {
                    typeOpe = []
                    datesOpe = []
                    montantsOpe = []
                }
                .onDisappear() {
                    for i in montantsOpe.indices {
                        interest.operations.append(
                            Operation(type: typeOpe[i],
                                      montant: montantsOpe[i],
                                      date: datesOpe[i],
                                      id: interest.operations.count))
                    }
                    stockedInterests.interests[index] = interest
                    typeOpe = []
                    datesOpe = []
                    montantsOpe = []
                }
            }
        }
        .toolbar {
            HStack {
                Spacer()
                EditButton()
                    .padding(.top, 10)
            }
        }
    }
}

//#Preview {
//    InterestDetail(interest: StockedInterest().interests[0])
//}
