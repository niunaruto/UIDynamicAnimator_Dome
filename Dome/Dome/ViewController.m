//
//  ViewController.m
//  Dome
//
//  Created by anlaiye on 16/6/2.
//  Copyright © 2016年 wangmingmin. All rights reserved.
//

#import "ViewController.h"
/**
 *  参考博客:http://vit0.com/blog/2014/03/08/ios-7-uikit-dynamic-xue-xi-zong-jie/
 */
@interface ViewController () <UICollisionBehaviorDelegate>

@property (strong, nonatomic) UIView *squareView;
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.squareView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.squareView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.squareView];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.squareView]];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.squareView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    collision.collisionDelegate = self;
    [self.animator addBehavior:collision];
    
    
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.squareView attachedToAnchor:self.squareView.center];
    attachment.length = 50;
    attachment.damping = 0.5;
    attachment.frequency = 1;
    [self.animator addBehavior:attachment];
    
    
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.squareView]];
    itemBehavior.elasticity = 0.8; // 改变弹性
    itemBehavior.allowsRotation = YES; // 允许旋转
    [itemBehavior addAngularVelocity:1 forItem:self.squareView]; // 让物体旋转
    
    [self.animator addBehavior:itemBehavior];
}

#pragma mark - UICollisionBehaviorDelegate

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(id <NSCopying>)identifier atPoint:(CGPoint)p
{
    // 结束碰撞为 squareView 设置一个随机背景
    self.squareView.backgroundColor = [UIColor colorWithRed:(float)rand() / RAND_MAX
                                                      green:(float)rand() / RAND_MAX
                                                       blue:(float)rand() / RAND_MAX
                                                      alpha:1];
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(id <NSCopying>)identifier
{
    // 结束碰撞为 squareView 设置一个随机背景
    self.squareView.backgroundColor = [UIColor colorWithRed:(float)rand() / RAND_MAX
                                                      green:(float)rand() / RAND_MAX
                                                       blue:(float)rand() / RAND_MAX
                                                      alpha:1];
}

@end
