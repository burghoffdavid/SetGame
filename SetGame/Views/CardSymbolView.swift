//
//  CardSymbolView.swift
//  SetGame
//
//  Created by David Burghoff on 03.08.20.
//

import SwiftUI


struct CardSymbolView: View {
    var card: SetGame<CardSymbol, CardShading, CardColor>.Card
    let colors: Dictionary<CardColor, Color> = [CardColor.red: Color.red, CardColor.blue: Color.blue, CardColor.green : Color.green]

    var body: some View{
        switch card.symbol {
        case .oval:
            switch card.shading {
            case .clear:
                RoundedRectangle(cornerRadius: 25)
                    .stroke(colors[card.color]!, lineWidth: 2.0)
                    .aspectRatio(4/2, contentMode: .fill)
            default:
                RoundedRectangle(cornerRadius: 25)
                    .fill(colors[card.color]!)
                    .aspectRatio(4/2, contentMode: .fill)
            }
        case .squiggle :
            switch card.shading {
            case .clear:
                SquiggleShape()
                    .stroke(colors[card.color]!, lineWidth: 2.0)
            default:
                SquiggleShape()
                    .stroke(colors[card.color]!, lineWidth: 2.0)
            }
        case .diamond:
            switch card.shading {
            case .clear:
                DiamondShape()
                    .stroke(colors[card.color]!, lineWidth: 2.0)
            default:
                DiamondShape()
                    .fill(colors[card.color]!)
            }
        }

    }
}
