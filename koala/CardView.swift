//
//  CardView.swift
//  koala
//
//  Created by User on 17/04/26.
//

import SwiftUI

struct CardView: View {
    
    @State var test: moveType
    
    @State var bgColor: Color = Color.white
    
    var body: some View {
        
//        switch test {
//        case .stretch:
//            bgColor = Color.purple
//        case .kegel:
//            bgColor = Color.purple
//        }
        
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill((test == .kegel) ? Color.purple : Color.green)
                .shadow(radius: 8)
            HStack {
                VStack (
                    alignment: .leading
                ){
                    Text("Alongamento tal")
                    Spacer()
                    Text("Duração")
                    Text("Mais algo")
                }
                Spacer()
                Image(systemName: "person.fill")
                    .resizable(resizingMode: .tile)
                    .frame(width: 80, height: 80, alignment: .center)
                    .padding()
            }
            .padding()
            Spacer()
            
        }
        .frame(maxHeight: 10)
        .padding()
    }
}

#Preview {
    CardView(test: moveType.stretch)
}
