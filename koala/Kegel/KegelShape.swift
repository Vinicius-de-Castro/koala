//
//  KegelShape.swift
//  koala
//
//  Created by User on 27/04/26.
//

import SwiftUI

struct KegelShape: View {
    @State var isAnimating = false
    
    let fraction: Double
    let primatyText: String
    let secondText: String
    
    var body: some View {
        ZStack{
        Circle()
                .fill(Color("Purple")).opacity(0.5)
            
        
            //TIMER
        Text(primatyText)
            .foregroundStyle(Color.black)
            .font(.system(size: 50, weight: .semibold,design: .rounded))
            //TEXTO DO KEGEL, EX: "RESPIRAR"
        Text(secondText)
            .foregroundStyle(Color.gray)
            .offset(y: 50)
            
        }
        .padding()
        
    }
}

#Preview {
    KegelShape(fraction: 0.5, primatyText: "10", secondText: "RESPIRAR")
}




//CIRCULO PULSANDO

//Circle()
    //.stroke(lineWidth: 10)
    //.frame(width: isAnimating ? 150: 80, height: isAnimating ? 150:80)
    //.onAppear(perform: {
        //withAnimation(.easeOut(duration: 2).repeatForever()) {
        //    isAnimating = true
      //  }
    //})
