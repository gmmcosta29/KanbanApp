//
//  ContentView.swift
//  KanbanApp
//
//  Created by Guilherme Costa on 09/06/2025.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers
// MARK: DataModels

@Model
class Card{
    var id: UUID = UUID()
    var _title: String
    var _description: String
    var _creation_date: Date
    
    init(title: String , description: String = "", creation_date: Date = Date()){
        self._title = title
        self._description = description
        self._creation_date = creation_date
    }

}

@Model
class Column {
    var _name: String
    @Relationship(deleteRule: .cascade)
    var _cards: [Card]
    var _id: Int
    
    init(name: String, cards: [Card] = [], id: Int = 0){
        self._name = name
        self._cards = cards
        self._id = id
    }
}

// MARK: Content Views

struct ContentView: View {
    @Query(sort: \Column._id) var columns: [Column]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal){
                HStack(alignment: .top, spacing: 16){
                    ForEach(columns){ column in
                        ColumnView(column: column)
                    }
                }
                .padding()
            }            
            .onAppear{
                if columns.isEmpty{
                    let todoColumn = Column(name: "To Do", id: 1)
                    let inProgressColumn = Column(name: "Progress", id: 2)
                    let doneColumn = Column(name: "Done", id: 3)
                    
                    todoColumn._cards.append(Card(title: "Example Todo", description: "asdfsf", creation_date: Date()))
                    
                    //progress
                    inProgressColumn._cards.append(Card(title: "Example InProgress", description: "Teste123", creation_date: Date()))
                    
                    //done
                    doneColumn._cards.append(Card(title: "Example Done", description: "qwertyuiop1243", creation_date: Date()))
                    
                    modelContext.insert(todoColumn)
                    modelContext.insert(inProgressColumn)
                    modelContext.insert(doneColumn)
                }
            }
        }
    }
    
    private func moveCard(card: Card , sourceColumn: Column, destinationColumn: Column){
        if let index = sourceColumn._cards.firstIndex(of: card){
            sourceColumn._cards.remove(at: index)
        }
        destinationColumn._cards.append(card)
    }
}

#Preview {
    ContentView().modelContainer(for: [Card.self, Column.self], inMemory: true)
}


