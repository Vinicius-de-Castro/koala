//
//  CarrouselView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct CarrouselView: View {
    @State var cards: [CarrouselCard] = [CarrouselCard(), CarrouselCard(), CarrouselCard(), CarrouselCard()]
    @State var activeCard: CarrouselCard?
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(cards, id: \.self) { card in
                            CarrouselCard()
                        }
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                    }
                    .scrollTargetLayout()
                    
                }
                .scrollIndicators(.never)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $activeCard)
                
                HStack {
                    ForEach(cards) {card in
                        Button {
                            withAnimation {
                                activeCard = card
                            }
                        } label: {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(Color(uiColor: .systemGray3))
                                .opacity(activeCard == card ? 1 : 0.3)
                        }
                    }
                }
                .padding()
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}
