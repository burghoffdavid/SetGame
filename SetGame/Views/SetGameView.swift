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

    var body: some View {
        GeometryReader{ geometry in
        VStack{
                HStack{
                    Button(action: {
                        setGameViewModel.newGame()
                    }){
                        Image(systemName: "plus")
                    }
                    .frame(width: geometry.size.width / 3, height: geometry.size.height / headerProportionHeightSize, alignment: .center)
                        Text("Deck Cards: \(setGameViewModel.deck.count)")
                        .foregroundColor(Color.black)
                            .cardify(shadowColor: .clear)
                        .aspectRatio(2/3, contentMode: .fit)
                        .frame(width: geometry.size.width / headerProportionWidthSize, height: geometry.size.height / headerProportionHeightSize, alignment: .center)
                    Text("Score: \(setGameViewModel.score)")
                        .frame(width: geometry.size.width / headerProportionWidthSize, height: geometry.size.height / headerProportionHeightSize, alignment: .center)
                }
                .frame(width: geometry.size.width, height: geometry.size.height / headerProportionHeightSize, alignment: .center)
                Divider()
                Grid(setGameViewModel.dealtCards){ card in
                    GeometryReader { cardGeo in
                        CardView(card: card)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: cardAnimationDuration)){
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
                            .rotationEffect(Angle.degrees(card.isSelected ? cardRotationAngle : 0))
                            //TO-DO: - Find a way to access cardGeo outside of Geometry Reader View to fly in Cards from deck, alternativ: get location without geometry reader
                            //.transition(AnyTransition.offset(x: geometry.frame(in: .global).midX - cardGeo.size.width / 2 - cardGeo.frame(in: .global).origin.x, y: geometry.frame(in: .global).minY - cardGeo.frame(in: .global).origin.y))
                    }
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .offset(generateRandomOffset(in: geometry.size))))
                }
                .onAppear{
                    withAnimation(.easeInOut(duration: cardAnimationDuration)){
                        setGameViewModel.newGame()
                   }
                }
            Button("Deal New Cards"){
                withAnimation(.easeInOut(duration: cardAnimationDuration)){
                    setGameViewModel.dealNewCards()
                }
            }
            .disabled(setGameViewModel.deck.count == 0)
            }
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game Ended"), message: Text("The game has ended, your total score is: \(setGameViewModel.score)"), dismissButton: .default(Text("Restart Game"), action: {
                gameOver = false
                setGameViewModel.newGame()
            }))

        }
    }


    //MARK: - Drawing Constants
    let cardRotationAngle: Double = 10.0
    let cardAnimationDuration = 0.5
    let headerProportionHeightSize: CGFloat = 6
    let headerProportionWidthSize: CGFloat = 3

    //MARK: - Generate Random Offsets

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
