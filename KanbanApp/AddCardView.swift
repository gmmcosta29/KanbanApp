//
//  AddCardView.swift
//  KanbanApp
//
//  Created by Guilherme Costa on 17/06/2025.
//

import SwiftUI
import SwiftData

// MARK: Form to add a card

struct AddCardView: View {
    @Bindable var column: Column
    
    @Environment(\.dismiss) var dissmiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date = Date()
    
    var body : some View {
        NavigationView {
            Form {
                Section(header: Text("Card Details")) {
                    TextField("Title", text: $title)
                    TextField("Description (optional)", text: $description,axis: .vertical)
                    DatePicker("Date", selection: $date)
                        .datePickerStyle(.wheel)
                }
            }
            .navigationTitle("New Card")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dissmiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Add"){
                            addCard()
                    }
                }
            }
        }
    }
    private func addCard(){
        let newCard = Card(title: title, description: description, creation_date: date)
        column._cards.append(newCard)
                
        dissmiss()
    }
}

