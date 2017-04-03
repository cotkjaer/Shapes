//
//  Random.swift
//  Shapes
//
//  Created by Christian Otkjær on 02/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import Foundation

// MARK: - random floating points

func random<T>(_ lower: T = 0, _ upper: T = 1) -> T where T: FloatingPoint, T: ExpressibleByIntegerLiteral
{
    let t = T(Int(arc4random_uniform(10000000))) / 10000000
    
    return lower * (1 - t) + upper * t
}
