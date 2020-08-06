//
//  DiamondShape.swift
//  SetGame
//
//  Created by David Burghoff on 03.08.20.
//

import SwiftUI

struct DiamondShape: Shape {


    func path(in rect: CGRect) -> Path {
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)

        var path = Path()
        path.move(to: left)
        path.addLine(to: top)
        path.addLine(to: right)
        path.addLine(to: bottom)
        path.addLine(to: left)

        return path
    }


}
