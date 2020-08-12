//
//  CardView.swift
//  SetGame
//
//  Created by David Burghoff on 03.08.20.
//

import SwiftUI

struct CardView: View {
    var card: SetGame<CardSymbol, CardShading, CardColor>.Card
    private let cardAspectRatio  : CGFloat = 2/3
    private let shapeWidthScale : CGFloat = 0.5
    private let shapeHeightScale : CGFloat = 6

    @ViewBuilder
    var body: some View {
        GeometryReader{geometry in
                VStack{
                        ForEach(0..<card.number){shape in
                            CardSymbolView(card: card)
                        }
                        .frame(width: min(geometry.size.width, geometry.size.height*cardAspectRatio) * shapeWidthScale, height: min(geometry.size.height,geometry.size.width/cardAspectRatio)/shapeHeightScale)
                        //.opacity(card.shading == .striped ? 0.3 : 1)
                }
                .cardify(isSelected: card.isSelected, isMatched: card.isMatched, isPartOfWrongSet: card.isPartOfWrongSet)
                .padding()
            // Transition um die Karten rein und rausfliegen zu lassen (offset)

            }

    }
}


