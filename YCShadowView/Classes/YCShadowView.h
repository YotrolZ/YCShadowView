//
//  YCShadowView.h
//  YCShadowView
//
//  Created by Sunshine on 2019/1/29.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, YCShadowSide) {
    YCShadowSideTop       = 1 << 0,
    YCShadowSideBottom    = 1 << 1,
    YCShadowSideLeft      = 1 << 2,
    YCShadowSideRight     = 1 << 3,
    YCShadowSideAllSides  = ~0UL
};

@interface YCShadowView : UIView

/**
 * 设置四周阴影: shaodwRadius:5  shadowColor:[UIColor colorWithWhite:0 alpha:0.3]
 */
- (void)yc_shaodw;
/**
 * 设置垂直方向的阴影
 *
 * @param shadowRadius   阴影半径
 * @param shadowColor    阴影颜色
 * @param shadowOffset   阴影b偏移
 */
- (void)yc_verticalShaodwRadius:(CGFloat)shadowRadius
                    shadowColor:(UIColor *)shadowColor
                   shadowOffset:(CGSize)shadowOffset;
/**
 * 设置水平方向的阴影
 *
 * @param shadowRadius   阴影半径
 * @param shadowColor    阴影颜色
 * @param shadowOffset   阴影b偏移
 */
- (void)yc_horizontalShaodwRadius:(CGFloat)shadowRadius
                      shadowColor:(UIColor *)shadowColor
                     shadowOffset:(CGSize)shadowOffset;
/**
 * 设置阴影
 *
 * @param shadowRadius   阴影半径
 * @param shadowColor    阴影颜色
 * @param shadowOffset   阴影b偏移
 * @param shadowSide     阴影边
 */
- (void)yc_shaodwRadius:(CGFloat)shadowRadius
            shadowColor:(UIColor *)shadowColor
           shadowOffset:(CGSize)shadowOffset
           byShadowSide:(YCShadowSide)shadowSide;

/**
 * 设置圆角（四周）
 *
 * @param cornerRadius   圆角半径
 */
- (void)yc_cornerRadius:(CGFloat)cornerRadius;
/**
 * 设置圆角
 *
 * @param cornerRadius   圆角半径
 * @param corners        圆角边
 */
- (void)yc_cornerRadius:(CGFloat)cornerRadius
      byRoundingCorners:(UIRectCorner)corners;

@end
