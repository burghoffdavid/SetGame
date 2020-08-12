//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by David Burghoff on 02.08.20.
//

import Foundation

class SetGameViewModel: ObservableObject {
    @Published private(set) var model: SetGame<CardSymbol, CardShading, CardColor>?

    //MARK: - Acces to the model
    var deck: [SetGame<CardSymbol, CardShading, CardColor>.Card] {
        model?.deck ?? [SetGame<CardSymbol, CardShading, CardColor>.Card]()
    }
    var dealtCards: [SetGame<CardSymbol, CardShading, CardColor>.Card]{
        model?.dealtCards ?? [SetGame<CardSymbol, CardShading, CardColor>.Card]()
    }

    var score:  Int{
        model?.score ?? 0
    }
    
    private static func createSetGame () -> SetGame<CardSymbol, CardShading, CardColor>{
        return SetGame<CardSymbol, CardShading, CardColor>()
    }

    //MARK: - Intents

    func chooseCard(card: SetGame<CardSymbol, CardShading, CardColor>.Card){
        model!.chooseCard(card: card)
    }
    func dealNewCards(){
        model!.userRequestsNewCards()
    }

    func newGame(){
        model = SetGameViewModel.createSetGame()
    }

}

enum CardSymbol: CaseIterable{
    case diamond
    case squiggle
    case oval
}

enum CardShading: CaseIterable{
    case clear
    case striped
    case solid
}

enum CardColor: CaseIterable{
    case red
    case green
    case blue
}
