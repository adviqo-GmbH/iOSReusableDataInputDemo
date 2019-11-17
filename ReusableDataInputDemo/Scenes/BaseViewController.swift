//
//  BaseViewController.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 21.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput

open class BaseViewController: UIViewController, InputViewCollectionProtocol
{
    // MARK: - Public
    @IBOutlet public var inputViewCollection: [InputView]!
    
    // MARK: - View Lifecycle
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: nil)
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        self.setupViewResizerOnKeyboardShown()
    }
    
    override open func viewDidLayoutSubviews()
    {
        /*
         print("[\(type(of: self)) \(#function)]")
         */
        super.viewDidLayoutSubviews()
        guard self.storedViewFrame == nil else {
            return
        }
        self.storedViewFrame = self.view.frame
        /*
         print("[\(type(of: self)) \(#function)] self.view.frame: \(self.view.frame)")
         */
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Keyboard
    internal var storedViewFrame: CGRect?
    internal var scrollViewContentOffset: CGPoint?
    
    internal func setupViewResizerOnKeyboardShown()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc internal func keyboardWillShow(notification: NSNotification)
    {
        /*
         print("[\(type(of: self)) \(#function)]")
         */
        guard
            let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let windowFrame = self.storedViewFrame,
            self.isVisible
            else
        {
            return
        }
        
        /*
         print("[\(type(of: self)) \(#function)] storedViewFrame: \(windowFrame)")
         */
        
        if let scrollView = self.view.scrollView {
            self.scrollViewContentOffset = scrollView.contentOffset
        }
        
        var navigationBarHeight: CGFloat = 0
        var statusBarHeight: CGFloat = 0
        let shouldUseTopOffset:Bool
        if UIScreen.main.bounds.size.height == windowFrame.size.height {
            shouldUseTopOffset = false
        } else {
            shouldUseTopOffset = true
        }
        if
            let topViewController = UIApplication.topViewController(),
            let navigationController = topViewController.navigationController,
            navigationController.isNavigationBarHidden != nil,
            !navigationController.isNavigationBarHidden,
            shouldUseTopOffset
        {
            navigationBarHeight = navigationController.navigationBar.frame.size.height
            statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        } else {
        }
        let viewFrame = CGRect(
            x: windowFrame.origin.x,
            y: windowFrame.origin.y,
            width: windowFrame.size.width,
            height: windowFrame.origin.y + windowFrame.size.height - keyboardFrame.size.height - navigationBarHeight - statusBarHeight
        )
        /*
         print("[\(type(of: self)) \(#function)] viewFrame: \(viewFrame) keyboardFrame: \(keyboardFrame) navigationBarHeight: \(navigationBarHeight) statusBarHeight: \(statusBarHeight)")
         */
        self.view.frame = viewFrame;
    }
    
    @objc internal func keyboardWillHide(notification: NSNotification)
    {
        if !self.isVisible { return }
        guard let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        UIView.animate(withDuration: duration) {
            if let scrollView = self.view.scrollView, let scrollViewContentOffset = self.scrollViewContentOffset {
                scrollView.contentOffset = scrollViewContentOffset
            }
            if let storedViewFrame = self.storedViewFrame {
                self.view.frame = storedViewFrame
            }
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BaseViewController: UIGestureRecognizerDelegate
{
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
//        print("[\(type(of: self)) \(#function)]")
        // some button touched - do nothing
        if touch.view is UIButton {
            return true
        }
        
        // check if user inputs are on the form
        var userInputViews = [InputViewProtocol]()
        if let inputViewCollection = self.inputViewCollection as [InputViewProtocol]?, inputViewCollection.count > 0 {
            userInputViews += inputViewCollection
        }
        guard userInputViews.count > 0 else {
            // no user input on the form - do nothing
            return true
        }
        
        // check if some user input touched
        let isUserInputTouched = userInputViews.map({$0.isTouched(touch: touch)}).reduce(false) {$0 || $1}
        
        guard !isUserInputTouched else {
            // if user input touched - do nothing
            return true
        }
        
        // dismiss keyboard for user input view
        userInputViews.forEach({$0.resignFirstResponderWith(touch: touch)})
        return true
    }
}
