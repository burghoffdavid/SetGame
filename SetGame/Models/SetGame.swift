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
    private (set) var score: Int = 0

    // Internal Variables
    private var selectedCards: [Card] {
        dealtCards.filter{$0.isSelected}
    }
    private var matchFound: Bool{
        dealtCards.filter{$0.isMatched}.count == 3
    }
    private var baseScorePerMatch: Double = 30
    private var scorePenaltyMatchAvailable = -5

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
        dealtCards = []
        for _ in 0..<12{
            dealtCards.append(deck.popLast()!)
        }
        lastMatchedSetTime = Date()
    }


    mutating func chooseCard(card: Card){
        let index = dealtCards.firstIndex(matching: card)!
        if selectedCards.count < 3 {
            dealtCards[index].isSelected.toggle()
            if selectedCards.count == 3 {
                let selectedCardsMakeASet: Bool = checkSetMatch(for: selectedCards)
                if selectedCardsMakeASet{calculateScore()}
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

                if dealtCards.count == 3 {
                    calculateScore()
                    dealtCards.removeAll()
                }
            }

        }else if selectedCards.count == 3{
            // CASE: We have Match!
            if matchFound{

                // check if new selected card is not part of a matching set
                if !dealtCards[index].isMatched{
                    dealtCards[index].isSelected.toggle()
                }
                dealNewCards()

            //CASE: We dont have match
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
    func checkSetMatch (for setToCheck: [Card]) -> Bool{
            (
                compareFeature(input1: setToCheck[0].number, input2: setToCheck[1].number,   input3: setToCheck[2].number) &&
                compareFeature(input1: setToCheck[0].symbol, input2: setToCheck[1].symbol,   input3: setToCheck[2].symbol) &&
                compareFeature(input1: setToCheck[0].shading, input2: setToCheck[1].shading,   input3: setToCheck[2].shading) &&
                compareFeature(input1: setToCheck[0].color, input2: setToCheck[1].color,   input3: setToCheck[2].color)
            )

    }

    func compareFeature<T:Equatable> (input1: T, input2: T, input3: T) -> Bool{
        return (input1 == input2 && input1 == input3) || (input1 != input2 && input1 != input3)

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


    mutating func userRequestsNewCards(){
        if deck.count == 0 {return}
        if matchFound{
            dealNewCards()
        }else{
            var matchWasAvailable = false
            for i in 0 ..< dealtCards.count{
                for j in 0 ..< dealtCards.count{
                    for k in 0 ..< dealtCards.count{
                        if (i == j || j == k || i == k){continue}
                        if checkSetMatch(for: [dealtCards[i], dealtCards[j], dealtCards[k]]){
                            matchWasAvailable = true
                            break
                        }
                    }
                }
            }
            if matchWasAvailable{
                score -= scorePenaltyMatchAvailable
            }
            for _ in 0...2{
                dealtCards.append(deck.popLast()!)
            }
        }
    }


    // Calculate Score
    private var lastMatchedSetTime: Date?

    private var timeSinceLastMatch: TimeInterval{
        if let lastMatchedSetTime = lastMatchedSetTime{
            return Date().timeIntervalSince(lastMatchedSetTime)
        }else{
            return 0
        }
    }

    mutating func calculateScore (){
        if lastMatchedSetTime != nil{
            var scoreForSet = Int(baseScorePerMatch - timeSinceLastMatch)
            if scoreForSet <= 0{scoreForSet = 1}
            score += scoreForSet
            self.lastMatchedSetTime = Date()
        }else {
            fatalError("time not initiated")
        }
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

