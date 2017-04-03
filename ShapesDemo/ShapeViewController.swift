//
//  ShapeViewController.swift
//  Shapes
//
//  Created by Christian Otkjær on 03/04/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit
import Shapes

class ShapeViewController: UIViewController
{
    @IBOutlet weak var shapeView: ShapeView?
    
    @IBOutlet weak var control: UISegmentedControl?
    
    @IBAction func handleControl(_ sender: UISegmentedControl)
    {
        guard let name = sender.titleForSegment(at: sender.selectedSegmentIndex), let shapeView = shapeView else { return }
        
        sender.isUserInteractionEnabled = false
        
        UIView.animate(
            withDuration: 2,
            animations: { shapeView.shapeName = name },
            completion: { _ in sender.isUserInteractionEnabled = true })
    }
}
