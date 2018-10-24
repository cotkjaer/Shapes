//
//  TwoSidedShapeView.swift
//  Shapes
//
//  Created by Christian Otkjær on 19/06/2018.
//  Copyright © 2018 Silverback IT. All rights reserved.
//

import UIKit

@IBDesignable
/**
 View representing a two-sided shape. It has two sides and can be flipped between them.
 */
open class TwoSidedShapeView: UIView
{
    private var _frontImage: ShapeView?
    
    @IBInspectable
    open var frontImage: ShapeView?
        {
        get { return _frontImage }
        set
        {
            _frontImage = newValue
            image = newValue
        }
    }
    
    var image: ShapeView?
    
    private var _backImage: ShapeView?
    
    @IBInspectable
    open var backImage: ShapeView?
        {
        get { return _backImage }
        set
        {
            _backImage = newValue
            image = newValue
        }
    }
    
    // MARK: - Flip
    
    @IBInspectable
    open var isFlipped: Bool
        {
        get { return image == backImage }
        set { image = newValue ? backImage : frontImage }
    }
    
    /** flips the card over with no animation
     */
    open func flip()
    {
        isFlipped = !isFlipped
    }
    
    public enum FlipFrom
    {
        case top, left, right, bottom
        
        var animationOption: UIViewAnimationOptions
        {
            switch self {
            case .top: return .transitionFlipFromTop
            case .bottom: return .transitionFlipFromBottom
            case .left: return .transitionFlipFromLeft
            case .right: return .transitionFlipFromRight
            }
        }
    }
    
    /** flips the card over animated
     - parameter duration: tim the flip should take
     */
    open func flip(duration: Double,
                   delay: Double = 0,
                   from: FlipFrom = .bottom,
                   completion: ((Bool)->())? = nil)
    {
        UIView.animate(
            withDuration: duration / 5,
            delay: delay,
            options: [.curveEaseIn],
            animations: { self.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1) },
            completion: { _ in
                
                self.superview?.bringSubview(toFront: self)
                
                UIView.transition(
                    with: self,
                    duration: 3 * duration / 5,
                    options: [.curveLinear, from.animationOption],
                    animations: self.flip,
                    completion: { _ in
                        
                        UIView.animate(
                            withDuration: duration / 5,
                            delay: 0,
                            options: [.curveEaseOut, .beginFromCurrentState],
                            animations: { self.transform = .identity },
                            completion: completion)
                })
        })
    }
}


