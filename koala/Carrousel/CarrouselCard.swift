//
//  CarrouselCardView.swift
//  koala
//
//  Created by Leo on 24/04/26.
//

import SwiftUI

struct CarrouselCard: View{
    
    @State var selectedRoutine: Routine?
    
    var routine: Routine
    
    var image: String
    
    var subtitle: String
    
    var title: String
    
    var button: String
    
    var id = UUID()
    
    var cardColor: Color {
        return (routine.type == .kegel ? .kegelPurple : .stretchGreen)
    }
    
    var screenHeight = UIScreen.main.bounds.size.height
    
    var screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .bottom) {
                //            Color.stretchGreen
                //                .ignoresSafeArea()
                
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(width: screenWidth, height: screenHeight*0.6, alignment: .center)
                    .ignoresSafeArea()
                    .clipped()
                    .containerRelativeFrame(.horizontal)
                
                
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.white .opacity(0), .white .opacity(0.6), .white]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .textCase(.uppercase)
                        .fontWeight(.bold)
                        .padding(-5)
                        .foregroundStyle(.kegelPurple)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.kegelDark)
                    Button(button) {
                        selectedRoutine = routine
                    }
                    .padding()
                    .background(cardColor)
                    .tint(Color.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .clipShape(Capsule())
                }
                .padding()
                .padding(.bottom)
            }
            .padding(.bottom, 100)
        }
        .navigationDestination(item: $selectedRoutine){ _ in
            DetailView(routine: routine)
        }
        
    }
}
