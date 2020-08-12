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

    var cardPoistions : [[CGFloat]] = []

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
                            .cardify(shadowColor: .clear)
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
                            //.transition(AnyTransition.offset(x: geometry.frame(in: .global).midX - cardGeo.size.width / 2 - cardGeo.frame(in: .global).origin.x, y: geometry.frame(in: .global).minY - cardGeo.frame(in: .global).origin.y))
                    }
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .offset(generateRandomOffset(in: geometry.size))))
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
    func generateRandomOffset(in rect: CGSize) -> CGSize{
        let radius = 1.5 * sqrt(pow(rect.width, 2) + pow(rect.height, 2))
        let centerX = rect.width/2
        let centerY = rect.height/2

        let randomAngle = CGFloat(Double.random(in: 0..<360))
        let x = centerX + radius * cos(randomAngle * CGFloat(Double.pi) / 180)
        let y = centerY + radius * sin(randomAngle * CGFloat(Double.pi) / 180)

        return CGSize(width: x, height: y)
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
