//
//  EditCardView.swift
//  KanbanApp
//
//  Created by Guilherme Costa on 23/06/2025.
//

import SwiftUI
import SwiftData

// MARK: View for editing a Card

struct EditCardView: View {
    @Bindable var card: Card
    let column: Column
    @Environment(\.dismiss) var dissmiss
    
    @State private var Title:String
    @State private var Description:String
    @State private var Date:Date
    
    init(card: Card, column: Column) {
        self.card = card
        self.column = column
        
        _Title = State(initialValue: card._title)
        _Description = State(initialValue: card._description)
        _Date = State(initialValue: card._creation_date)
    }
    var body : some View {
        NavigationView {
            Form {
                Section(header: Text("Card Details")) {
                    TextField("Title", text: $Title)
                    TextField("Description (optional)", text: $Description,axis: .vertical)
                    DatePicker("Date", selection: $Date)
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
                    Button("Save"){
                        saveCard()
                    }
                }
            }
        }
    }
    
    private func saveCard(){
        card._title = Title
        card._description = Description
        card._creation_date = Date
        dissmiss()
    }
}
    
    

