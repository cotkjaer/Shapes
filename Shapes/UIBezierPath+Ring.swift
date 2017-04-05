//
//  UIBezierPath+Ring.swift
//  Shapes
//
//  Created by Christian Otkjær on 03/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit

// MARK: - Ring

extension UIBezierPath
{
    public convenience init(ringWithCenter center: CGPoint,
                            innerRadius: CGFloat,
                            outerRadius: CGFloat)
    {
        self.init(arcCenter: .zero, radius: innerRadius, startAngle: 0, endAngle: π2, clockwise: true)
        
//        close()
        
        move(to: CGPoint(x: outerRadius, y: 0))
        
        addArc(withCenter: .zero, radius: outerRadius, startAngle: 0, endAngle: π2, clockwise: true)
        
//        close()
        
        apply(CGAffineTransform(translationX: center.x, y: center.y))
        
        usesEvenOddFillRule = true
    }
}

