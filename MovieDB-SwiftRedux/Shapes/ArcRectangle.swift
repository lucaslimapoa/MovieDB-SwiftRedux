//
//  ArcRectangle.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 22.08.21.
//

import SwiftUI

struct ArcRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.height * 0.75))
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.height * 0.75),
                control: CGPoint(x: rect.midX, y: rect.maxY)
            )
        }
    }
}
