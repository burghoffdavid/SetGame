//
//  ContentView.swift
//  SetGame
//
//  Created by David Burghoff on 02.08.20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGameViewModel = SetGameViewModel()
    var body: some View {
        GeometryReader{ geometry in
        VStack{
                HStack{
                    Button(action: {
                        setGameViewModel.resetGame()
                    }){
                        Image(systemName: "plus")
                    }

                    Text("Deck Cards: \(setGameViewModel.deck.count)")

                        .cardify(isSelected: false, isMatched: false, isPartOfWrongSet: false)
                        .offset(x: -3, y: -3)
                        .cardify(isSelected: false, isMatched: false, isPartOfWrongSet: false)
                        .offset(x: -7, y: -7)
                        .cardify(isSelected: false, isMatched: false, isPartOfWrongSet: false)
                        .offset(x: -10, y: -10)
                        .cardify(isSelected: false, isMatched: false, isPartOfWrongSet: false)
                        .aspectRatio(3/2, contentMode: .fit)
                        .frame(width: 150, height: 100, alignment: .center)
                    Text("Score: \(setGameViewModel.score)")

                }

                Grid(setGameViewModel.dealtCards){ card in
                        CardView(card: card)
                            .onTapGesture {
                                setGameViewModel.chooseCard(card: card)
                            }
    //                        .rotationEffect(Angle.degrees(card.isSelected ? 10 : 0))
    //                        .rotationEffect(Angle.degrees(card.isSelected ? -10 : 0))
                            .transition(AnyTransition.offset(x: geometry.size.width / 2, y: -1000))
                            .animation(.easeInOut(duration: 1))
                }
                // TO DO Disable instead of empty
                    Button("Deal New Cards"){
                        setGameViewModel.dealNewCards()
                    }
                    .disabled(setGameViewModel.deck.count != 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}




//extension View {
//    // If condition is met, apply modifier, otherwise, leave the view untouched
//    public func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
//        Group {
//            if condition {
//                self.modifier(modifier)
//            } else {
//                self
//            }
//        }
//    }
//
//    // Apply trueModifier if condition is met, or falseModifier if not.
//    public func conditionalModifier<M1, M2>(_ condition: Bool, _ trueModifier: M1, _ falseModifier: M2) -> some View where M1: ViewModifier, M2: ViewModifier {
//        Group {
//            if condition {
//                self.modifier(trueModifier)
//            } else {
//                self.modifier(falseModifier)
//            }
//        }
//    }
//}
