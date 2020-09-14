//
//  TransitionDriver.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class TransitionDriver: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Public Properties
    
    var direction: TransitionDirection = .present
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panGestureRecognizer?.state == .began
                return gestureIsActive
            }
        }
        set { }
    }
    
    // MARK: - Private Properties
    
    private var isRunning: Bool {
        return percentComplete != 0
    }
    private var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private weak var presentedController: UIViewController?
    
    // MARK: - Public Methods
    
    func link(to controller: UIViewController) {
        presentedController = controller
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panGestureRecognizer!)
    }
        
    // MARK: - Private Methods
    
    @objc private func handle(recognizer r: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognizer: r) // break
        case .dismiss:
            handleDismiss(recognizer: r)
        }
    }
}

// MARK: - Extension TransitionDriver

/// Gesture Handling

private extension TransitionDriver {
    
    func handlePresentation(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
        case .changed:
            let increment = -r.incrementToBottom(maxTranslation: maxTranslation)
            update(percentComplete + increment)
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                cancel()
            } else {
                finish()
            }
        case .failed:
            cancel()
            
        default: break
        }
    }
    
    func handleDismiss(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause() // Pause allows to detect isRunning
            if !isRunning {
                presentedController?.dismiss(animated: true) // Start the new one
            }
        case .changed:
            update(percentComplete + r.incrementToBottom(maxTranslation: maxTranslation))
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }
        case .failed:
            cancel()
            
        default: break
        }
    }
}

