//
//  PanelTransition.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - Private Properties
    
    private let transitionDriver = TransitionDriver()
    
    // MARK: - Public Methods
    
    /// Presentation
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        transitionDriver.link(to: presented)
        
        let presentationController = DarkenedPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source
        )
        presentationController.transitionDriver = transitionDriver
        
        return presentationController
    }
    
    /// Animation
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
    /// Interaction
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transitionDriver
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transitionDriver
    }
}
