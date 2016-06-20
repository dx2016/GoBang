//
//  GoBangView.m
//  GoBang
//
//  Created by Dxue on 16/5/23.
//  Copyright © 2016年 Dxue. All rights reserved.
//

#import "GoBangView.h"
#import "Header.h"
#import <AVFoundation/AVFoundation.h>

@interface GoBangView () <UIAlertViewDelegate>
{
    /**
     *  连续的棋子 default 1
     */
    NSInteger _count;
    
    NSMutableArray *leftArr;
    NSMutableArray *rightArr;

    
}

// 棋子数组
@property (nonatomic, strong) NSMutableArray *mArray;

@property (nonatomic, assign) BOOL isSuccess;

// 音频
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation GoBangView

- (NSMutableArray *)mArray
{
    if (_mArray == nil) {
        _mArray = [[NSMutableArray alloc] init];
    }
    return _mArray;
}

- (AVAudioPlayer *)player
{
    if (_player == nil) {
        // 1. 获取路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"put" ofType:@"wav"];
        
        // 2. NSData
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        // 3. 将路径添加到AVAudioPlayer
        NSError *error = nil;
        _player = [[AVAudioPlayer alloc] initWithData:data error:&error];
        
        
        // 进度
        _player.currentTime = 0.0000558;
        
        // 声音
        _player.volume = 1.0;
        
        // 4. 缓冲
        [_player prepareToPlay];
        
    }
    return _player;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        [self initLeftRightArr];
    }
    return self;
}

- (void)initViews{
    
    
//    self.multipleTouchEnabled = NO;
//    self.multipleTouchEnabled = YES;
//    [self setExclusiveTouch:YES];

    
    NSInteger index = Columnssss * ROW;
    
    for (NSInteger i = 0; i < index; i++) {
        
        NSInteger row = i / Columnssss;
        NSInteger column = i % (NSInteger)Columnssss;
        
        CGFloat X = column * QPWH - QZWH / 2 + QPWH;
        CGFloat Y = row * QPWH - QZWH / 2 + QPWH;

        UIImageView *item = [[UIImageView alloc] initWithFrame:CGRectMake(X, Y, QZWH, QZWH)];
        
        item.tag = 100 + i;
        
        item.layer.cornerRadius = QZWH / 2;
        item.backgroundColor = [UIColor clearColor];
        
        
        item.userInteractionEnabled = YES;
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        [item addGestureRecognizer:tap];
        
        [item setExclusiveTouch:YES];
        
        [self addSubview:item];
    }
    self.isSuccess = NO;
}

- (void)initLeftRightArr
{
    NSInteger leftCount = 100;
    NSInteger rightCount = 114;
    
    leftArr = [NSMutableArray array];
    rightArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < ROW; i++) {
        
        NSNumber *leftTag = [NSNumber numberWithInteger:leftCount];
        NSNumber *rightTag = [NSNumber numberWithInteger:rightCount];
        
        
        [leftArr addObject:leftTag];
        [rightArr addObject:rightTag];
        
        leftCount += Columnssss;
        rightCount += Columnssss;
    }
    
//    NSLog(@"%@ /n/n/n/n %@", leftArr, rightArr);
    

}

#pragma mark - 点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:self];
    
    // 判断点击的点是不是棋子的范围
    [self isContainPoint:point];
    
    // 判断是否胜利
    [self judgeSuccessAction];
    
}

// 判断点击的点是不是棋子的范围
- (void)isContainPoint:(CGPoint)point{
    
    for (UIView *item in self.subviews) {
        
        BOOL isContBool = CGRectContainsPoint(item.frame, point);
        
        if (isContBool) {

            // 当这个点在item中，判断这个数组是否包含此对象 不包含则添加
            if (![self.mArray containsObject:item]) {
                [self.mArray addObject:item];
                [self downPiece];
                // 绘制
                [self setNeedsDisplay];
            }
        }
    }
}

#pragma mark - 判断是否胜利
- (void)judgeSuccessAction{
    
    NSMutableArray *blackArr = [[NSMutableArray alloc] init];
    NSMutableArray *whiteArr = [[NSMutableArray alloc] init];
    
    [self.mArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx % 2 == 0) {
            
            [blackArr addObject:obj];
        } else {
            [whiteArr addObject:obj];
        }
    }];
    
    // 判断是否赢棋
    [self success:blackArr isBlack:YES];
    [self success:whiteArr isBlack:NO];
    
}

- (void)success:(NSMutableArray *)array isBlack:(BOOL)isBlack{
    
    if (array.count == 0) return;
    
    NSMutableArray *tagArr = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIView *item = (UIView *)obj;
        
        [tagArr addObject:[NSNumber numberWithInteger:item.tag]];
        
    }];
    
    // 排序之后的数组
    NSArray *newArr = [self comareArray:tagArr];
    
    
    NSMutableArray *arrayLeft = [NSMutableArray array];
    NSMutableArray *arrayRight = [NSMutableArray array];
    
    for (NSNumber *num in newArr) {
        [arrayLeft addObject:num];
        [arrayRight addObject:num];
    }
    
    
