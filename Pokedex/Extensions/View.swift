//
//  View.swift
//  Pokedex
//
//  Created by Aldo Yael Navarrete Zamora on 01/12/23.
//

import SwiftUI

struct CustomButton: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 150)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill (
                        .blue
                    )
            )
            .foregroundStyle(.white)
    }
}

extension View {
    func customButtonModifier(withColor color: Color) -> some View {
        modifier(CustomButton(color: color))
    }
}
