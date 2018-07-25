//
//  StartController.swift
//  home24
//
//  Created by Beegains on 24/07/18.
//  Copyright © 2018 Beegains. All rights reserved.
//

import UIKit


class StartController: UIViewController {
    //TODO:- Outlets
    @IBOutlet weak var BtnStartOutlet: UIButton!
    //TODO:- Main
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    //TODO:-Actions
    @IBAction func BtnStartAction(_ sender: UIButton)
    {
        
        let SelectionScreenControllerObj = storyboard?.instantiateViewController(withIdentifier: "SelectionScreenController_id") as! SelectionScreenController
        self.navigationController?.pushViewController(SelectionScreenControllerObj, animated: true)
        
    }
    
}
//TODO:-Extension
extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.88
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 100
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
}
