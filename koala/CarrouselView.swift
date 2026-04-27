//
//  CarrouselView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct CarrouselView: View {
    @State var cards: [CarrouselCard] = [
        CarrouselCard(image: "ExamplePhoto", subtitle: "Sugestão do dia", title: "Alongamento Matinal", button: "Conferir exercícios"),
        CarrouselCard(image: "ExamplePhoto2", subtitle: "Sugestão do dia", title: "Kegel Diário", button: "Conferir exercícios"),
        CarrouselCard(image: "DefaultStretch", subtitle: "Sugestão do dia", title: "Alongamento Diário", button: "Conferir exercícios"),
    ]
    @State var activeCard: CarrouselCard?
    var body: some View {
        ZStack {
            TabView {
                ForEach(cards, id: \.self) { card in
                    card
                }
            }
            .tabViewStyle(.page)
            .ignoresSafeArea(edges: .top)
//            VStack {
//                ScrollView(.horizontal) {
//                    HStack {
//                        ForEach(cards, id: \.self) { card in
//                            card
//                        }
//                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
//                    }
//                    .scrollTargetLayout()
//                    
//                }
//                .scrollIndicators(.never)
//                .scrollTargetBehavior(.viewAligned)
//                .scrollPosition(id: $activeCard)
//                
//                HStack {
//                    ForEach(cards) {card in
//                        Button {
//                            withAnimation {
//                                activeCard = card
//                            }
//                        } label: {
//                            Image(systemName: "circle.fill")
//                                .foregroundStyle(Color(uiColor: .systemGray3))
//                                .opacity(activeCard == card ? 1 : 0.3)
//                        }
//                    }
//                }
//                .padding()
//            }
//            .ignoresSafeArea(edges: .top)
        }
        .onAppear {
            setupAppearance()
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .stretchGreen
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.stretchGreen.withAlphaComponent(0.2)
      }
}
