//
//  FlipViewController.swift
//  ShapesDemo
//
//  Created by Christian Otkjær on 19/06/2018.
//  Copyright © 2018 Silverback IT. All rights reserved.
//

import UIKit
import Shapes

class FlipViewController: UIViewController
{

    @IBOutlet weak var shapeView: ShapeView?
    {
        didSet { shapeView?.updateUIForFlippedState = { (isFlipped) in self.shapeView?.fillColor = isFlipped ? .yellow : .blue }}
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var drop: ShapeView?
    @IBOutlet weak var star: ShapeView?
    
    @IBAction func handleTap(_ tap: UITapGestureRecognizer)
    {
        guard tap.state == .ended else { return }

        flip(firstView: drop, and: star)
        
        freeze()
        shapeView?.flip(duration: 0.5, delay: 0.1, from: ShapeView.FlipFrom.left, completion: unfreeze)
    }
    
    func freeze(doIt: Bool = true)
    {
        view.isUserInteractionEnabled = doIt
    }
    
    func unfreeze(doIt: Bool = true)
    {
        view.isUserInteractionEnabled = doIt
    }
    
    func flip(firstView: UIView?, and secondView: UIView?)
    {
        guard let firstView = firstView, let secondView = secondView else { return }
        
        firstView.backgroundColor = .white
        secondView.backgroundColor = .white
        
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
            firstView.isHidden = !firstView.isHidden
        })
        
        UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
            secondView.isHidden = !secondView.isHidden
        })
    }
}
