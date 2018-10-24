//
//  UIBezierPath+Squircle.swift
//  Shapes
//
//  Created by Christian Otkjær on 24/10/2018.
//  Copyright © 2018 Silverback IT. All rights reserved.
//

import Foundation

extension UIBezierPath
{
    public convenience init(squircleIn rect: CGRect, n: Int = 4)
    {
        self.init()
        
        guard n > 2 else { return }
        
        move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        addCurve(to: CGPoint(x:rect.maxX, y: rect.midY),
                 controlPoint1: CGPoint(x:rect.maxX, y: rect.minY),
                 controlPoint2: CGPoint(x:rect.maxX, y: rect.minY))
        
        addCurve(to: CGPoint(x:rect.midX, y: rect.maxY),
                 controlPoint1: CGPoint(x:rect.maxX, y: rect.maxY),
                 controlPoint2: CGPoint(x:rect.maxX, y: rect.maxY))
        
        addCurve(to: CGPoint(x:rect.minX, y: rect.midY),
                 controlPoint1: CGPoint(x:rect.minX, y: rect.maxY),
                 controlPoint2: CGPoint(x:rect.minX, y: rect.maxY))
        
        addCurve(to: CGPoint(x:rect.midX, y: rect.minY),
                 controlPoint1: CGPoint(x:rect.minX, y: rect.minY),
                 controlPoint2: CGPoint(x:rect.minX, y: rect.minY))
        
        close()
    }

    public convenience init(squircleIn rect: CGRect, softness: CGFloat? = nil)
    {
        self.init()
        
        let softness = min(1, max(0, abs(softness ?? 0)))
        
        let dx = softness * rect.width / 2
        let dy = softness * rect.height / 2

        move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        addCurve(to: CGPoint(x:rect.maxX, y: rect.midY),
                 controlPoint1: CGPoint(x:rect.maxX - dx, y: rect.minY),
                 controlPoint2: CGPoint(x:rect.maxX, y: rect.minY + dy))
        
        addCurve(to: CGPoint(x:rect.midX, y: rect.maxY),
                 controlPoint1: CGPoint(x:rect.maxX, y: rect.maxY - dy),
                 controlPoint2: CGPoint(x:rect.maxX - dx, y: rect.maxY))
        
        addCurve(to: CGPoint(x:rect.minX, y: rect.midY),
                 controlPoint1: CGPoint(x:rect.minX + dx, y: rect.maxY),
                 controlPoint2: CGPoint(x:rect.minX, y: rect.maxY - dy))
        
        addCurve(to: CGPoint(x:rect.midX, y: rect.minY),
                 controlPoint1: CGPoint(x:rect.minX, y: rect.minY + dy),
                 controlPoint2: CGPoint(x:rect.minX + dx, y: rect.minY))
        
        close()
    }
}
