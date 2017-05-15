//
//  ViewController.m
//  responderLink
//
//  Created by 罗文琦 on 2017/5/15.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    /*
     >   //系统内部实现元音,hitTest方法会调用两次
     //如果一个View(BView)的范围超出父View(AView),那么点击Bview的超出父视图部分Bview将检测不到
     
     >   //响应者链条 UIApplication -> _window -> rootViewController -> rootView -> 某一个子视图 -> 子视图的子视图 -> 最终找到最终的点击部位
     
     >  在这个过程中调用了hitTest方法,hitTest方法内部调用了pointInSide 方法,判断点击点是不是在自身范围内
     
     >    //如果当前控件不能交互,返回nil,如果点不在自己范围内,返回nil
     //在自身范围内,那么就递归查询是不是在自身子控件内,最终找到最中是点击在哪个空间上, 如果不在自身子控件中,就直接在自己身上,返回self
     
     >    //点击部位对应的响应者尝试去响应,如果能响应,那么就响应,并且结束传递,如果不能响应,那么传给上一级responder Object进行响应
     //如果写[super touchesBegan]可以实现多级响应
     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
