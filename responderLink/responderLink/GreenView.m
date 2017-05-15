//
//  GreenView.m
//  容器视图
//
//  Created by 罗文琦 on 2017/5/15.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "GreenView.h"

@implementation GreenView
#pragma mark - 响应者链条的hitTest方法 ,因为内部原因,这个方法会调用两次
-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    Class cls = [self class];
    NSLog(@"%@",cls);
    //内部实现我们不能看到,但是我们可以推测
    //1.判断这个控件是不是可以进行交互,当控件的透明度小于等于0.01的时候是不能进行交互的
    if (self.userInteractionEnabled == NO || self.alpha <= 0.01 ||self.hidden == YES) {
        return nil;
    }
    //2.判断被点击的点是不是在自己的区域内
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
   
    //3.当可以交互并且被点击的点在自己里面,那么久递归查找是自己的哪一个子控件
    for (int i = (int)self.subviews.count - 1; i >=0 ; i--) {
        
        UIView* lastView = self.subviews[i];
        //将点击点转化为子控件中的点
        CGPoint subPoint = [self convertPoint:point toView:lastView];
        //调用子控件的hitTest方法,看有没有更加合适的子控件
        UIView* nextView = [lastView hitTest:subPoint withEvent:event];
        
        if (nextView) {
            return nextView;
        }
    }
    //如果没有合适的子控件,那么就说明自己就是最合适的子控件
    return  self;
}

@end
