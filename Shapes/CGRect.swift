//
//  CGRect.swift
//  Shapes
//
//  Created by Christian Otkjær on 03/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit

// MARK: - <#comment#>

extension CGRect
{
    var center: CGPoint
        {
        set { origin = CGPoint(x: newValue.x - width/2, y: newValue.y - height/2) }
        get { return CGPoint(x: midX, y: midY) }
    }
}


