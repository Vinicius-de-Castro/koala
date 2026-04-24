//
//  CarrouselView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct CarrouselView: View {
    
    var body: some View {
        ScrollView (.horizontal) {
            HStack {
                ForEach(0..<10) {_ in 
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.green)
                        .frame(width: 350, height: 300)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .padding()
    }
}
