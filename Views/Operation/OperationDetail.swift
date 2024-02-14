//
//  OperationDetail.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 08/02/2024.
//

import SwiftUI

struct OperationDetail: View {
    @Environment (\.editMode) private var editMode
    @Environment (StockedInterest.self) var stockedInterests
    
    @Binding var interest: Interest
    
    @Binding var id: Int
    
    @Binding var adding: Bool
    @Binding var updating: Bool
    
    @Binding var selectedOperationYear: Int
    
    let years: ClosedRange<Int>
    
    let dateFormat =  Date.FormatStyle()
        .year()
        .month(.wide)
        .day()
        .locale(Locale(identifier: "fr_FR"))
    
    var body: some View {
        HStack {
            Text("Opérations")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
                .foregroundStyle(.white)
            Spacer()
            ZStack{
                if(editMode?.wrappedValue == .inactive) {
                    Button("Ajouter", systemImage: "plus", role: .cancel) {
                        adding = true
                        editMode?.wrappedValue = .active
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.borderedProminent)
                }   else {
                    Button("Confirmer", systemImage: "plus", role: .cancel) {
                        adding = false
                        updating = false
                        editMode?.wrappedValue = .inactive
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding(.horizontal, 20)
        Picker("Année", selection: $selectedOperationYear) {
            ForEach(years, id: \.self) {
                Text("\($0)")
            }
        }
        .pickerStyle(.menu)
        if(interest.operations.count != 0) {
            ForEach(interest.operations) { operation in
                if Calendar.current.component(.year, from: operation.date) == selectedOperationYear {
                    VStack(alignment: .leading) {
                        HStack(spacing: 10) {
                            Text("Opération N°\(operation.id+1)")
                                .font(.title3)
                                .underline()
                                .padding(.trailing, 10)
                            Button("", systemImage: "pencil.line") {
                                updating = true
                                editMode?.wrappedValue = .active
                                id = operation.id
                            }
                            .foregroundStyle(.blue)
                            Button("", systemImage: "minus.square") {
                                interest.operations.remove(at: operation.id)
                                stockedInterests.interests[interest.id] = interest
                                if(operation.id != interest.operations.count) {
                                    for operation in interest.operations {
                                        operation.id -= 1
                                    }
                                }
                            }
                            .foregroundStyle(Color(red: 0xE8/255, green: 0x5A/255, blue: 0x7C/255))
                            
                        }
                            Text("Type : \(operation.type.rawValue.capitalized)")
                            Text("Montant : \(operation.montant)€")
                            Text("Date : \(operation.date.formatted(dateFormat))")
                            Divider()
                    }
                    .padding(.horizontal, 20)
                    .foregroundStyle(.white)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

//#Preview {
//    OperationDetail(adding: .constant(false), interest: .constant(Interest(name: "A", taux: "10", montant: "10000", id: 0)))
//        .environment(StockedInterest())
//}
