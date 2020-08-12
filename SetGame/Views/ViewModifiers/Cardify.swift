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
    var isMatched: Bool
    var isPartOfWrongSet: Bool

    func body(content: Content) -> some View {
        ZStack{
            Group{
                if isPartOfWrongSet{
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.orange)
                }else{
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(isMatched ? Color.gray : Color.white)
                }
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                    .foregroundColor(.gray)
                content
            }
        }
    }
}


extension View {
    func cardify (isSelected: Bool, isMatched: Bool, isPartOfWrongSet: Bool) -> some View{
        self.modifier(Cardify(isSelected: isSelected, isMatched: isMatched, isPartOfWrongSet: isPartOfWrongSet))
    }
}
