//
//  Header.h
//  GoBang
//
//  Created by Dxue on 16/5/23.
//  Copyright © 2016年 Dxue. All rights reserved.
//

#ifndef Header_h
#define Header_h

// 棋子宽高
#define QZWH 46

// 棋盘宽高
#define QPWH 48

// 提示点的宽高
#define pointWH 12

// 纵向列数
#define Columnssss  ( ( SCREEN_WIDTH / QPWH) - 1 )

// 横向行数
#define ROW (( (SCREEN_HEIGHT- 64) / QPWH) - 1 )

// 屏幕高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 屏幕宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

// 上下边距
#define UPDOWN 15

// 左右边距
#define LEFTRIGHT 20




#endif /* Header_h */
