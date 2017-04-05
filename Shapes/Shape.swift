//
//  Shape.swift
//  Shapes
//
//  Created by Christian Otkjær on 03/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit


//TODO: refactor to enum?
open class Shape
{
    // MARK: - Factory
    
    open static func named(_ name: String) -> Shape
    {
        let shape: Shape
        
        switch name.lowercased()
        {
        case Star.name:
            shape = Star()
            
        case Disc.name:
            shape = Disc()
            
        case Ring.name:
            shape = Ring()
            
        case Drop.name:
            shape = Drop()
            
        case Gear.name:
            shape = Gear()
            
        case Heart.name:
            shape = Heart()
            
        case Polygon.name:
            shape = Polygon()
            
        default:
            shape = Shape()
        }
        
        return shape
    }

    // MARK: - Name
    
    public class var name: String { return "shape" }
    
    // MARK: - Path
    
    internal func outerRadius(for view: ShapeView) -> CGFloat
    {
        let outerRadius = min(view.bounds.width, view.bounds.height)

        return max(0, outerRadius - view.strokeWidth) / 2
    }
    
    internal func innerRadius(for view: ShapeView, standard: CGFloat) -> CGFloat
    {
        let innerRadius = min(1, max(0, view.innerRadius ?? standard))
        
        return innerRadius
    }
    
    open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        return UIBezierPath()
    }
}

open class Star: Shape
{
    // MARK: - Name
    
    override public class var name: String { return "star" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = self.outerRadius(for: view)
        
        let innerRadius = self.innerRadius(for: view, standard: 0.4)
        
        let points = view.repetitions ?? 5
        
        let softness = view.softness ?? 0.25
        
        let star = UIBezierPath(
            starWithCenter: view.bounds.center,
            innerRadius: innerRadius * outerRadius,
            outerRadius: outerRadius,
            points: points,
            softness: softness)
        
        return star
    }
}

open class Disc: Shape
{
    // MARK: - Name
    
    override public class var name: String { return "disc" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = self.outerRadius(for: view)
        
        let disc = UIBezierPath(arcCenter: view.bounds.center,
                                radius: outerRadius,
                                startAngle: 0,
                                endAngle: π2,
                                clockwise: true)
        
        disc.close()
        
        return disc
    }
}

open class Ring: Shape
{
    // MARK: - Name
    
    override public class var name: String { return "ring" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = self.outerRadius(for: view)

        let innerRadius = self.innerRadius(for: view, standard: 0.75)

        return UIBezierPath(
            ringWithCenter: view.bounds.center,
            innerRadius: outerRadius * innerRadius,
            outerRadius: outerRadius)
    }
}

open class Drop: Shape
{
    // MARK: - Name
    
    override public class var name: String { return "drop" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = self.outerRadius(for: view)

        return UIBezierPath(dropWithCenter: view.bounds.center, radius: outerRadius)
    }
}

open class Heart: Shape
{
    // MARK: - Name
    
    override public class var name: String { return "heart" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = self.outerRadius(for: view)
        

        return UIBezierPath(heartAt: view.bounds.center, radius: outerRadius)
    }
}

open class Gear: Shape
{
    override public class var name: String { return "gear" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = self.outerRadius(for: view)
        
        let innerRadius = self.innerRadius(for: view, standard: 0.7)
        
        let cogs = view.repetitions ?? 7

        return UIBezierPath(gearWithCenter: view.bounds.center,
                            innerRadius: innerRadius * outerRadius,
                            outerRadius: outerRadius,
                            cogs: cogs)
    }
}

open class Polygon: Shape
{
    override public class var name: String { return "polygon" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = self.outerRadius(for: view)
        
        let sides = view.repetitions ?? 5

        return UIBezierPath(convexRegularPolygonWithCenter: view.bounds.center,
                            sides: sides,
                            radius: outerRadius,
                            turned: true)
    }
}

