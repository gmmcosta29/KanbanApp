//
//  CardView.swift
//  KanbanApp
//
//  Created by Guilherme Costa on 11/06/2025.
//

import SwiftUI
import SwiftData

// MARK: View for Card, that represents a unique card
struct CardView: View {
    @Bindable var card: Card
    let column: Column
    
    
    var body : some View {
        ZStack(alignment: .topTrailing){
            VStack(alignment: .leading) {
                Text(card._title)
                    .font(.headline)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .bold(true)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                Text(card._description)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding([.leading,.trailing, .bottom],8)
                
            }
            Button(action: {
                if let index = column._cards.firstIndex(where: {$0.id == card.id }){
                    column._cards.remove(at: index)
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .background(Color.white.clipShape(Circle()))
                }
                .offset(x: 10, y: -10)
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Card.self, configurations: config)
        
        let exampleCard = Card(title: "Preview of a card", description: "Check the layout")

        let exampleColumn = Column(name: "Prewview Column", cards: [])
        container.mainContext.insert(exampleCard)
        
        return CardView(card: exampleCard, column: exampleColumn)
            .modelContainer(container)
    }
}
