//
//  SquiggleShape.swift
//  SetGame
//
//  Created by David Burghoff on 03.08.20.
//

import SwiftUI

struct SquiggleShape: Shape {
    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let left = CGPoint(x: rect.minX, y: rect.maxY)
//        let top = CGPoint(x: rect.midX, y: rect.minY)
//        let right = CGPoint(x: rect.maxX, y: rect.minY)
//        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
//
//        let bezierBottomControl1 = CGPoint(x: rect.midX * (1/3), y: rect.maxY * (1/3))
//        let bezierBottomControl2 = CGPoint(x: rect.midX * (2/3), y: rect.maxY * (2/3))
//
//
//        let distanceXBottomToRight:CGFloat = right.x - bottom.x
//        let distanceYBottomToRight: CGFloat = bottom.y - right.y
//        let bezierRightControl1 = CGPoint(x: distanceXBottomToRight * (1/3), y: distanceYBottomToRight * (1/3))
//        let bezierRightControl2 = CGPoint(x: distanceXBottomToRight * (2/3), y: distanceYBottomToRight * (2/3))
//
//
//
//        path.move(to: left)
//        path.addCurve(to: bottom, control1: bezierBottomControl1, control2: bezierBottomControl2)
//        path.addCurve(to: right, control1: bezierRightControl1, control2: bezierRightControl2)
//        return path
        let width  = rect.maxX - rect.minX
        let height = rect.maxY - rect.minY

        let bottomLeft      = CGPoint(x:  rect.minX + width*indentFactor,       y: rect.maxY-yIndentFactor*height)
        let topLeft         = CGPoint(x:  rect.minX + width*doubleIndentFactor, y: rect.minY+yIndentFactor*height)
        let topRight        = CGPoint(x:  rect.maxX - width*indentFactor,       y: rect.minY+yIndentFactor*height)
        let bottomRight     = CGPoint(x:  rect.maxX - width*doubleIndentFactor, y: rect.maxY-yIndentFactor*height)

        let controlTopTop       = CGPoint(x: topLeft.x+(topRight.x-topLeft.x)/(2.6), y:topLeft.y-yControlOffset*height)
        let controlTopBottom    = CGPoint(x: topLeft.x+(topRight.x-topLeft.x)/(2.6), y:topLeft.y+yControlOffset*height)

        let controlBottomTop       = CGPoint(x: bottomLeft.x+(bottomRight.x-bottomLeft.x)/(1.6), y:bottomLeft.y-yControlOffset*height)
        let controlBottomBottom    = CGPoint(x: bottomLeft.x+(bottomRight.x-bottomLeft.x)/(1.6), y:bottomLeft.y+yControlOffset*height)

        var p = Path()
        p.move(to: bottomLeft)
        p.addLine(to: topLeft)
        p.addCurve(to: topRight,control1: controlTopBottom,control2:controlTopTop )
        p.addLine(to: bottomRight)
        p.addCurve(to: bottomLeft,control1:controlBottomTop,control2:controlBottomBottom )

        return p
   }
   private let indentFactor : CGFloat = 0.05
   private let doubleIndentFactor : CGFloat = 0.2
   private let yIndentFactor : CGFloat = 0.2
   private let yControlOffset: CGFloat = 0.3


}
