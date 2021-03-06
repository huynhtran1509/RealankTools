//
//  WandoujiaViewController.m
//  RealankTools
//
//  Created by Realank on 16/2/15.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "WandoujiaViewController.h"
#import "SecondWDJViewController.h"

@interface WandoujiaViewController ()

@end

@implementation WandoujiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"VC1";
    // Do any additional setup after loading the view from its nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    [self performSegueWithIdentifier:@"ShowNext" sender:nil];
    //    [self.navigationController pushViewController:[[SecondViewController alloc]init] animated:YES];
    //    [self presentViewController:[[SecondViewController alloc]init] animated:YES completion:nil];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    SecondWDJViewController *secondVC = [[SecondWDJViewController alloc]init];
    secondVC.previousNav = self.navigationController;
    [self animToNextViewController:secondVC beginRect:CGRectMake(0, screenHeight/2-20, screenWidth, 40)];
}

- (void) animToNextViewController:(UIViewController*)viewController beginRect:(CGRect)beginFrame {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIView* shadowBack = [[UIView alloc]initWithFrame:window.bounds];
    shadowBack.backgroundColor = [UIColor blackColor];
    shadowBack.alpha = 0.7;
    [window addSubview:shadowBack];
    
    UIView* frontWhiteView = [[UIView alloc]initWithFrame:beginFrame];
    frontWhiteView.backgroundColor = [UIColor whiteColor];
    [window addSubview:frontWhiteView];
    
    NSTimeInterval timeInterval = 0.5;
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:timeInterval/5 animations:^{
        frontWhiteView.frame = CGRectMake(0, screenHeight/2-18, screenWidth, 36);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:4*timeInterval/5 animations:^{
            frontWhiteView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        } completion:^(BOOL finished) {
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
            viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
            [weakSelf presentViewController:nav animated:NO completion:^{
                [shadowBack removeFromSuperview];
                [frontWhiteView removeFromSuperview];
            }];
            //            [self.navigationController pushViewController:viewController animated:NO];
            //            [shadowBack removeFromSuperview];
            //            [frontWhiteView removeFromSuperview];
            
        }];
    }];
    
    [UIView animateWithDuration:timeInterval animations:^{
        
        weakSelf.navigationController.view.transform = CGAffineTransformMakeScale(0.85, 0.85);
        
    } completion:^(BOOL finished) {
        
        weakSelf.navigationController.view.transform = CGAffineTransformIdentity;
        
    }];
    
    
}



@end
