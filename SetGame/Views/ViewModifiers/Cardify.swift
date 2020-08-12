//
//  Cardify.swift
//  Memorize
//
//  Created by David Burghoff on 01.08.20.
//

import SwiftUI

struct Cardify: AnimatableModifier { 

    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 5.0
    private let edgeLineWidth: CGFloat = 2
    private let fontScaleFactor: CGFloat = 0.6
    var shadowColor: Color

    func body(content: Content) -> some View {
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .shadow(color: shadowColor, radius: 20)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                    .foregroundColor(.gray)
                content

            }

        }

    }
}


extension View {
    func cardify (shadowColor: Color) -> some View{
        self.modifier(Cardify(shadowColor: shadowColor))
    }
}
