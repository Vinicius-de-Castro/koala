//
//  CarrouselCardView.swift
//  koala
//
//  Created by Leo on 24/04/26.
//

import SwiftUI

struct CarrouselCard: View, Hashable, Identifiable {
    var image: String
    var subtitle: String
    var title: String
    var button: String
    var id = UUID()
    var cardColor: Color? = .stretchGreen
    
    var screenHeight = UIScreen.main.bounds.size.height
    var screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack(alignment: .bottom) {
//            Color.stretchGreen
//                .ignoresSafeArea()
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(width: screenWidth, height: screenHeight*0.7, alignment: .center)
                .ignoresSafeArea()
                .clipped()
                .containerRelativeFrame(.horizontal)
                
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.white .opacity(0), .white .opacity(0.6), .white]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text(subtitle)
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(-5)
                    .foregroundStyle(.kegelPurple)
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Button(button) {
                    print("Button pressed!")
                }
                .padding()
                .background(.stretchGreen)
                .tint(Color.white)
                .clipShape(Capsule())
            }
            .padding()
            .padding(.bottom)
        }
        .padding(.bottom, 100)

    }
}
