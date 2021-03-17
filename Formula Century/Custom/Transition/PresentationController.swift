//
//  PresentationController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

// https://habr.com/en/company/dododev/blog/465073/

import UIKit

class PresentationController: UIPresentationController {
    
    // MARK: - Public Properties
    
    var transitionDriver: TransitionDriver!
    override var shouldPresentInFullscreen: Bool {
        return false
    }
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let halfHeight = bounds.height / 2
        
        return CGRect(x: 0, y: halfHeight, width: bounds.width, height: halfHeight)
    }
    
    // MARK: - Public Methods
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        containerView?.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if completed {
            transitionDriver.direction = .dismiss
        }
    }
}
