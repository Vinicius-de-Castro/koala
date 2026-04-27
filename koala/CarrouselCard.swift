//
//  CarrouselCardView.swift
//  koala
//
//  Created by Leo on 24/04/26.
//

import SwiftUI

struct CarrouselCard: View, Hashable, Identifiable {
    var id = UUID()
    var cardColor: Color? = .green
    
    var body: some View {
        ZStack {
            Color.green
            Image("DefaultStretch")
                .resizable()
                .scaledToFit()
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.white .opacity(0), .white .opacity(0.1), .white]), startPoint: .top, endPoint: .bottom))
            VStack {
                Spacer()
                Text("SUGESTÃO DO DIA")
                    .font(.system(size: 18))
                Text("Kegel Matinal")
                    .font(.system(size: 30, weight: .bold))
                Button("Conferir exercícios") {
                    print("Button pressed!")
                }
                .padding()
                .background(.green)
                .tint(Color.white)
                .clipShape(Capsule())
            }
            .padding()
            .padding(.bottom)
//            .background(.blue)
        }
        .frame(maxWidth: .infinity, maxHeight: 600)
    }
}
