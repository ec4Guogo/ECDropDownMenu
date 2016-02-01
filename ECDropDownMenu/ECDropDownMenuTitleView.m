//
//  ECDropDownMenuTitleView.m
//  ECDropDownMenuDemo
//
//  https://github.com/ericwang24/ECDropDownMenu
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ECDropDownMenuTitleView.h"
#import <QuartzCore/QuartzCore.h>

@interface ECDropDownMenuTitleView ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *arrowImageView;
@property (copy, nonatomic) TapDropDownMenuTitleViewBlock tapDropDownMenuTitleViewBlock;

@end


@implementation ECDropDownMenuTitleView

- (instancetype)init{
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.arrowImageView];

        [self setupLayoutForViews];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:gesture];
        
    }
    return self;
}

#pragma mark - Getter

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _arrowImageView.image = [self drawArrowImageWithWidth:10 height:10];
        _arrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _arrowImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}

#pragma mark - Actions

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture{
    tapGesture.enabled = NO;
    if (self.tapDropDownMenuTitleViewBlock) {
        self.tapDropDownMenuTitleViewBlock(self);
    }
    [UIView animateWithDuration:0.36 animations:^{
        
        _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, - M_PI);
    }completion:^(BOOL finished) {
        if (finished) {
            tapGesture.enabled = YES;
        }
    }];
}



#pragma mark - UtilityMethod

- (void)setupLayoutForViews{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:-10]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowImageView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_titleLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowImageView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:10]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowImageView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:10]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowImageView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.titleLabel
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowImageView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRightMargin
                                                    multiplier:1
                                                      constant:-5]];
}

- (UIImage *)drawArrowImageWithWidth:(CGFloat)width height:(CGFloat)height{
    width = width * 3;
    height = height * 3;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint sPoints[3];
    sPoints[0] =CGPointMake(0, 0);
    sPoints[1] =CGPointMake(width, 0);
    sPoints[2] =CGPointMake(width / 2, height);
    CGContextAddLines(context, sPoints, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ){
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f / disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ){
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}

@end
