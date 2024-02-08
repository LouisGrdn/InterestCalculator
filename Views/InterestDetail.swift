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
                    OperationDetail(adding: $adding, interest: $interest)
                    
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
                    OperationView(selected: $type, montant: $montantOpe, date: $dateOpe, startDate: $interest.date, isAdding: true)
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
