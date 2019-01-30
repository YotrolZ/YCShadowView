//
//  YCShadowView.m
//  YCShadowView
//
//  Created by Sunshine on 2019/1/29.
//  Copyright © 2019 com. All rights reserved.
//

#import "YCShadowView.h"

@interface YCShadowView()

@property(nonatomic, strong) UIColor *shadowColor;
@property(nonatomic, assign) CGSize  shadowOffset;
@property(nonatomic, assign) CGFloat shadowRadius;
@property(nonatomic, assign) CGFloat cornerRadius;

@property(nonatomic, strong)UIView *backContentView;

@property(nonatomic, strong)CALayer *topShadowLayer;
@property(nonatomic, strong)CALayer *botShadowLayer;
@property(nonatomic, strong)CALayer *leftShadowLayer;
@property(nonatomic, strong)CALayer *rightShadowLayer;

@end

@implementation YCShadowView
#pragma mark - init 初始化自身
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
#pragma mark - Life Cycle 生命周期的方法

#pragma mark - override 重载父类的方法
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.backContentView.backgroundColor = backgroundColor;
}

- (void)addSubview:(UIView *)view {
    if (view == _backContentView) {
        [super addSubview:view];
    } else {
        [self.backContentView addSubview:view];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backContentView.frame = self.bounds;
}

#pragma mark - setupXxx Methods 初始化的方法
- (void)setup {
    [self addSubview:self.backContentView];
}

#pragma mark - public method 共有方法
- (void)yc_shaodw {
    [self yc_shaodwRadius:5 shadowColor:[UIColor colorWithWhite:0 alpha:0.3] shadowOffset:CGSizeMake(0, 0) byShadowSide:YCShadowSideAllSides];
}
- (void)yc_verticalShaodwRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset {
    [self yc_shaodwRadius:shadowRadius shadowColor:shadowColor shadowOffset:shadowOffset byShadowSide:(YCShadowSideTop|YCShadowSideBottom)];
}

- (void)yc_horizontalShaodwRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset {
    [self yc_shaodwRadius:shadowRadius shadowColor:shadowColor shadowOffset:shadowOffset byShadowSide:(YCShadowSideLeft|YCShadowSideRight)];
}
- (void)yc_shaodwRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset byShadowSide:(YCShadowSide)shadowSide {
    
    _shadowRadius = shadowRadius;
    _shadowColor  = shadowColor;
    _shadowOffset = shadowOffset;
    
    if (shadowRadius <= 0) {
        return;
    }
    
    if (shadowSide & YCShadowSideTop) {
        [self _setShadowWith:YCShadowSideTop];
    }
    
    if (shadowSide & YCShadowSideBottom) {
        [self _setShadowWith:YCShadowSideBottom];
    }
    
    if (shadowSide & YCShadowSideLeft) {
        [self _setShadowWith:YCShadowSideLeft];
    }
    
    if (shadowSide & YCShadowSideRight) {
        [self _setShadowWith:YCShadowSideRight];
    }
}

- (void)yc_cornerRadius:(CGFloat)cornerRadius {
    [self yc_cornerRadius:cornerRadius byRoundingCorners:UIRectCornerAllCorners];
}
- (void)yc_cornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners {
    _cornerRadius = cornerRadius;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.backContentView.layer.mask = maskLayer;
}

#pragma mark - Setter/Getter Methods set/get方法
- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = [UIColor whiteColor];
        _backContentView.layer.masksToBounds = YES;
        _backContentView.clipsToBounds = YES;
    }
    return _backContentView;
}

- (CALayer *)topShadowLayer {
    if (!_topShadowLayer) {
        _topShadowLayer = [[CALayer alloc] init];
    }
    return _topShadowLayer;
}
- (CALayer *)botShadowLayer {
    if (!_botShadowLayer) {
        _botShadowLayer = [[CALayer alloc] init];
    }
    return _botShadowLayer;
}
- (CALayer *)leftShadowLayer {
    if (!_leftShadowLayer) {
        _leftShadowLayer = [[CALayer alloc] init];
    }
    return _leftShadowLayer;
}
- (CALayer *)rightShadowLayer {
    if (!_rightShadowLayer) {
        _rightShadowLayer = [[CALayer alloc] init];
    }
    return _rightShadowLayer;
}

#pragma mark - private method 私有方法
- (void)_setShadowWith:(YCShadowSide)shadowSide {
    
    CALayer *shadowLayer = nil;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if (shadowSide & YCShadowSideTop) {
        shadowLayer = self.topShadowLayer;
        shadowLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.5);
        [path moveToPoint:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5)];
        [path addLineToPoint:(CGPointMake(0, 0))];
        [path addLineToPoint:(CGPointMake(self.bounds.size.width, 0))];
    } else if (shadowSide & YCShadowSideLeft) {
        shadowLayer = self.leftShadowLayer;
        shadowLayer.frame = CGRectMake(0, 0, self.frame.size.height*0.5, self.frame.size.height);
        [path moveToPoint:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5)];
        [path addLineToPoint:(CGPointMake(0, 0))];
        [path addLineToPoint:(CGPointMake(0, self.bounds.size.height))];
    } else if (shadowSide & YCShadowSideRight) {
        shadowLayer = self.rightShadowLayer;
        shadowLayer.frame = CGRectMake(self.frame.size.width*0.5, 0, self.frame.size.width*0.5, self.frame.size.height);
        [path moveToPoint:CGPointMake(0, self.bounds.size.height*0.5)];
        [path addLineToPoint:(CGPointMake(self.frame.size.width*0.5, 0))];
        [path addLineToPoint:(CGPointMake(self.frame.size.width*0.5, self.bounds.size.height))];
    } else if (shadowSide & YCShadowSideBottom) {
        shadowLayer = self.botShadowLayer;
        shadowLayer.frame = CGRectMake(0, self.frame.size.height*0.5, self.frame.size.width, self.frame.size.height*0.5);
        [path moveToPoint:CGPointMake(self.bounds.size.width*0.5, 0)];
        [path addLineToPoint:(CGPointMake(0, self.bounds.size.height*0.5))];
        [path addLineToPoint:(CGPointMake(self.bounds.size.width, self.bounds.size.height*0.5))];
    }
    
    [self.layer insertSublayer:shadowLayer atIndex:0];
    
    shadowLayer.masksToBounds = NO;
    
    CGFloat components[4];
    [self _getRGBAComponents:components forColor:_shadowColor];
    
    shadowLayer.shadowColor   = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:1.0].CGColor;
    shadowLayer.shadowOpacity = components[3];
    shadowLayer.shadowRadius  = _shadowRadius;
    shadowLayer.shadowOffset  = CGSizeMake(0, 0);
    shadowLayer.shadowPath    = path.CGPath;
}

- (void)_getRGBAComponents:(CGFloat [4])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4] = {0};
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 kCGImageAlphaPremultipliedLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    CGFloat a = resultingPixel[3] / 255.0;
    CGFloat unpremultiply = (a != 0.0) ? 1.0 / a / 255.0 : 0.0;
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] * unpremultiply;
    }
    components[3] = a;
}

@end
