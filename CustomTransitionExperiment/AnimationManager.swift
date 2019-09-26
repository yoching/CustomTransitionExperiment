//
//  AnimationManager.swift
//  CustomTransitionExperiment
//
//  Created by Yoshikuni Kato on 24/09/2019.
//  Copyright © 2019 Yoshikuni Kato. All rights reserved.
//

import UIKit

class AnimationManager: NSObject, UIViewControllerAnimatedTransitioning {

    var viewPropertyAnimator: UIViewImplicitlyAnimating?
    private let transitionType: AnimatedTransitioningType
    
    init(transitionType: AnimatedTransitioningType) {
        self.transitionType = transitionType
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        interruptibleAnimator(using: transitionContext).startAnimation()
     }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        
        if let animator = viewPropertyAnimator {
            return animator
        }
        
        let animator: UIViewImplicitlyAnimating
        switch transitionType {
        case .presentation:
            animator = animatorWhenPresenting(using: transitionContext)
        case .dismissal:
            animator = animatorWhenDismissing(using: transitionContext)
        }
        
        self.viewPropertyAnimator = animator
        
        return animator
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.viewPropertyAnimator = nil
    }
    
    private func animatorWhenPresenting(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let containerView = transitionContext.containerView
        
        guard let toVC = transitionContext.viewController(forKey: .to),
            let toView = transitionContext.view(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) as? ViewController else {
                fatalError()
        }
        
        let initialFrame = CGRect(x: 0.0, y: fromVC.label.frame.minY, width: toView.bounds.width, height: toView.bounds.height)
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        toView.frame = initialFrame
        containerView.addSubview(toView)
        
        let timingParameters = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(
            duration: transitionDuration(using: transitionContext),
            timingParameters: timingParameters
        )
        animator.addAnimations {
            toView.frame = finalFrame
        }
        animator.addCompletion { position in
            transitionContext.completeTransition(position == .end)
        }
        
        return animator
    }
    
    private func animatorWhenDismissing(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let containerView = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) as? ViewController,
            let toView = transitionContext.view(forKey: .to) else {
                fatalError()
        }
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        
        let finalFrame = CGRect(x: 0, y: toVC.label.frame.minY, width: fromView.bounds.width, height: fromView.bounds.height)
        
        let timingParameters = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(
            duration: transitionDuration(using: transitionContext),
            timingParameters: timingParameters
        )
        animator.addAnimations {
            fromView.frame = finalFrame
        }
        animator.addCompletion { position in
            transitionContext.completeTransition(position == .end)
        }
        
        return animator
    }
}

