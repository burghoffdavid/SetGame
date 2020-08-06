//
//  SetGame.swift
//  SetGame
//
//  Created by David Burghoff on 02.08.20.
//

import Foundation

struct SetGame<Symbols, Shadings, Colors> where Symbols: CaseIterable & Equatable, Shadings: CaseIterable & Equatable, Colors: CaseIterable & Equatable{
    private(set) var deck: [Card]
    private(set) var dealtCards: [Card]
    private (set) var totalCards: Int
    var selectedCards: [Card] {
        dealtCards.filter{$0.isSelected}
    }
    var matchFound: Bool{
        dealtCards.filter{$0.isMatched}.count == 3
    }
    var score: Int = 0

    init() {
        deck = [Card]()
        for number in 1...3{
            for symbol in Symbols.allCases{
                for shading in Shadings.allCases{
                    for color in Colors.allCases{
                        deck.append(Card(number: number, symbol: symbol, shading: shading, color: color))
                    }
                }
            }
        }
        //deck.shuffle()
        totalCards = deck.count
        dealtCards = []
        for _ in 0..<12{
            dealtCards.append(deck.popLast()!)
        }
        print(dealtCards.count)
        print(deck.count)

    }


    mutating func userRequestsNewCards(){
        if deck.count == 0 {return}
        if matchFound{
            dealNewCards()
        }else{
            for i in 0...2{
                dealtCards.append(deck.popLast()!)
            }
        }


    }

    mutating func chooseCard(card: Card){
        print("Selected Cards: \(selectedCards.count)!")
        let index = dealtCards.firstIndex(matching: card)!
        if selectedCards.count < 3 {
            dealtCards[index].isSelected.toggle()
            if selectedCards.count == 3 {
                let selectedCardsMakeASet: Bool = checkSetMatch(for: selectedCards)
                for card in selectedCards{
                    let index = dealtCards.firstIndex(matching: card)
                    if let unwrappedIndex = index{
                        if selectedCardsMakeASet{
                            dealtCards[unwrappedIndex].isMatched = true
                        }else{
                            dealtCards[unwrappedIndex].isPartOfWrongSet = true
                        }
                    }
                }
            }

        }else if selectedCards.count == 3{
            print("3 Selected Cards!")
            // Case we have Match!
            if matchFound{
                score += 3
                // check if new selected card is not part of a matching set
                if !dealtCards[index].isMatched{
                    dealtCards[index].isSelected.toggle()
                }
                dealNewCards()

            //CASE:  we dont have match
            }else {
                dealtCards[index].isSelected = true
                // reset dealtCards to not selected and not partofwrongset
                for i in 0..<dealtCards.count{
                    dealtCards[i].isPartOfWrongSet = false

                    if card.id != dealtCards[i].id{
                        dealtCards[i].isSelected = false
                    }

                }
            }
        }
    }

    mutating func dealNewCards (){
        for i in 0..<dealtCards.count{
            if dealtCards[i].isMatched{
                if let newCard = deck.popLast(){
                    dealtCards[i] = newCard
                }else {
                    dealtCards.removeAll{$0.isMatched}
                    return
                }
            }
        }
    }

    func checkSetMatch (for setToCheck: [Card]) -> Bool{
            (
                compareFeature(input1: setToCheck[0].number, input2: setToCheck[1].number,   input3: setToCheck[2].number) &&
                compareFeature(input1: setToCheck[0].symbol, input2: setToCheck[1].symbol,   input3: setToCheck[2].symbol) &&
                compareFeature(input1: setToCheck[0].shading, input2: setToCheck[1].shading,   input3: setToCheck[2].shading) &&
                compareFeature(input1: setToCheck[0].color, input2: setToCheck[1].color,   input3: setToCheck[2].color)
            )

    }

    func compareFeature<T:Equatable> (input1: T, input2: T, input3: T) -> Bool{
        print((input1 == input2 && input1 == input3) || (input1 != input2 && input1 != input3))
        return (input1 == input2 && input1 == input3) || (input1 != input2 && input1 != input3)

    }
    struct Card: Identifiable{
        var id = UUID()
        var number: Int
        var symbol: Symbols
        var shading: Shadings
        var color: Colors

        var isSelected: Bool = false
        var isMatched: Bool = false
        var isPartOfWrongSet: Bool = false
    }

}

