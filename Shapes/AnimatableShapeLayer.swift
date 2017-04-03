//
//  AnimatableShapeLayer.swift
//  Shapes
//
//  Created by Christian Otkjær on 02/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit

open class AnimatableShapeLayer: CAShapeLayer
{
    var animatableKeys = ["path", "fillColor", "strokeColor", "lineWidth"]
    
    override open func action(forKey key: String) -> CAAction?
    {
        guard animatableKeys.contains(key),
            let action = action(forKey: "backgroundColor") as? CABasicAnimation
            else
        {
            return super.action(forKey: key)
        }
        
        action.keyPath = key
        action.fromValue = presentation()?.value(forKeyPath: key) ?? value(forKeyPath: key)
        action.toValue = nil
        
        return action
    }
}
