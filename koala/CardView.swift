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
        
        let bgColor: Color = ((thisRoutine.type == .kegel) ? Color.purple : Color.green)
        let title = thisRoutine.name
        let length = thisRoutine.length
        let count = thisRoutine.count
        let image = thisRoutine.image
        
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(bgColor)
                HStack {
                    Spacer()
                    Image(image)
                        .resizable(resizingMode: .stretch)
                        .frame(width: 150, height: 150)
                        .padding([.trailing], 50)
                }
            
            HStack {
                VStack (
                    alignment: .leading,
                    spacing: 4
                ){
                    Text(title)
                        .font(.system(size: 22, weight: .bold))
                        .frame(width: 200)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                        .lineLimit(2)
                    Spacer()
                    Text(String(Int(length/60)) + " minutos")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(Color.white)
                    Text(String(count) + " exercícios")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
            .padding()
            Spacer()
            VStack {
                HStack {
                    Spacer()
                    ZStack (
                        alignment: .center
                    ){
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 60)
                            .opacity(0.5)
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.white)
                    }
                    .opacity(0.9)
                }
                Spacer()
            }
            .padding(20)
            
        }
        .frame(maxHeight: 10)
        .padding()
    }
}
