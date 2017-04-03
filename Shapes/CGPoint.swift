//
//  CGPoint.swift
//  Shapes
//
//  Created by Christian Otkjær on 02/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

// MARK: - <#comment#>

extension CGPoint
{
    init(bearing: CGFloat, distance: CGFloat)
    {
        x = cos(bearing) * distance
        y = sin(bearing) * distance
    }
    
}

func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint
{
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint
{
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint
{
    return CGPoint(x: rhs.x * lhs, y: rhs.y * lhs)
}


func lerp(_ a: CGPoint, _ b: CGPoint, _ t: CGFloat) -> CGPoint
{
    return a * (1 - t) + b * t
}

