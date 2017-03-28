//
//  UIViewController+Transition.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "UIViewController+Transition.h"
#import <objc/runtime.h>

@protocol JYTransitionAnimatorProtocol <NSObject>
@required
- (void)presentedAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)dismissedAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
@end

/**
 *  该类不能直接使用, 需要通过继承该类进行使用, 子类必须实现 JYTransitionAnimatorProtocol 协议
 */
@interface JYTransitionAnimator : NSObject
@property (nonatomic, assign) NSTimeInterval presentedDuration;    // default is 0.3
@property (nonatomic, assign) NSTimeInterval dismissedDuration;    // default is 0.2
+ (instancetype)animator;
@end

@interface JYTransitionAnimator ()
@property (nonatomic, weak) id<JYTransitionAnimatorProtocol> child;
@property (nonatomic, strong) UIView *dimBackgroundView;
@end

@implementation JYTransitionAnimator

#pragma mark - Life cycle

+ (instancetype)animator {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        //        NSAssert([self conformsToProtocol:@protocol(JYTransitionAnimatorProtocol)],
        //                 @"JYTransitionAnimator 的子类必须实现 JYTransitionAnimatorProtocol 协议");
        
        _child = (id<JYTransitionAnimatorProtocol>)self;
        _presentedDuration = 0.3;
        _dismissedDuration = 0.2;
    }
    return self;
}

#pragma mark - Delegate
#pragma mark - UIViewControllerContextTransitioning

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *const fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *const toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([toController presentedViewController] != fromController) {
        return self.presentedDuration;
    } else {
        return self.dismissedDuration;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *const fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *const toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([toController presentedViewController] != fromController) {
        [self.child presentedAnimateTransition:transitionContext];
    } else {
        [self.child dismissedAnimateTransition:transitionContext];
    }
}

- (void)presentedAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *toView = toViewController.view;
    CGRect finalFrame = [transitionContext finalFrameForViewController:fromViewController];
    CGFloat duration = [self transitionDuration:transitionContext];
    
    self.dimBackgroundView.alpha = 0;
    self.dimBackgroundView.frame = finalFrame;
    toView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    toView.alpha = 0;
    
    [containerView addSubview:toView];
    [containerView insertSubview:self.dimBackgroundView belowSubview:toView];
    
    [UIView animateWithDuration:duration * 0.75 animations:^{
        toView.alpha = 1;
        self.dimBackgroundView.alpha = 1;
    }];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)dismissedAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    CGFloat duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        fromView.alpha = 0;
        self.dimBackgroundView.alpha = 0;
    }
                     completion:^(BOOL finished) {
                         [self.dimBackgroundView removeFromSuperview];
                         [fromView removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

#pragma mark - Property (getter, setter)

- (UIView *)dimBackgroundView {
    if (!_dimBackgroundView) {
        _dimBackgroundView = [[UIView alloc] init];
        _dimBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    }
    return _dimBackgroundView;
}

@end

@interface JYTransitioningDelegateController : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) JYTransitionAnimator<UIViewControllerAnimatedTransitioning> *animator;
+ (instancetype)controllerWithAnimator:(JYTransitionAnimator *)animator;

@end

@implementation JYTransitioningDelegateController

+ (instancetype)controllerWithAnimator:(JYTransitionAnimator *)animator {
    JYTransitioningDelegateController *controller = [[[self class] alloc] init];
    controller.animator = (JYTransitionAnimator<UIViewControllerAnimatedTransitioning> *)animator;
    return controller;
}

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.animator;
}

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.animator;
}

@end

static const void *kTransitioningDelegateControllerKey = &kTransitioningDelegateControllerKey;

@interface UIViewController ()
@property (nonatomic, strong, setter=jy_setTransitioningDelegateController:) JYTransitioningDelegateController *jy_transitioningDelegateController;

@end


@implementation UIViewController (Transition)

- (void)jy_showViewController:(UIViewController *)vc completion:(void (^)(void))completion {
    vc.modalPresentationStyle = UIModalPresentationCustom;
    
    vc.jy_transitioningDelegateController = [JYTransitioningDelegateController controllerWithAnimator:[JYTransitionAnimator animator]];
    
    vc.transitioningDelegate = vc.jy_transitioningDelegateController;
    [self presentViewController:vc animated:YES completion:completion];
}

#pragma mark - Property (getter, setter)

- (void)jy_setTransitioningDelegateController:(JYTransitioningDelegateController *)transitioningDelegateController {
    objc_setAssociatedObject(self, kTransitioningDelegateControllerKey, transitioningDelegateController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JYTransitioningDelegateController *)jy_transitioningDelegateController {
    return objc_getAssociatedObject(self, kTransitioningDelegateControllerKey);
}

@end
