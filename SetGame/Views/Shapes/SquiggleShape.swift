//
//  SquiggleShape.swift
//  SetGame
//
//  Created by David Burghoff on 03.08.20.
//

import SwiftUI
//func path(in rect: CGRect) -> Path {
//
//    let width  = rect.maxX - rect.minX
//    let height = rect.maxY - rect.minY
//
//    let bottomLeft      = CGPoint(x:  rect.minX + width*indentFactor,       y: rect.maxY-yIndentFactor*height)
//    let topLeft         = CGPoint(x:  rect.minX + width*doubleIndentFactor, y: rect.minY+yIndentFactor*height)
//    let topRight        = CGPoint(x:  rect.maxX - width*indentFactor,       y: rect.minY+yIndentFactor*height)
//    let bottomRight     = CGPoint(x:  rect.maxX - width*doubleIndentFactor, y: rect.maxY-yIndentFactor*height)
//
//    let controlTopTop       = CGPoint(x: topLeft.x+(topRight.x-topLeft.x)/(2.6), y:topLeft.y-yControlOffset*height)
//    let controlTopBottom    = CGPoint(x: topLeft.x+(topRight.x-topLeft.x)/(2.6), y:topLeft.y+yControlOffset*height)
//
//    let controlBottomTop       = CGPoint(x: bottomLeft.x+(bottomRight.x-bottomLeft.x)/(1.6), y:bottomLeft.y-yControlOffset*height)
//    let controlBottomBottom    = CGPoint(x: bottomLeft.x+(bottomRight.x-bottomLeft.x)/(1.6), y:bottomLeft.y+yControlOffset*height)
//
//    var p = Path()
//    p.move(to: bottomLeft)
//    p.addLine(to: topLeft)
//    p.addCurve(to: topRight,control1: controlTopBottom,control2:controlTopTop )
//    p.addLine(to: bottomRight)
//    p.addCurve(to: bottomLeft,control1:controlBottomTop,control2:controlBottomBottom )
//
//    return p
//}
//private let indentFactor : CGFloat = 0.05
//private let doubleIndentFactor : CGFloat = 0.2
//private let yIndentFactor : CGFloat = 0.2
//private let yControlOffset: CGFloat = 0.3

struct SquiggleShape: Shape {

    func path(in rect: CGRect) -> Path {
           let dX = rect.width / 100
           let dY = rect.height / 100
           let originX = rect.minX
           let originY = rect.minY
           var path = Path()

           let points: [CGPoint] = [
               CGPoint(x: originX + (dX * 0), y: originY + (dY * 50)),
               CGPoint(x: originX + (dX * 10), y: originY + (dY * 5)),
               CGPoint(x: originX + (dX * 30), y: originY + (dY * 7)),
               CGPoint(x: originX + (dX * 50), y: originY + (dY * 20)),
               CGPoint(x: originX + (dX * 65), y: originY + (dY * 25)),
               CGPoint(x: originX + (dX * 85), y: originY + (dY * 0)),
               CGPoint(x: originX + (dX * 90), y: originY + (dY * 5)),
               CGPoint(x: originX + (dX * 100), y: originY + (dY * 50)),
               CGPoint(x: originX + (dX * 90), y: originY + (dY * 95)),
               CGPoint(x: originX + (dX * 70), y: originY + (dY * 93)),
               CGPoint(x: originX + (dX * 50), y: originY + (dY * 80)),
               CGPoint(x: originX + (dX * 35), y: originY + (dY * 75)),
               CGPoint(x: originX + (dX * 15), y: originY + (dY * 100)),
               CGPoint(x: originX + (dX * 10), y: originY + (dY * 95)),
               CGPoint(x: originX + (dX * 0), y: originY + (dY * 50)),
               CGPoint(x: originX + (dX * 10), y: originY + (dY * 5))
           ]

           var startPoint = CGPoint()
           var previousPoint = CGPoint()

           for (index, point) in points.enumerated() {
               switch index {
               case 0:
                   startPoint = point
               case 1:
                   path.move(to: startPoint.midPoint(to: point))
                   previousPoint = point
               default:
                   path.addQuadCurve(to: previousPoint.midPoint(to: point), control: previousPoint)
                   previousPoint = point
               }
           }
           path.addQuadCurve(to: previousPoint.midPoint(to: startPoint), control: previousPoint)
           path.closeSubpath()
           return path
       }
    }

extension CGPoint {
   func midPoint(to destination: CGPoint) -> CGPoint {
       return CGPoint(x: (x + destination.x) / 2, y: (y + destination.y) / 2)
   }
}
