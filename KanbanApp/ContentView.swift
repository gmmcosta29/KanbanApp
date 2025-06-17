//
//  ContentView.swift
//  KanbanApp
//
//  Created by Guilherme Costa on 09/06/2025.
//

import SwiftUI
import SwiftData

// MARK: DataModels

@Model
class Card{
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
                    
                    //hardcode v1 use cases
                    //todo
                    todoColumn._cards.append(Card(title: "Testar a BD", description: "Criar e destruir dados", creation_date: Date()))
                    todoColumn._cards.append(Card(title: "Test Sort", description: "testing sort", creation_date: Date()))
                    todoColumn._cards.append(Card(title: "Testar este projeto", description: "Testar em diversos modelos", creation_date: Date()))
                    
                    //
                    todoColumn._cards.append(Card(title: "Criar a v1.1", description: "asdfsf", creation_date: Date()))
                    
                    //progress
                    inProgressColumn._cards.append(Card(title: "Finalizar a APP", description: "Teste123", creation_date: Date()))
                    
                    //done
                    doneColumn._cards.append(Card(title: "Criar v1", description: "qwertyuiop1243", creation_date: Date()))
                    
                    modelContext.insert(todoColumn)
                    modelContext.insert(inProgressColumn)
                    modelContext.insert(doneColumn)
                }
            }
        }
    }
}

#Preview {
    ContentView().modelContainer(for: [Card.self, Column.self], inMemory: true)
}

