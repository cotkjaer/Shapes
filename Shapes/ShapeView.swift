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
    
    var shape: Shape = Shape() { didSet { updateShape() } }
    
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
    @IBInspectable
    open var innerRadius: CGFloat? { didSet { if oldValue != innerRadius { updateShape() } } }
    
    /** number of radial repetitions (where applicable); for a star it is the number of points, for a gear the number of cogs, etc. */
    @IBInspectable
    open var repetitions: Int? { didSet { if oldValue != repetitions { updateShape() } } }
    
    /** the "softness" of the shape (where applicable), should be in range [0;1], where 0 is not soft at all and 1 is soft as a jellyfish */
    @IBInspectable
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

//    open func createPath() -> UIBezierPath
//    {
//        return UIBezierPath()
//    }
    
    //TODO: change to setNeedsShapeUpdate
    open func updateShape()
    {
        let path = shape.createPath(forView: self)
        
        shapeLayer?.path = path.cgPath
        
        shapeLayer?.fillRule = path.usesEvenOddFillRule ? kCAFillRuleEvenOdd : kCAFillRuleNonZero
        
//        setNeedsDisplay()
    }
}
