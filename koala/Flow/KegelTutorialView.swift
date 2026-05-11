//
//  KegelTutorialView.swift
//  koala
//
//  Created by User on 06/05/26.
//

import SwiftUI

struct KegelTutorialView: View {
    
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Color(.kegelLight)
                Text("O que é Kegel?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 40)
            )
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.top)
            .padding(.top)
            .padding(.vertical)
            
          
            Text(
                "Os exercícios de Kegel são uma prática simples e eficaz para fortalecer os músculos do assoalho pélvico."
            )
            .font(.title2)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .foregroundStyle(.kegelDark)
            
            ZStack {
                Color(.kegelLight)
                Text("Como identificar o assoalho pélvico?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .padding(20)
                    .foregroundStyle(.white)
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 40)
            )
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.top)
            
            Text(
                "Uma forma simples de fazer isso é contrair o músculo que você usaria para segurar o xixi."
            )
            .font(.title2)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.top)
            .foregroundStyle(.kegelDark)
            
            Text(
                "Este músculo é o que deve ser contraído durante os exercícios."
            )
            .font(.title2)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.top)
            .foregroundStyle(.kegelDark)
            
            
            Spacer()
            
            //BOTAO DE FECHAR//////
            
            //KegelView()
            Button {
                dismiss.callAsFunction()
            } label: {
                Text("Fechar")
                    .font(.title)
                    .fontWeight(.medium)
                    .tint(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 32)
                            .fill(.kegelPurple)
                    )
                
                    .padding()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    KegelTutorialView()
}
