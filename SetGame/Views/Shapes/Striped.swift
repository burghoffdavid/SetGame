//
//  Stripify.swift
//  SetGame
//
//  Created by David Burghoff on 10.08.20.
//

import SwiftUI

struct Stripes : Shape {
    var interval: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let numberOfStripes = Int(rect.width)

        path.move(to: rect.origin)
        for i in 0...numberOfStripes{
            path.move(to: CGPoint(x: CGFloat(i*interval), y: rect.minY))
            if i % 2 == 0 {
                path.addLine(to: CGPoint(x: CGFloat(i*interval), y: rect.maxY))
            }


        }

        return path
    }

}
