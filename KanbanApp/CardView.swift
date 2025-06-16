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
    
    var body : some View {
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
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Card.self, configurations: config)
        
        let exampleCard = Card(title: "Preview of a card", description: "Check the layout")

        container.mainContext.insert(exampleCard)
        
        return CardView(card: exampleCard)
            .modelContainer(container)
    }
}
