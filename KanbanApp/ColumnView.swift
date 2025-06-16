//
//  ColumnView.swift
//  KanbanApp
//
//  Created by Guilherme Costa on 11/06/2025.
//

import SwiftUI
import SwiftData

// MARK: View for Column, that represents a unique column

struct ColumnView: View {
    @Bindable var column: Column
    
    var body: some View {
        VStack(alignment: .leading){
            Text(column._name)
                .font(.headline)
                .padding(.bottom,8)
                
            ForEach(column._cards.sorted(using: SortDescriptor(\._creation_date))) { card in
                CardView(card: card)
                    .padding(.bottom,6)
            }
            Spacer()
        }
        .frame(width: 300)
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
struct ColumnView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Column.self, configurations: config)
        
        let exampleColumn = Column(name: "Doing", cards: [ Card(title: "Preview ColumnView", description: "Test Description")])

        
        container.mainContext.insert(exampleColumn)
        
        return ColumnView(column: exampleColumn)
            .modelContainer(container)
        
    }
}
