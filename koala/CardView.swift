//
//  CardView.swift
//  koala
//
//  Created by User on 17/04/26.
//

import SwiftUI

struct CardView: View {
    
    @State var thisRoutine: Routine
    
    var body: some View {
        let bgColor: Color = ((thisRoutine.type == .kegel) ? .kegelPurple : .stretchGreen)
        let title = thisRoutine.name
        let length = thisRoutine.length
        let count = thisRoutine.count
        let image = thisRoutine.image
        
        HStack {
            //textos
            VStack (
                alignment: .leading,
                spacing: 4
            ){
                
                Text(title)
                    .font(.title)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: 200, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                
                //tags
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(.white)
                        .frame(maxWidth: 30)
                    Text(String(Int(length/60)) + (Int(length/60) > 1 ? " minutos" : " minuto"))
                        .font(.title2)
                        .foregroundColor(Color.white)
                }
                HStack{
                    Image(systemName: "dumbbell.fill")
                        .foregroundStyle(.white)
                        .frame(maxWidth: 30)
                    Text(String(count) + " exercícios")
                        .font(.title2)
                        .foregroundColor(Color.white)
                }
            }
            
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        }
        .padding()
        .frame(height: 180)
        .background(bgColor)
        .overlay(alignment: .topTrailing) {
            ZStack (
                alignment: .center
            ){
                Circle()
                    .fill(Color.gray)
                    .frame(width: 48)
                    .opacity(0.3)
                    .blendMode(.colorBurn)
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.white)
                    .clipped()
            }
            .opacity(0.9)
            .padding()
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        
    }
}


