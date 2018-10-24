//
//  UIBezierPath+Obround.swift
//  Shapes
//
//  Created by Christian Otkjær on 21/10/2018.
//  Copyright © 2018 Silverback IT. All rights reserved.
//

import Foundation

extension UIBezierPath
{
    convenience init(obroundIn rect: CGRect)
    {
        let radius = min(rect.width, rect.height) / 2
        
        self.init()
        
        addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: 0, endAngle: .pi / 2, clockwise: true)
//        addLine(to: CGPoint(x: rect.minX + radius, y: rect.minY))
        addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: .pi / 2, endAngle: .pi, clockwise: true)
//        addLine(to: CGPoint(x: rect.minX, y: rect.maxY - radius))
        addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: .pi, endAngle:  3 * .pi / 2, clockwise: true)
//        addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle:  3 * .pi / 2, endAngle: 2 * .pi, clockwise: true)
        close()
        
        
//        self.init(roundedRect: rect, cornerRadius: radius)
    }
}
