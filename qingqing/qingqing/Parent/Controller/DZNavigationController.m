//
//  DZNavigationController.m
//  qingqing
//
//  Created by Gavin on 2018/4/25.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZNavigationController.h"
#import "UIImage+Extension.h"

@interface DZNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;

@end

@implementation DZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:dzFont(20), NSForegroundColorAttributeName:dzRgba(1, 0.41, 0.51, 1)}];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}
+ (void)initialize {
    // 设置UIUINavigationBar的主题
    [self setupNavigationBarTheme];
}
/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupNavigationBarTheme {
    // 通过appearance对象能修改整个项目中所有UIBarbuttonItem的样式
    //    UINavigationBar *appearance = [UINavigationBar appearance];
//    UINavigationBar *appearance = [UINavigationBar appearanceWhenContainedIn:[self class], nil];//[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    
    
    // 1.设置导航条的背景
//    [appearance setBackgroundImage:[UIImage createImageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
//    [appearance setShadowImage:[UIImage new]];
    
    
    // 设置文字
//    NSMutableDictionary *att = [NSMutableDictionary dictionary];
//    att[NSFontAttributeName] =dkFont(20);
//    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [appearance setTitleTextAttributes:att];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {// 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -20;
        
        UIButton *button = [[UIButton alloc] init];
        // 设置按钮的背景图片
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        // 设置按钮的尺寸为背景图片的尺寸
        button.frame = CGRectMake(0, 0, 26, 44);
        
        //监听按钮的点击
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        
        //设置导航栏的按钮
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        //        viewController.navigationItem.leftBarButtonItem = backButton;
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }
    [super pushViewController:viewController animated:animated];
}

// 完全展示完调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果展示的控制器是根控制器，就还原pop手势代理
    if (viewController == [self.viewControllers firstObject]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}

- (void)backButtonTapClick {
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
