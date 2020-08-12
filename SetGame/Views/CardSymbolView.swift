//
//  CardSymbolView.swift
//  SetGame
//
//  Created by David Burghoff on 03.08.20.
//

import SwiftUI


struct CardSymbolView: View {
    var card: SetGame<CardSymbol, CardShading, CardColor>.Card

    var color: Color {
        switch card.color {
        case .blue:
            return .blue
        case .green:
            return .green
        case .red:
            return .red
        }
    }

    func getShape(symbol: CardSymbol) -> some Shape{
        switch symbol {
        case .oval:
            return AnyShape(RoundedRectangle(cornerRadius: 25))
        case .diamond:
            return AnyShape(DiamondShape())
        case .squiggle:
            return AnyShape(SquiggleShape())
        }
    }

    var body: some View{
        getShape(symbol: card.symbol)
            .shadingModifier(card.shading)
            .foregroundColor(color)
    }
}

extension Shape {
    func shadingModifier (_ shading: CardShading) -> some View{
        switch shading {
        case .solid:
           return
            AnyView(self.fill())
        case .clear:
            return AnyView(self.stroke(lineWidth: 1.5))
        case .striped:
            return AnyView( ZStack{
                self.stroke(lineWidth: 1.5)
                Stripes(interval: 2).stroke().mask(self)
            })
        }

    }
}


struct AnyShape: Shape {
    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }

    private let _path: (CGRect) -> Path
}

