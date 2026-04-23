//
//  CardView.swift
//  koala
//
//  Created by User on 17/04/26.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 8)
            HStack {
                Image(systemName: "person.fill")
                    .resizable(resizingMode: .tile)
                    .frame(width: 80, height: 80, alignment: .center)
                    .padding()
                Text("Name")
                Spacer()
                Text("Duration")
            }
            .padding()
            Spacer()
        }
        .frame(maxHeight: 10)
        .padding()
    }
}

#Preview {
    CardView()
}
