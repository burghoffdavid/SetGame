//
//  ContentView.swift
//  SetGame
//
//  Created by David Burghoff on 02.08.20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGameViewModel: SetGameViewModel
    @State var gameOver = false
    var cardPositions: [[CGFloat]] = []
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    var body: some View {
        GeometryReader{ geometry in
        VStack{
                HStack{
                    Button(action: {
                        setGameViewModel.newGame()
                    }){
                        Image(systemName: "plus")
                    }
                    .frame(width: geometry.size.width / 3, height: geometry.size.height / 6, alignment: .center)
                        Text("Deck Cards: \(setGameViewModel.deck.count)")
                        .foregroundColor(Color.black)
                        .cardify(isSelected: false, isMatched: false, isPartOfWrongSet: false)
                        .aspectRatio(2/3, contentMode: .fit)
                        .frame(width: geometry.size.width / 3, height: geometry.size.height / 6, alignment: .center)
                    Text("Score: \(setGameViewModel.score)")
                        .frame(width: geometry.size.width / 3, height: geometry.size.height / 6, alignment: .center)
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 6, alignment: .center)
                Divider()
                Grid(setGameViewModel.dealtCards){ card in
                    GeometryReader { cardGeo in
                        CardView(card: card)
                            .onTapGesture {
                                print(card.id)
                                print(card)

                                withAnimation(.easeInOut(duration: 0.5)){
                                    setGameViewModel.chooseCard(card: card)
                                    if setGameViewModel.dealtCards.count == 0{
                                        gameOver = true
                                    }
//                                    let deckX = geometry.frame(in: .global).midX
//                                    let deckY = geometry.frame(in: .global).minY
//
//                                    let cardX = cardGeo.frame(in: .global).origin.x
//                                    let cardY = cardGeo.frame(in: .global).origin.y
//
//                                    print(geometry.frame(in: .global))
//                                    print(cardGeo.frame(in: .global))
//                                    print("------------")
//
//                                    print("Deck x:\(deckX) ")
//                                    print("Deck y:\(deckY) ")
//                                    print("local x: \(cardX)")
//                                    print("local y: \(cardY)")
//                                    print("xoffset = \(deckX - cardX)")
//                                    print("yoffset = \(deckY - cardY)")
                                }
                            }
                            .rotationEffect(Angle.degrees(card.isSelected ? 10 : 0))
                            .onAppear{
                            }
                            //.transition(AnyTransition.offset(x: -500, y: -500))
                            //.transition(AnyTransition.offset(x: 0, y: 0))
                            //.animation(.easeInOut(duration: 0.5))
//                            .offset(x: geometry.frame(in: .global).midX - cardGeo.size.width / 2 - cardGeo.frame(in: .global).origin.x, y: geometry.frame(in: .global).minY - cardGeo.frame(in: .global).origin.y)
                            .transition(AnyTransition.offset(x: geometry.frame(in: .global).midX - cardGeo.size.width / 2 - cardGeo.frame(in: .global).origin.x, y: geometry.frame(in: .global).minY - cardGeo.frame(in: .global).origin.y))
                    }
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                    .onAppear{
                        print(geometry.frame(in: .named("Card-\(card.id)")))

                    }

                }
                .onAppear{
                    withAnimation(.easeInOut(duration: 1.0)){
                        setGameViewModel.newGame()
                   }
                }

            Button("Deal New Cards"){
//                    let deckFrame = geometry.frame(in: .named("Deck"))
//                    let cardFrame = geometry.frame(in: .named("Card"))
//                    print(geometry.size)
//                    print( deckFrame)
                //print(cardFrame)
                withAnimation(.easeInOut(duration: 0.5)){
                    setGameViewModel.dealNewCards()
                }
            }
            .disabled(setGameViewModel.deck.count == 0)  // TO DO Disable instead of empty

            }

        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game Ended"), message: Text("The game has ended, your total score is: \(setGameViewModel.score)"), dismissButton: .default(Text("Restart Game"), action: {
                gameOver = false
                setGameViewModel.newGame()
            }))

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGameViewModel: SetGameViewModel())
    }
}



struct FlyCardsTransition: ViewModifier {
    let x: CGFloat
    let y: CGFloat

    func body(content: Content) -> some View {
        content.position(x: x, y: y)
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
