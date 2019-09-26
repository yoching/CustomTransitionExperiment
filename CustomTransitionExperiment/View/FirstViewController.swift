//
//  FirstViewController.swift
//  CustomTransitionExperiment
//
//  Created by Yoshikuni Kato on 24/09/2019.
//  Copyright © 2019 Yoshikuni Kato. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    let panGestureRecognizer = UIPanGestureRecognizer()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.presentModalView()
    }
    
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            presentModalView()
        }
    }
    
    private func presentModalView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.transitioningDelegate = self
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        panGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
        bottomView.addGestureRecognizer(panGestureRecognizer)
    }

}


extension FirstViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimationController(transitionType: .presentation)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimationController(transitionType: .dismissal)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            let interactionController = PresentationInteractionController(operation: .presentation)
            interactionController.wantsInteractiveStart = panGestureRecognizer.state == .began
            return interactionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            let interactionController = PresentationInteractionController(operation: .dismissal)
            if let secondViewController = self.presentedViewController as? SecondViewController {
                interactionController.wantsInteractiveStart = secondViewController.panGestureRecognizer.state == .began
            } else {
                interactionController.wantsInteractiveStart = false
            }
            return interactionController
    }
}
