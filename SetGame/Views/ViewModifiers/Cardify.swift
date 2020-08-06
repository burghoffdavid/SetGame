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
    var isSelected: Bool 

    func body(content: Content) -> some View {
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                    .foregroundColor(isSelected ? .green : .gray)
                content
            }
            //RoundedRectangle(cornerRadius: cornerRadius)
        }
    }
}


extension View {
    func cardify (isSelected: Bool) -> some View{
        self.modifier(Cardify(isSelected: isSelected))
    }
}
