//
//  TagView.swift
//  koala
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct TagView: View {
    
    @State var tag: String
    
    @State var type: moveType
    
    var body: some View {
        
        var moveColor: Color = (type == .kegel ? .kegelPurple : .stretchGreen)
        
        Text(tag)
            .font(.title3)
            .fontWeight(.medium)
            .textCase(.uppercase)
            .foregroundStyle(moveColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.quaternary)
                    .stroke(moveColor, lineWidth:2)
            }
    }
}
