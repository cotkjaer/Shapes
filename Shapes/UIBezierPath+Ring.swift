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
        self.init(arcCenter: center, radius: outerRadius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        close()
        
        move(to: CGPoint(x: 0, y: innerRadius))
        
        self.addArc(withCenter: center, radius: innerRadius, startAngle: 0, endAngle: .pi * 2, clockwise: false)
        
        close()
    }
}

