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
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer)
    {
        guard let sView = sender.view as? ShapeView, let shapeView = shapeView else { return }
        
        sView.isUserInteractionEnabled = false
        
        UIView.animate(
            withDuration: 2,
            animations: { shapeView.shapeName = sView.shapeName },
            completion: { _ in sView.isUserInteractionEnabled = true })

    }
    
}
