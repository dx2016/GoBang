//
//  LineView.m
//  GoBang
//
//  Created by Dxue on 16/5/23.
//  Copyright © 2016年 Dxue. All rights reserved.
//

#import "LineView.h"
#import "Header.h"

@implementation LineView

- (void)drawRect:(CGRect)rect{
    self.multipleTouchEnabled = YES;

    NSInteger indexW = SCREEN_WIDTH / QPWH;
    NSInteger indexH = SCREEN_HEIGHT / QPWH;
    
    [[UIColor colorWithRed:0.40f green:0.20f blue:0.01f alpha:1.00f] set];

    
    for (NSInteger i = 1; i < indexW ; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        path.lineWidth = 1.8;
        [path moveToPoint:CGPointMake( i * QPWH , QPWH - 0.8)];
        [path addLineToPoint:CGPointMake(i * QPWH , SCREEN_HEIGHT - 64 - QPWH + 0.8)];
        
//        [[UIColor blackColor] set];
        
        [path stroke];
    }
    
    for (NSInteger i = 1; i < indexH - 1 ; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        path.lineWidth = 1.8;
        [path moveToPoint:CGPointMake(QPWH, i * QPWH)];
        [path addLineToPoint:CGPointMake(SCREEN_WIDTH - QPWH, i * QPWH)];
        
//        [[UIColor blackColor] set];
        
        [path stroke];
    }
    // 外边框线
    UIBezierPath *borderPath = [UIBezierPath bezierPath];
    
    borderPath.lineWidth = 4;
    [borderPath moveToPoint:CGPointMake(LEFTRIGHT, UPDOWN)];
    [borderPath addLineToPoint:CGPointMake(LEFTRIGHT, SCREEN_HEIGHT - UPDOWN - 64)];
    [borderPath addLineToPoint:CGPointMake(SCREEN_WIDTH - LEFTRIGHT, SCREEN_HEIGHT - UPDOWN - 64)];
    [borderPath addLineToPoint:CGPointMake(SCREEN_WIDTH - LEFTRIGHT, UPDOWN)];
    [borderPath closePath];
    
    [borderPath stroke];
    
    
    // 五个黑点
    
    
    
    /** {384, 544} **/
//    NSLog(@"%@",NSStringFromCGPoint(self.center));
    
    // 五个黑点的行和列的坐标
    
//    5 4  /  5 12  /  10  8  /  15 4  /  15 12
    
    NSArray *pointArr = @[
                          @{@"row" :  @5, @"column" :  @4},
                          @{@"row" :  @5, @"column" : @12},
                          @{@"row" : @10, @"column" :  @8},
                          @{@"row" : @15, @"column" :  @4},
                          @{@"row" : @15, @"column" : @12}];
    
    
    for (NSInteger i = 0; i < pointArr.count; i++) {
        
        NSDictionary *dic = pointArr[i];
        
        NSInteger row = [dic[@"row"] integerValue];
        NSInteger column = [dic[@"column"] integerValue];
        
        CGFloat x = column * QPWH - pointWH / 2 ;
        CGFloat y = row * QPWH - pointWH / 2 ;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, pointWH, pointWH)];

        path.lineWidth = 3;
        
        [path fill];

        
    }
    
    

    
}


@end
