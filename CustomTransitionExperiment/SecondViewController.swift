//
//  SecondViewController.swift
//  CustomTransitionExperiment
//
//  Created by Yoshikuni Kato on 24/09/2019.
//  Copyright © 2019 Yoshikuni Kato. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let button = UIButton()
//        button.setTitle("Close", for: .normal)
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button)
//
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//
//        button.addTarget(self, action: #selector(SecondViewController.buttonTapped(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//extension ViewController: PresentationAnimatedTransitioning {
//    func transitionAnimator(operation: PresentationOperation, duration: TimeInterval) -> UIViewPropertyAnimator {
//        
//        let initialFrame = CGRect(
//            x: 0.0,
//            y: fromVC.label.frame.minY,
//            width: toView.bounds.width,
//            height: toView.bounds.height
//        )
//        let finalFrame = transitionContext.finalFrame(for: toVC)
//        
//        toView.frame = initialFrame
//        containerView.addSubview(toView)
//        
//        let timingParameters = UICubicTimingParameters(animationCurve: .easeInOut)
//        let animator = UIViewPropertyAnimator(duration: 3.0, timingParameters: timingParameters)
//        animator.addAnimations {
//            toView.frame = finalFrame
//        }
//        animator.addCompletion { position in
//            switch position {
//            case .end:
//                if transitionContext.transitionWasCancelled {
//                    toView.removeFromSuperview()
//                }
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//            case .current, .start:
//                return
//            @unknown default:
//                return
//            }
//            self.viewPropertyAnimator = nil
//        }
//    }
//}
