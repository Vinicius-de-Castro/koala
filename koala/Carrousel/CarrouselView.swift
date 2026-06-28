//
//  CarrouselView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct CarrouselView: View {
    @State var activeCard: CarrouselCard?
    var body: some View {
        ZStack {
            TabView {
                CarrouselCard(routine: Memory.routines["MORNING_KEGEL"]!, image: "ExamplePhoto", subtitle: "Sugestão do dia", title: "Kegel Matinal", button: "Conferir exercícios")
                CarrouselCard(routine: Memory.routines["AFTERNOON_KEGEL"]!, image: "ExamplePhoto2", subtitle: "Sugestão do dia", title: "Kegel Diário", button: "Conferir exercícios")
                CarrouselCard(routine: Memory.routines["EVENING_KEGEL"]!, image: "ExamplePhoto3", subtitle: "Sugestão do dia", title: "Kegel Noturno", button: "Conferir exercícios")
                  
            }
            .tabViewStyle(.page)
            .ignoresSafeArea(edges: .top)
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
