//
//  CardView.swift
//  koala
//
//  Created by User on 17/04/26.
//

import SwiftUI

struct CardView: View {
    
    @State var thisRoutine: Routine
    
    @State var thisType: moveType = thisRoutine.type
    
    @State var bgColor: Color = ((thisRoutine.type == .kegel) ? Color.purple : Color.green)
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(bgColor)
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
