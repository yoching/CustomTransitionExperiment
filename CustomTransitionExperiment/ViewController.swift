//
//  ViewController.swift
//  CustomTransitionExperiment
//
//  Created by Yoshikuni Kato on 24/09/2019.
//  Copyright © 2019 Yoshikuni Kato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBAction func buttonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.transitioningDelegate = self
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}


extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationManager(transitionType: .presentation)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationManager(transitionType: .dismissal)
    }
}
