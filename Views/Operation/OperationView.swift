//
//  OperationView.swift
//  InterestCalculator
//
//  Created by Louis Gardin on 01/02/2024.
//

import SwiftUI

struct OperationView: View {
    @Environment(StockedInterest.self) var stockedInterests
    
    @Binding var selected: Operation.Oper
    @Binding var montant: String
    @Binding var date: Date
    @Binding var startDate: Date
    
    var isAdding: Bool = false
    var isDeletable: Bool = false
    
    @State private var hidden: Bool = false
    
    let formatter = StockedInterest.getDateFormatter()
    
    
    var body: some View {
        if(!hidden) {
            let year = startDate.formatted(Date.FormatStyle().year())
            VStack {
                HStack {
                    Picker("Type", selection: $selected) {
                        Text("Retrait").foregroundStyle(.red).tag(Operation.Oper.retrait)
                        Text("Dépôt").tag(Operation.Oper.depot)
                    }
                    .colorInvert()
                    .colorMultiply(Color.white)
                    .pickerStyle(.segmented)
                    if(isDeletable){
                        Button("", systemImage: "xmark.bin.circle") {
                            montant = ""
                            hidden = true
                        }
                        .foregroundStyle(.red)
                    }
                }
                TextField("Montant", text: $montant)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                if(isAdding) {
                    DatePicker("Date de l'opération",
                               selection: $date, in: startDate...,
                               displayedComponents: [.date])
                    .datePickerStyle(.automatic)
                    .colorInvert()
                    .colorMultiply(Color.white)
                    .environment(\.locale, Locale(identifier: "fr"))
                }
                else {
                    DatePicker("Date de l'opération",
                               selection: $date, in: startDate...formatter.date(from: "31/12/\(year)")!,
                               displayedComponents: [.date])
                    .datePickerStyle(.automatic)
                    .colorInvert()
                    .colorMultiply(Color.white)
                    .environment(\.locale, Locale(identifier: "fr"))
                }
            }
            .padding(.horizontal, 30)
        }
    }
}

//#Preview {
//    OperationView()
//}
