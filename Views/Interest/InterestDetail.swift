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
    // Variable to update an operation
    @State var isEditing = false
    @State private var montantsOpe: [String] = []
    @State private var datesOpe: [Date] = []
    @State private var typeOpe: [Operation.Oper] = []
    @State private var updating: Bool = false
    @State private var operationIdToUpdate: Int = -1

    // Variable to add an operation
    @State private var montantOpe: String = ""
    @State private var dateOpe: Date = Date()
    @State private var type: Operation.Oper = Operation.Oper.retrait
    @State private var adding: Bool = false
    
    // Variable to filter by year
    @State private var selectedInterestYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedOperationYear: Int = Calendar.current.component(.year, from: Date())
    var years: ClosedRange<Int> = 2024...2034
    
    let dateFormat =  Date.FormatStyle()
        .year()
        .month(.wide)
        .day()
        .locale(Locale(identifier: "fr_FR"))
    
    
    var body: some View {
        // Filter by year
        let interest = stockedInterests.interests[index]
        let binding = Binding(
            get: {interest},
            set: {newValue in
                stockedInterests.interests[index] = newValue
            })
        ScrollView {
            VStack {
                // Default view
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
                                Text("\(String(format: "%.2f",interest.calculInterest(year: selectedInterestYear)))€")
                                    .font(.title)
                                    .bold()
                                    .foregroundStyle(.black)
                                Text("Intérêts générés")
                                    .font(.caption)
                                    .foregroundStyle(.black)
                            }
                        }
                    Picker("Année", selection: $selectedInterestYear) {
                        ForEach(years, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.bottom, 50)
                    Text("Montant : \(interest.montant)€")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 10)
                        .foregroundStyle(.white)
                    Text("Taux : \(interest.taux)%")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 10)
                        .foregroundStyle(.white)
                    Text("Date de création : \(interest.date.formatted(dateFormat))")
                        .font(.title3)
                        .bold()
                        .padding(.bottom, 20)
                        .foregroundStyle(.white)
                    Divider()
                    OperationDetail(interest: binding, id: $operationIdToUpdate, adding: $adding, updating: $updating, selectedOperationYear: $selectedOperationYear, years: years)
                }
                // Update Operation view
                else if(editMode?.wrappedValue == .active && updating) {
                    OperationView(
                        selected: binding.operations[operationIdToUpdate].type,
                        montant: binding.operations[operationIdToUpdate].montant,
                        date: binding.operations[operationIdToUpdate].date,
                        startDate: binding.date)
                }
                // Update Info view
                else if(editMode?.wrappedValue == .active && !adding) {
                    InterestEditor(
                        interest: binding,
                        isEditing: $isEditing)
                    
                    .onAppear() {
                        typeOpe = []
                        datesOpe = []
                        montantsOpe = []
                    }
                    .onDisappear() {
                        for i in montantsOpe.indices {
                            if(montantsOpe[i] != "") {
                                interest.operations.append(
                                    Operation(type: typeOpe[i],
                                              montant: montantsOpe[i],
                                              date: datesOpe[i],
                                              id: interest.operations.count))
                            }
                        }
                        stockedInterests.interests[index] = interest
                        typeOpe = []
                        datesOpe = []
                        montantsOpe = []
                        selectedInterestYear = Calendar.current.component(.year, from: interest.date)
                        selectedOperationYear = Calendar.current.component(.year, from: interest.date)
                    }
                }
                // Operation adding
                else {
                    OperationView(selected: $type, montant: $montantOpe, date: $dateOpe, startDate: binding.date, isAdding: true)
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
