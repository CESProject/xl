//
//  WelcomePageVC.m
//  BigWinner
//
//  Created by huahongbo on 15/11/6.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "WelcomePageVC.h"

@interface WelcomePageVC ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@property(nonatomic , weak)UIPageControl *pageControl;
@end

@implementation WelcomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * arr = @[@"01.png",@"02.png",@"03.png"];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(arr.count * _scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    CGFloat pageControlWidth = 100;
    CGFloat pageControlHeight = 30;
    pageControl.frame = CGRectMake((self.view.frame.size.width-pageControlWidth)/ 2, self.view.frame.size.height - pageControlWidth,pageControlWidth, pageControlHeight);
    pageControl.numberOfPages = arr.count;
    pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    CGFloat width = 240;
    CGFloat height = 360;
    for (int i = 0; i < arr.count; i++) {
        UIImage *image = [UIImage imageNamed:arr[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - width) / 2 + _scrollView.frame.size.width * i, (self.view.frame.size.height - height) / 2, width, height)];
        imageView.image = image;
        if (i == 2) {//最后一张图片增加手势上

            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0 , 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
            [button addTarget:self action:@selector(pageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            imageView.userInteractionEnabled = YES;
        }
        [_scrollView addSubview:imageView];
    }
    //隐藏滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    //不回弹
    _scrollView.bounces = NO;
    //设置 是否按页进行滚动
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
}
//PageView最后一个图片打开用户交互,点击进入MainViewController界面
- (void)pageBtnClick:(UIButton *)button
{
    [_scrollView removeFromSuperview];
    if (self.endTapThePage) {
        self.endTapThePage();
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x>2*DEF_SCREEN_WIDTH-30) {
        
        [UIView animateWithDuration:.5 animations:^{
            scrollView.alpha=0;//让scrollview 渐变消失
            
        }completion:^(BOOL finished) {
            [scrollView  removeFromSuperview];//将scrollView移除
            if (self.endTapThePage) {
                self.endTapThePage();
            }
            
        } ];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentIndex = (scrollView.contentOffset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = currentIndex;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x==2*DEF_SCREEN_WIDTH) {
        [self.pageControl removeFromSuperview];
        // 延迟2秒执行任务
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:.5 animations:^{
                scrollView.alpha=0;//让scrollview 渐变消失
                
            }completion:^(BOOL finished) {
                [scrollView  removeFromSuperview];//将scrollView移除
                if (self.endTapThePage) {
                    self.endTapThePage();
                }
                
            } ];
        });
        
    }
    
}
@end

