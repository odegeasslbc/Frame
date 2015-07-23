//
//  NaviControllerDelegate.swift
//  Frame
//
//  Created by 刘炳辰 on 15/7/23.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//
import UIKit
import Foundation

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate{
    @IBOutlet weak var navigationController: UINavigationController?
    var interactionController: UIPercentDrivenInteractiveTransition?

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleTransitionAnimator()
    }
    
    /*
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionController
    }
    */
    func swipLeft(sender:UISwipeGestureRecognizer){
        /* used to animat between vc in navi controllor
        if(self.navigationController?.viewControllers.count <= 1){
            self.navigationController?.topViewController.performSegueWithIdentifier("PushRight", sender: nil)
        }
        else{
            self.navigationController?.popViewControllerAnimated(true)
        }
        */
        drawerVc.toggleDrawerWithSide(JVFloatingDrawerSide.Right, animated: true, completion: nil)

    }
    
    func swipRight(){
        drawerVc.toggleDrawerWithSide(JVFloatingDrawerSide.Left, animated: true, completion: nil)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
        var pan = UIPanGestureRecognizer(target: self, action: "panned:")
        */
        var swipLeft = UISwipeGestureRecognizer(target: self, action: "swipLeft:")
        swipLeft.direction = UISwipeGestureRecognizerDirection.Left
        
        var swipRight = UISwipeGestureRecognizer(target: self, action: "swipRight")
        swipRight.direction = UISwipeGestureRecognizerDirection.Right
        
        self.navigationController!.view.addGestureRecognizer(swipLeft)
        self.navigationController!.view.addGestureRecognizer(swipRight)
        
    }
}


class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 1
        self.transitionContext = transitionContext

        
        if var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? RedViewController{
            if var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? BlueViewController{
                var button = fromViewController.btnLeft
                makeAnim(fromViewController, toViewController: toViewController, button: button)
            }else
            if var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? YellowViewController{
                var button = fromViewController.btnRight
                makeAnim(fromViewController, toViewController: toViewController, button: button)
            }
        }
        else if var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? BlueViewController{
            if var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? RedViewController{
                var button = fromViewController.btnLeft
                makeAnim(fromViewController, toViewController: toViewController, button: button)
            }else
            if var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? YellowViewController{
                var button = fromViewController.btnRight
                makeAnim(fromViewController, toViewController: toViewController, button: button)
            }
        }
        else if var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? YellowViewController{
            if var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? BlueViewController{
                var button = fromViewController.btnLeft
                makeAnim(fromViewController, toViewController: toViewController, button: button)
            }else
                if var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? RedViewController{
                    var button = fromViewController.btnRight
                    makeAnim(fromViewController, toViewController: toViewController, button: button)
            }
        }
    
    }
    
    func makeAnim(fromViewController: UIViewController, toViewController: UIViewController, button: UIButton){
        
        // 2
        var containerView = transitionContext!.containerView()
        // 3
        containerView.addSubview(toViewController.view)
        
        // 4
        var circleMaskPathInitial = UIBezierPath(ovalInRect: button.frame)
        var extremePoint = CGPointMake(button.center.x, button.center.y - CGRectGetHeight(toViewController.view.bounds)) // need more research
        //var radius = sqrt(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y)
        var radius:CGFloat = 1000
        var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
        // 5
        var maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toViewController.view.layer.mask = maskLayer
        
        // 6
        var maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(self.transitionContext!)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "CircleAnimation")

    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
    
    
}