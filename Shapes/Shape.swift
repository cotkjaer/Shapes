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
        let outerRadius = min(view.bounds.width, view.bounds.height) / 2
        
        let star = UIBezierPath(starWithCenter: view.bounds.center,
                                innerRadius: min(1, max(0, view.innerRadius)) * outerRadius,
                                outerRadius: outerRadius,
                                points: view.count,
                                softness: view.softness)
        
        return star
    }
}

open class Disc: Shape
{
    // MARK: - Name
    
    override public class var name: String { return "disc" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = min(view.bounds.width, view.bounds.height) / 2
        
        let disc = UIBezierPath(arcCenter: view.bounds.center,
                                radius: outerRadius,
                                startAngle: 0,
                                endAngle: .pi * 2,
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
        let outerRadius = min(view.bounds.width, view.bounds.height) / 2

        let innerRadius = outerRadius * view.innerRadius

        let ring = UIBezierPath(arcCenter: view.bounds.center,
                                radius: outerRadius,
                                startAngle: 0,
                                endAngle: .pi * 2,
                                clockwise: true)
        
//        ring.close()
        
        
        ring.move(to: view.bounds.center + CGPoint(x: innerRadius, y: 0))
        
        ring.addArc(withCenter: view.bounds.center,
                    radius: innerRadius,
                    startAngle: 0,
                    endAngle: .pi * 2,
                    clockwise: true)
        
//        ring.close()
        
        ring.usesEvenOddFillRule = true
        return ring
    }
}

open class Drop: Shape
{
    // MARK: - Name
    
    override public class var name: String { return "drop" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = min(view.bounds.width, view.bounds.height) / 2

        return UIBezierPath(dropWithCenter: view.bounds.center, radius: outerRadius)
    }
}

open class Heart: Shape
{
    // MARK: - Name
    
    override public class var name: String { return "heart" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = min(view.bounds.width, view.bounds.height) / 2
        
        return UIBezierPath(heartAt: view.bounds.center, radius: outerRadius)
    }
}

open class Gear: Shape
{
    override public class var name: String { return "gear" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = min(view.bounds.width, view.bounds.height) / 2
        
        return UIBezierPath(gearWithCenter: view.bounds.center,
                            innerRadius: view.innerRadius * outerRadius,
                            outerRadius: outerRadius,
                            cogs: view.count)
    }
}

open class Polygon: Shape
{
    override public class var name: String { return "polygon" }
    
    override open func createPath(forView view: ShapeView) -> UIBezierPath
    {
        let outerRadius = min(view.bounds.width, view.bounds.height) / 2
        
        return UIBezierPath(convexRegularPolygonWithNumberOfSides: view.count,
                            center: view.bounds.center,
                            radius: outerRadius,
                            turned: true)
    }
}

