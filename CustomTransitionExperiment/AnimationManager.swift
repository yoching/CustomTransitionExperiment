//
//  AnimationManager.swift
//  CustomTransitionExperiment
//
//  Created by Yoshikuni Kato on 24/09/2019.
//  Copyright © 2019 Yoshikuni Kato. All rights reserved.
//

import UIKit

class AnimationManager: NSObject, UIViewControllerAnimatedTransitioning {

    fileprivate let transitionType: AnimatedTransitioningType
    
    init(transitionType: AnimatedTransitioningType) {
        self.transitionType = transitionType
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        interruptibleAnimator(using: transitionContext).startAnimation()
        
//        let containerView = transitionContext.containerView
//
//        switch transitionType {
//        case .presentation:
//            interruptibleAnimator(using: transitionContext).startAnimation()
//            //            presentationTransition(containerView, transitionContext: transitionContext)
//
//        case .dismissal:
//            dismissalTransition(containerView, transitionContext: transitionContext)
//
//        }
        
    }
    
    private func presentationTransition(_ containerView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: .to),
            let toView = transitionContext.view(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) as? ViewController else {
                return
        }
        
        let initialFrame = CGRect(x: 0.0, y: fromVC.label.frame.minY, width: toView.bounds.width, height: toView.bounds.height)
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        toView.frame = initialFrame
        containerView.addSubview(toView)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toView.frame = finalFrame

//                transitionContext.viewController(forKey: .from)?.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                
        }, completion: { (finished: Bool) in
            if transitionContext.transitionWasCancelled {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
 
    private func dismissalTransition(_ containerView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) as? ViewController,
            let toView = transitionContext.view(forKey: .to) else {
                return
        }
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        let finalFrame = CGRect(x: 0, y: toVC.label.frame.minY, width: fromView.bounds.width, height: fromView.bounds.height)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromView.frame = finalFrame
                //                transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.transform = CGAffineTransform.identity
        }, completion: { (finished: Bool) in
            if !transitionContext.transitionWasCancelled {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    var viewPropertyAnimator: UIViewImplicitlyAnimating?
    
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
        let animator = UIViewPropertyAnimator(duration: 3.0, timingParameters: timingParameters)
        animator.addAnimations {
            toView.frame = finalFrame
        }
        animator.addCompletion { position in
            switch position {
            case .end:
                if transitionContext.transitionWasCancelled {
                    toView.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            case .current, .start:
                return
            @unknown default:
                return
            }
            self.viewPropertyAnimator = nil
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
        let animator = UIViewPropertyAnimator(duration: 3.0, timingParameters: timingParameters)
        animator.addAnimations {
            fromView.frame = finalFrame
        }
        animator.addCompletion { position in
            switch position {
            case .end:
                if !transitionContext.transitionWasCancelled {
                    fromView.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            case .current, .start:
                return
            @unknown default:
                return
            }
            self.viewPropertyAnimator = nil
        }
        
        return animator
    }
}

