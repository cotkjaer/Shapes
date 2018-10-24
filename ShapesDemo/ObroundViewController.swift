//
//  ObroundViewController.swift
//  ShapesDemo
//
//  Created by Christian Otkjær on 22/10/2018.
//  Copyright © 2018 Silverback IT. All rights reserved.
//

import UIKit
import Shapes

class ObroundViewController: UIViewController
{

    @IBOutlet weak var shapeView: ShapeView?
    
    @IBOutlet weak var shapeHeight: NSLayoutConstraint?
    @IBOutlet weak var shapeWidth: NSLayoutConstraint?

    
    @IBOutlet weak var widthSlider: UISlider?
    @IBOutlet weak var heightSlider: UISlider?
    @IBOutlet weak var strokeSlider: UISlider?

    @IBOutlet weak var colorSlider: UISlider?
    @IBAction func handleSlider(_ slider: UISlider)
    {
        switch slider
        {
        case strokeSlider!:
            shapeView?.strokeWidth = CGFloat(slider.value * 10)
            
        case widthSlider!:
            guard let sv = shapeView?.superview else { return }
            shapeWidth?.constant = sv.bounds.width * CGFloat(slider.value)
            sv.setNeedsLayout()
            sv.superview?.layoutIfNeeded()

        case heightSlider!:
            guard let sv = shapeView?.superview else { return }
            shapeHeight?.constant = sv.bounds.height * CGFloat(slider.value)
            sv.setNeedsLayout()
            sv.superview?.layoutIfNeeded()

        case colorSlider!:
            shapeView?.fillColor = UIColor(hue: CGFloat(slider.value), saturation: 0.8, brightness: 0.8, alpha: 1)
            
        default:
            break
        }
    }
    
    
    func animateSliderToRandomValue(_ slider: UISlider?)
    {
        guard let slider = slider else { return }
        
        let v = random(slider.minimumValue, slider.maximumValue)
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [.beginFromCurrentState],
            animations: {
                slider.setValue(v, animated: true)
                self.handleSlider(slider)
                
        }, completion: nil)
    }
    
    @IBAction func handleButton(_ sender: UIButton)
    {
        animateSliderToRandomValue(colorSlider)
        animateSliderToRandomValue(strokeSlider)
        animateSliderToRandomValue(widthSlider)
        animateSliderToRandomValue(heightSlider)
    }
}
