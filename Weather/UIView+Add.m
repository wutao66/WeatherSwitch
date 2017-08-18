//
//  UIView+Add.m
//  Sendong_Sport
//
//  Created by Apple on 2016/12/3.
//  Copyright © 2016年 Sendong. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)

#pragma mark - setter
- (void)setSd_centerX:(CGFloat)sd_centerX
{
    CGPoint center = self.center;
    center.x = sd_centerX;
    self.center = center;
}
- (void)setSd_centerY:(CGFloat)sd_centerY
{
    CGPoint center = self.center;
    center.y = sd_centerY;
    self.center = center;
}

- (void)setSd_x:(CGFloat)sd_x
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = sd_x;
    self.frame = tempFrame;
}

- (void)setSd_y:(CGFloat)sd_y
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y  = sd_y;
    self.frame = tempFrame;
}

- (void)setSd_width:(CGFloat)sd_width
{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = sd_width;
    self.frame = tempFrame;
}

- (void)setSd_height:(CGFloat)sd_height
{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = sd_height;
    self.frame = tempFrame;
}

- (void)setSd_origin:(CGPoint)sd_origin
{
    CGRect frame = self.frame;
    frame.origin = sd_origin;
    self.frame = frame;
}

- (void)setSd_size:(CGSize)sd_size
{
    CGRect frame = self.frame;
    frame.size = sd_size;
    self.frame = frame;
}


#pragma mark - getter
- (CGFloat)sd_centerX
{
    return self.center.x;
}

- (CGFloat)sd_centerY
{
    return self.center.y;
}

- (CGFloat)sd_x
{
    return self.frame.origin.x;
}

- (CGFloat)sd_y
{
    return self.frame.origin.y;
}

- (CGFloat)sd_width
{
    return self.frame.size.width;
}

- (CGFloat)sd_height
{
    return self.frame.size.height;
}

- (CGPoint)sd_origin
{
    return self.frame.origin;
}

- (CGSize)sd_size
{
    return self.frame.size;
}

- (CGFloat)sd_maxX
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)sd_maxY
{
    return self.frame.origin.y + self.frame.size.height;
}

@end
