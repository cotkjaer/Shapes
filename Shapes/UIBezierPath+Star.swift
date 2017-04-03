//
//  UIBezierPath+Star.swift
//  Shapes
//
//  Created by Christian Otkjær on 02/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit

extension UIBezierPath
{
    public convenience init(starWithCenter center: CGPoint,
                            innerRadius: CGFloat,
                            outerRadius: CGFloat,
                            points: Int)
    {
        self.init()
        
        guard points > 2 else { return }
        
        let angle = CGFloat.pi / CGFloat(points)
        
        var radius = (outerRadius, innerRadius)
        
        move(to: CGPoint(x: radius.0, y: 0))
        
        for _ in 0..<points*2
        {
            apply(CGAffineTransform(rotationAngle: angle))
            
            swap(&radius.0, &radius.1)
            
            addLine(to: CGPoint(x: radius.0, y: 0))
        }
        
        apply(CGAffineTransform(rotationAngle: -.pi/2))

        apply(CGAffineTransform(translationX: center.x, y: center.y))
        
        close()
    }
    
    public convenience init(starWithCenter center: CGPoint,
                            innerRadius: CGFloat,
                            outerRadius: CGFloat,
                            points: Int,
                            softness s: CGFloat)
    {
        guard s != 0 else { self.init(starWithCenter: center, innerRadius: innerRadius, outerRadius: outerRadius, points: points); return }
        
        
        self.init()
        
        guard points > 2 else { return }
        
        let softness = min(1, max(0, s)) / 2
        
        let halfStepAngle = CGFloat.pi / CGFloat(points)
        
        let outerAngles = (0..<points).map({ CGFloat($0) * 2 * halfStepAngle })
        let outerPoints = outerAngles.map({ CGPoint(bearing: $0, distance: outerRadius)})
        let innerAngles = outerAngles.map({ $0 + halfStepAngle })
        let innerPoints = innerAngles.map({ CGPoint(bearing: $0, distance: innerRadius)})
        
        func nextInner(outerIndex: Int) -> CGPoint
        {
            return innerPoints[outerIndex]
        }
        
        func prevInner(outerIndex: Int) -> CGPoint
        {
            guard outerIndex > 0 else { return innerPoints[innerPoints.endIndex - 1] }
            return innerPoints[outerIndex - 1]
        }
        
        func nextOuter(innerIndex: Int) -> CGPoint
        {
            guard innerIndex + 1 < outerPoints.endIndex else { return outerPoints[outerPoints.startIndex] }
            return outerPoints[innerIndex + 1]
        }
        
        func prevOuter(innerIndex: Int) -> CGPoint
        {
            return outerPoints[innerIndex]
        }
        
        let startPoint = lerp(outerPoints[0], prevInner(outerIndex: 0), softness)
        
        move(to: startPoint)
        
        for index in 0..<points
        {
            let outerPoint = outerPoints[index]
            let o1 = lerp(outerPoint, prevInner(outerIndex: index), softness)
            let o2 = lerp(outerPoint, nextInner(outerIndex: index), softness)
            
            if o1 != currentPoint { addLine(to: o1) }
            addQuadCurve(to: o2, controlPoint: outerPoint)
            
            let innerPoint = innerPoints[index]
            let i1 = lerp(innerPoint, prevOuter(innerIndex: index), softness)
            let i2 = lerp(innerPoint, nextOuter(innerIndex: index), softness)
            
            if i1 != currentPoint { addLine(to: i1) }
            addQuadCurve(to: i2, controlPoint: innerPoint)
        }
        
        close()
        
        /* debug
         for point in outerPoints + innerPoints
         {
         move(to: point)
         addArc(withCenter: point, radius: 5, startAngle: 0, endAngle: .pi * 2, clockwise: true)
         }
         */
        
        apply(CGAffineTransform(rotationAngle: -.pi/2))
        
        if center != .zero { apply(CGAffineTransform(translationX: center.x, y: center.y)) }
    }
}
