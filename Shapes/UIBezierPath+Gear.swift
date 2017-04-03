//
//  UIBezierPath+Gear.swift
//  Shapes
//
//  Created by Christian Otkjær on 02/02/17.
//  Copyright © 2017 Christian Otkjær. All rights reserved.
//

extension UIBezierPath
{
    public convenience init(gearWithCenter center: CGPoint,
                            innerRadius: CGFloat,
                            outerRadius: CGFloat,
                            cogs: Int)
    {
        self.init()
        
        guard cogs > 2 else { return }
        
        let angle = π / CGFloat(cogs)
        
        var radius = (outerRadius, innerRadius)
        
        addArc(withCenter: .zero, radius: innerRadius/2, startAngle: 0, endAngle: π2, clockwise: true)
        
        move(to: CGPoint(x: radius.0, y: 0))
        
        for _ in 0..<cogs*2
        {
            addArc(withCenter: .zero, radius: radius.0, startAngle: 0, endAngle: -angle, clockwise: false)
            
            apply(CGAffineTransform(rotationAngle: angle))
            
            swap(&radius.0, &radius.1)
        }
        
        close()
        
        apply(CGAffineTransform(translationX: center.x, y: center.y))
    }
}