//    __weak __typeof(self) weakSelfj = self;
    
//    dispatch_queue_t _queue = dispatch_queue_create("GCDQueue", DISPATCH_QUEUE_SERIAL);
    
    // 判断横向
//    dispatch_async(_queue, ^{
        [self direction:newArr type:1 isBlack:isBlack];
//    });

    // 判断纵向
//    dispatch_async(_queue, ^{
        [self direction:newArr type:Columnssss isBlack:isBlack];
//    });
    
    // 判断左下斜
//    dispatch_async(_queue, ^{
    
    [arrayLeft removeObjectsInArray:leftArr];
        [self direction:arrayLeft type:Columnssss - 1 isBlack:isBlack];
//    });
    
    // 判断右下斜
//    dispatch_async(_queue, ^{
    [arrayRight removeObjectsInArray:rightArr];
        [self direction:arrayRight type:Columnssss + 1 isBlack:isBlack];
//    });
    
    
}

// 判断在某个方向是否有连续的5个子
- (void)direction:(NSArray *)array type:(NSInteger)type isBlack:(BOOL)isBlack{
    
    NSMutableArray *arrrrr = [NSMutableArray array];
    
// bug 左下斜 删除最左边的一栏  右下斜 删除最右边一栏  保证没错
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        _count = 1;

        NSNumber *tag = (NSNumber *)obj;
        NSInteger tagInt = tag.integerValue;
        
        [arrrrr addObject:tag];

        
        for (NSInteger i = 1 ; i < array.count; i++) {
            
            NSNumber *newTag = [NSNumber numberWithInteger:tagInt + type];
            
            BOOL isContain = [array containsObject:newTag];
            
            if (isContain) {
                _count ++;
                [arrrrr addObject:newTag];
                
                if (_count >= 5) {
                    
                    NSLog(@"%@",arrrrr);
                    [self onceSuccess:isBlack];
                    return;
                }
                tagInt += type;
            } else {
                [arrrrr removeAllObjects];

                break;
            }
        }
    }];

}

// 当某一方已经胜利
- (void)onceSuccess:(BOOL)isBlack{

    if (self.isSuccess) {
        return; // 不让更多的胜利判定进入
    }
    
    self.isSuccess = YES;
    

    NSString *string = isBlack ? @"黑棋获胜" : @"白棋获胜";
    
    NSLog(@"%@",string);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"游戏结束" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    
    [alertView show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
//        [self.mArray makeObjectsPerformSelector:@selector(setBackgroundColor:) withObject:[UIColor clearColor]];
        [self.mArray makeObjectsPerformSelector:@selector(setImage:) withObject:nil];
        [self.mArray removeAllObjects];
        [self setNeedsDisplay];
        self.isSuccess = NO;
    }
    
}


#pragma mark - 数组排序
- (NSArray *)comareArray:(NSArray *)array
{
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    array = [array sortedArrayUsingComparator:cmptr];
    return array ;
}

#pragma mark - 功能区 - 悔棋 - 重玩

// 悔棋
- (void)undo
{
    
    UIImageView *item = self.mArray.lastObject;
    
//    item.backgroundColor = [UIColor clearColor];
    item.image = nil;
    
    [self.mArray removeLastObject];
    [self setNeedsDisplay];
    
}

// 重玩
- (void)RePlay
{
//    [self.mArray makeObjectsPerformSelector:@selector(setBackgroundColor:) withObject:[UIColor clearColor]];
    [self.mArray makeObjectsPerformSelector:@selector(setImage:) withObject:nil];
    [self.mArray removeAllObjects];
    [self setNeedsDisplay];
    self.isSuccess = NO;
}

// 落子音效
- (void)downPiece
{
    // 5. 播放
//    [_player play];
    [self.player play];
}

#pragma mark - drawRect
- (void)drawRect:(CGRect)rect{

    // 画棋子
    [self.mArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *item = (UIImageView *)obj;

        if (idx %2 == 0) {
            // 黑子
//            item.backgroundColor = [UIColor blackColor];
            item.image = [UIImage imageNamed:@"stone_black"];
            [item.layer removeAnimationForKey:@"scale"];
            
        } else {
            // 白子
//            item.backgroundColor = [UIColor whiteColor];
            item.image = [UIImage imageNamed:@"stone_white"];
            [item.layer removeAnimationForKey:@"scale"];
        }
    }];
    
    UIImageView *item = self.mArray.lastObject;
    
    
//    item.backgroundColor = [UIColor redColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue = @.8;
    animation.toValue = @1;
    
    animation.duration = .3;
    animation.autoreverses = YES;
    animation.repeatCount = MAXFLOAT;
    
    [item.layer addAnimation:animation forKey:@"scale"];
}

@end
