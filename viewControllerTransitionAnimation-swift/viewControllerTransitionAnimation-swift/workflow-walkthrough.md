#  Implementing transition delegates


## steps

1. Create an object animator with `UIViewControllerAnimatedTransitioning` , the delegate task of transition delegate is to manage this one  
2. We are the delegate of the new viewController instance `herbDetails.transitioningDelegate = self`
3. Implementing the delegate method of `UIViewControllerTransitioningDelegate`
4. Create the object of the animator and return in the `func animationController(forPresented presented.. )` method
5. **Setting your transition context in animator Class** `PopAnimator.swift`

![imagen](../feature-implementingTransitionDelegate/assets/sketch2.gif)



