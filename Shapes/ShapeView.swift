//
//  ShapeView.swift
//  Shapes
//
//  Created by Christian Otkjær on 02/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
open class ShapeView: UIView
{
    @IBInspectable
    open var shapeName: String
    {
        set { shape = Shape.named(newValue) }
        get { return type(of: shape).name }
    }
    
    private var _shape: Shape = Shape()
    
    open var shape: Shape 
        {
            set { _shape = newValue; updateShape() }
            get { return _shape }
    }
    
    // MARK: - Layer
    
    override open class var layerClass: AnyClass { return AnimatableShapeLayer.self }

    var shapeLayer: AnimatableShapeLayer? { return (layer as? AnimatableShapeLayer) }
    
    /** the color used to fill the shape, if fill-color is nil the shape is filled with black
    - note: this is NOT backgroundColor */
    @IBInspectable
    open var fillColor: UIColor?
        {
        get
        {
            guard let cgColor = shapeLayer?.fillColor else { return nil }
            
            return UIColor(cgColor: cgColor)
        }
        
        set { shapeLayer?.fillColor = newValue?.cgColor }
    }

    
    /** the color used to stroke the outline of the shape. If nil the outline will not be stroked. */
    @IBInspectable
    open var strokeColor: UIColor?
        {
        get
        {
            guard let cgColor = shapeLayer?.strokeColor else { return nil }
            
            return UIColor(cgColor: cgColor)
        }
        
        set { shapeLayer?.strokeColor = newValue?.cgColor }
    }
    
    /** the width of the line used to stroke the outline of the shape. if nil or less-than-or-equal-to 0 the outline will not be stroked */
    @IBInspectable
    open var strokeWidth: CGFloat
        {
        get { return shapeLayer?.lineWidth ?? 0 }
        
        set { shapeLayer?.lineWidth = newValue }
    }
    
    /** inner radius of the shape (where applicable), relative to outer radius, should be in range ]0;1[ */
    
    open var innerRadius: CGFloat? { didSet { if oldValue != innerRadius { updateShape() } } }
    
    /** number of radial repetitions (where applicable); for a star it is the number of points, for a gear the number of cogs, etc. */
    
    open var repetitions: Int? { didSet { if oldValue != repetitions { updateShape() } } }
    
    /** the "softness" of the shape (where applicable), should be in range [0;1], where 0 is not soft at all and 1 is soft as a jellyfish */
    
    open var softness: CGFloat? { didSet { if oldValue != softness { updateShape() } } }
    
    open override var bounds: CGRect
        {
        get
        {
            return super.bounds
        }
        set
        {
            super.bounds = newValue
            updateShape()
        }
    }
    
    //TODO: change to setNeedsShapeUpdate
    open func updateShape()
    {
        let path = shape.createPath(forView: self)
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        shapeLayer?.path = path.cgPath
        
        shapeLayer?.mask = mask
        
        shapeLayer?.fillRule = path.usesEvenOddFillRule ? kCAFillRuleEvenOdd : kCAFillRuleNonZero
    }
    
    
    // MARK: - Flip
    
    private var _isFlipped: Bool = false
    
    @IBInspectable
    open var isFlipped: Bool
        {
        get { return _isFlipped }
        set { _isFlipped = newValue; updateUIForFlippedState(_isFlipped) }
    }
    
    open func flip()
    {
        isFlipped = !isFlipped
    }
    
    /** flips the card over with no animation - parameter is isFlipped AFTER flip
     */
    open var updateUIForFlippedState: (Bool)->() = { _ in }
    
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
     - parameter duration: time the flip should take
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
