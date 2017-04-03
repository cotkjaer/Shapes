//
//  UIBezierPath+Drop.swift
//  Shapes
//
//  Created by Christian Otkjær on 03/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

extension UIBezierPath
{
    public convenience init(dropWithCenter center: CGPoint, radius: CGFloat)
    {
        self.init()
        
        let r = 2*radius/3
        
        let topPoint = CGPoint(x: 0, y: 2*r)
        
        let topCtrlPoint = CGPoint(x: 0, y: r)
        
        let leftCtrlPoint = CGPoint(x: -r, y: r * 0.75)
        let rightCtrlPoint = CGPoint(x: r, y: r * 0.75)
        
        move(to: topPoint)
        
        addCurve(to: CGPoint(x: -r, y: 0), controlPoint1: topCtrlPoint, controlPoint2: leftCtrlPoint)
        
        addArc(withCenter: .zero,
               radius: r,
               startAngle: π,
               endAngle: 0,
               clockwise: true)
        
        addCurve(to: topPoint, controlPoint1: rightCtrlPoint, controlPoint2: topCtrlPoint)
        
        close()

        apply(CGAffineTransform(scaleX: 1, y: -1))

        apply(CGAffineTransform(translationX: 0, y: r / 2))
        
        apply(CGAffineTransform(translationX: center.x, y: center.y))
    }
}
