# JJResponderLink
响应者链解释,hitTest方法内部实现,图形化易懂

## hitTest内部实现
```

#pragma mark - 响应者链条的hitTest方法 ,因为内部原因,这个方法会调用两次
-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

Class cls = [self class];
NSLog(@"%@",cls); //为了更好测试自己加上去的
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
```

>   //系统内部实现元音,hitTest方法会调用两次
//如果一个View(BView)的范围超出父View(AView),那么点击Bview的超出父视图部分Bview将检测不到

>   //响应者链条 UIApplication -> _window -> rootViewController -> rootView -> 某一个子视图 -> 子视图的子视图 -> 最终找到最终的点击部位    

>  在这个过程中调用了hitTest方法,hitTest方法内部调用了pointInSide 方法,判断点击点是不是在自身范围内

>    //如果当前控件不能交互,返回nil,如果点不在自己范围内,返回nil
//在自身范围内,那么就递归查询是不是在自身子控件内,最终找到最中是点击在哪个空间上, 如果不在自身子控件中,就直接在自己身上,返回self

>    //点击部位对应的响应者尝试去响应,如果能响应,那么就响应,并且结束传递,如果不能响应,那么传给上一级responder Object进行响应
//如果写[super touchesBegan]可以实现多级响应
