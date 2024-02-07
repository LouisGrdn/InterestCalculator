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
    @State var isEditing = false
    @State private var montantsOpe: [String] = []
    @State private var datesOpe: [Date] = []
    @State private var typeOpe: [Operation.Oper] = []
    
    let dateFormat =  Date.FormatStyle()
        .year()
        .month(.wide)
        .day()
        .locale(Locale(identifier: "fr_FR"))
    
    @State private var montantOpe: String = ""
    @State private var dateOpe: Date = Date()
    @State private var type: Operation.Oper = Operation.Oper.retrait
    
    @State private var adding: Bool = false
    
    var body: some View {
        @State var interest: Interest = stockedInterests.interests[index]
        ScrollView {
            VStack {
                if(editMode?.wrappedValue == .inactive){
                    Text("\(interest.name)")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 20)
                        .foregroundStyle(.white)
                    Circle()
                        .fill(.white)
                        .frame(width: 150, height: 150)
                        .overlay {
                            VStack {
                                Text("\(interest.calculInterest())€")
                                    .font(.title)
                                    .bold()
                                Text("Intérêts générés :")
                                    .font(.caption)
                            }
//                            .padding(.top, 20)
                        }
                        .padding(.bottom, 50)
                    Text("Montant : \(interest.montant)€")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 10)
                        .foregroundStyle(.white)
                    Text("Taux : \(interest.taux)")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 10)
                        .foregroundStyle(.white)
                    Divider()
                    if(interest.operations.count != 0) {
                        VStack(alignment: .leading) {
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
                                            editMode?.wrappedValue = .inactive
                                        }
                                        .foregroundStyle(.white)
                                        .buttonStyle(.borderedProminent)
                                    }
                                }
                            }
                            ForEach(interest.operations) { operation in
                                VStack(alignment: .leading) {
                                    Text("Opération N°\(operation.id+1)")
                                        .font(.title3)
                                        .underline()
                                    Text("Type : \(operation.type.rawValue.capitalized)")
                                    Text("Montant : \(operation.montant)€")
                                    Text("Date : \(operation.date.formatted(dateFormat))")
                                    Divider()
                                }
//                                .padding(.horizontal, 20)
                                .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                else if(editMode?.wrappedValue == .active && !adding) {
                    InterestEditor(
                        interest: $interest,
                        montantsOpe: $montantsOpe,
                        datesOpe: $datesOpe,
                        typeOpe: $typeOpe,
                        isEditing: $isEditing)
                    
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
                else {
                    OperationView(selected: $type, montant: $montantOpe, date: $dateOpe)
                        .onDisappear() {
                            interest.operations.append(Operation(type: type, montant: montantOpe, date: dateOpe, id: interest.operations.count))
                            stockedInterests.interests[index] = interest
                            adding = false
                            montantOpe = ""
                            dateOpe = Date()
                            type = .retrait
                        }
                }
            }
            .toolbar {
                HStack {
                    if editMode?.wrappedValue == .active {
                        Button("Confirmer", role: .cancel) {
                            editMode?.animation().wrappedValue = .inactive
                        }
                    }
                    else {
                        Spacer()
                        //                    EditButton()
                        Button("Modifier", role: .cancel) {
                            editMode?.animation().wrappedValue = .active
                        }
                    }
                    
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0x4A / 255, green: 0x4E / 255, blue: 0x69 / 255).edgesIgnoringSafeArea(.all))
    }
}

//#Preview {
//    InterestDetail(interest: StockedInterest().interests[0])
//}
