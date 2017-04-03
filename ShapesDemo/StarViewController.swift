//
//  ViewController.swift
//  ShapesDemo
//
//  Created by Christian Otkjær on 02/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit
import Shapes

class StarViewController: UIViewController
{
    @IBOutlet weak var starHeight: NSLayoutConstraint!
    
    @IBOutlet weak var star: ShapeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var softnessSlider: UISlider?
    @IBOutlet weak var sizeSlider: UISlider?
    @IBOutlet weak var fillColorSlider: UISlider?
    @IBOutlet weak var pointsSlider: UISlider?
    
    @IBAction func handleSlider(_ slider: UISlider)
    {
        switch slider
        {
        case softnessSlider!:
            star?.softness = CGFloat(slider.value)
            
        case sizeSlider!:
            starHeight.constant = star!.superview!.bounds.width * CGFloat(slider.value)
            star?.superview?.setNeedsLayout()
            star?.superview?.layoutIfNeeded()
            
        case fillColorSlider!:
            star?.fillColor = UIColor(hue: CGFloat(slider.value), saturation: 0.8, brightness: 0.8, alpha: 1)
            
        case pointsSlider!:
            star?.count = Int(slider.value)
            
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
        animateSliderToRandomValue(fillColorSlider)
        animateSliderToRandomValue(sizeSlider)
        animateSliderToRandomValue(softnessSlider)
        animateSliderToRandomValue(pointsSlider)
    }

}

