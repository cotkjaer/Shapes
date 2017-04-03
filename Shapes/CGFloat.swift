//
//  CGFloat.swift
//  Shapes
//
//  Created by Christian Otkjær on 03/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit

let π = CGFloat.pi
let π2 = CGFloat.pi * 2
let π_2 = CGFloat.pi / 2

func lerp(_ a: CGFloat, _ b: CGFloat, _ t: CGFloat) -> CGFloat
{
    return a * (1 - t) + b * t
}

func + (lhs: CGFloat, rhs: Int) -> CGFloat
{
    return lhs + CGFloat(rhs)
}

func + (lhs: Int, rhs: CGFloat) -> CGFloat
{
    return CGFloat(lhs) + rhs
}

func * (lhs: CGFloat, rhs: Int) -> CGFloat
{
    return lhs * CGFloat(rhs)
}

func * (lhs: Int, rhs: CGFloat) -> CGFloat
{
    return CGFloat(lhs) * rhs
}

func / (lhs: CGFloat, rhs: Int) -> CGFloat
{
    return lhs / CGFloat(rhs)
}

func / (lhs: Int, rhs: CGFloat) -> CGFloat
{
    return CGFloat(lhs) / rhs
}

