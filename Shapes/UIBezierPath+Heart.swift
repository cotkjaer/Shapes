//
//  UIBezierPath+Heart.swift
//  Shapes
//
//  Created by Christian Otkjær on 27/07/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

private func heartX(_ t: CGFloat) -> CGFloat { return 16 * pow(sin(t), 3) }

private func heartY(_ t: CGFloat) -> CGFloat
{
    let a = 13 * cos(t)
    let b = -5 * cos(2 * t)
    let c = -2 * cos(3 * t)
    let d = -cos(4 * t)
    
    return a + b + c + d
}

// MARK: - Heart

extension UIBezierPath
{
//    public convenience init(heartInRect rect: CGRect)
//    {
//        self.init()
//        
//        let radius = max(10, min(rect.width, rect.height) / 2)
//        
//        let factor = radius / 16
//        
//        func heart(_ t: CGFloat) -> CGPoint { return CGPoint(x: heartX(t), y: heartY(t)) * factor }
//        
//        move(to: heart(0))
//        
//        let step = min(0.1, 10/radius)
//        
//        for t in stride(from: step, to: π2, by: step)
//        {
//            addLine(to: heart(t))
//        }
//        
//        close()
//        
//        transform(toFit: rect)
//    }
    
    public convenience init(heartAt center: CGPoint, radius: CGFloat)
    {
        self.init()
        
        let r = radius //2*radius/3
        
        let topPoint = CGPoint(x: 0, y: 1.5 * r)
        
        let topCtrlPoint = CGPoint(x: 0, y: 0.75 * r)
        
        let leftCtrlPoint = CGPoint(x: -r, y: r * 0.5)
        let rightCtrlPoint = CGPoint(x: r, y: r * 0.5)
        
        move(to: topPoint)
        
        addCurve(to: CGPoint(x: -r, y: 0), controlPoint1: topCtrlPoint, controlPoint2: leftCtrlPoint)
        
        addArc(withCenter: CGPoint(x: -r/2, y: 0),
               radius: r/2,
               startAngle: π,
               endAngle: 0,
               clockwise: true)

        addArc(withCenter: CGPoint(x: r/2, y: 0),
               radius: r/2,
               startAngle: π,
               endAngle: 0,
               clockwise: true)
        
        addCurve(to: topPoint, controlPoint1: rightCtrlPoint, controlPoint2: topCtrlPoint)
        
        close()
        
        apply(CGAffineTransform(translationX: center.x, y: center.y - r / 2))
    }
    
    public convenience init(heartCenteredAt center: CGPoint, radius: CGFloat)
    {
        self.init()
        
        let factor = radius / 16
        
        func heart(_ t: CGFloat) -> CGPoint { return CGPoint(x: heartX(t), y: heartY(t)) * factor }
        
        move(to: heart(0))

        let step = min(0.1, 10/radius)
        
        for t in stride(from: step, to: π2, by: step)
        {
            addLine(to: heart(t))
        }
        
        close()
        
        apply(CGAffineTransform(translationX: center.x, y: center.y))
    }
}
