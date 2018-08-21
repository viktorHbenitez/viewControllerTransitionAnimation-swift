//
//  PopAnimatior.swift
//  viewControllerTransitionAnimation-swift
//
//  Created by Victor Hugo Benitez Bosques on 20/08/18.
//  Copyright © 2018 Victor . All rights reserved.
//

import UIKit

class PopAnimatior: NSObject, UIViewControllerAnimatedTransitioning {

    
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 1. get the containerView where your animation will take place
        let containerView = transitionContext.containerView
        
        // 2. fetch the newView ans store it in toView
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        // 3. add the view to be presented as a child to the container view and animate it in some way
        containerView.addSubview(toView)
        
        // 4. Create custom animation
        toView.alpha = 0.0
        
        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
        
    }
    
    
    
}
