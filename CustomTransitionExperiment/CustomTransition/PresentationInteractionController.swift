//
//  PresentationInteractionController.swift
//  CustomTransitionExperiment
//
//  Created by Yoshikuni Kato on 25/09/2019.
//  Copyright © 2019 Yoshikuni Kato. All rights reserved.
//

import UIKit

class PresentationInteractionController: UIPercentDrivenInteractiveTransition {
    private let operation: AnimatedTransitionType
    private var interactiveAreaHeight: CGFloat?

    init(operation: AnimatedTransitionType) {
        self.operation = operation
        super.init()
    }

    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        prepareForInteraction(using: transitionContext)
        super.startInteractiveTransition(transitionContext)
    }

    private func prepareForInteraction(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch operation {
        case .presentation:
            let firstVC = transitionContext.viewController(forKey: .from) as! FirstViewController
            interactiveAreaHeight = firstVC.bottomView.frame.minY
            firstVC.panGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
            
        case .dismissal:
            let secondVC = transitionContext.viewController(forKey: .from) as! SecondViewController
            secondVC.panGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
            let firstVC = transitionContext.viewController(forKey: .to) as! FirstViewController
            interactiveAreaHeight = firstVC.bottomView.frame.minY
        }
    }

    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            pause()
        case .changed:
            update(percentComplete(for: gestureRecognizer))
            gestureRecognizer.setTranslation(.zero, in: nil)
        case .ended, .cancelled:
            if percentComplete > 0.5 {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
    
    private func percentComplete(for gestureRecognizer: UIPanGestureRecognizer) -> CGFloat {
        return percentComplete
            + (operation == .presentation ? -1.0 : 1.0)
            * gestureRecognizer.translation(in: nil).y
            / interactiveAreaHeight!
    }
}
