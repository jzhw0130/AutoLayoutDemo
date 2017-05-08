//
//  MeasureViewController.m
//  LayerApp
//
//  Created by jing on 4/25/17.
//  Copyright © 2017 jing. All rights reserved.
//

#import "MeasureViewController.h"

@interface MeasureViewController (){
    UIImageView *pulseImageView;
    UIImageView *pulseBKImageView;
    UIView *bkView;
    
    
    UIImageView *piImageView;
    UIImageView *heartImageView;
    
    UIImageView *waveBKImgeView;
    
    UILabel *tipLabel;
}

@property (weak, nonatomic) IBOutlet UIImageView *pulseView;
@property (weak, nonatomic) IBOutlet UIView *drawView;
@property (weak, nonatomic) IBOutlet UILabel *pulseLabel;

@end




@implementation MeasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = NSLocalizedString(@"Pulse Oximetry", @"");
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Result", @"") style:UIBarButtonItemStylePlain target:self action:@selector(goToResult)];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [_pulseLabel setAdjustsFontForContentSizeCategory:YES];
    
    //绿色背景
    pulseBKImageView = [[UIImageView alloc]init];
    pulseBKImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [pulseBKImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"po_Line1"]]];
    
    [self.drawView addSubview:pulseBKImageView];

    //波形图的背景图
    waveBKImgeView = [[UIImageView alloc]init];
    waveBKImgeView.translatesAutoresizingMaskIntoConstraints = NO;
    [waveBKImgeView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"po_grid"]]];
    waveBKImgeView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    [waveBKImgeView setTransform:CGAffineTransformMakeRotation(M_PI)];
    
    [self.drawView addSubview:waveBKImgeView];
    
    
    //提示信息
    tipLabel = [[UILabel alloc]init];
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:25.0f];
    tipLabel.minimumScaleFactor = 0.3f;
    tipLabel.adjustsFontSizeToFitWidth = YES;
    tipLabel.text = NSLocalizedString(@"Pull out the finger fro the device can stop measurement", @"");
    
    [self.drawView addSubview:tipLabel];
    
    /*
    bkView = [[UIView alloc]init];
    bkView.translatesAutoresizingMaskIntoConstraints = NO;
    [bkView setBackgroundColor:[UIColor whiteColor]];
    
    [self.drawView addSubview:bkView];
    
    //灰色遮挡
    pulseImageView = [[UIImageView alloc]init];
    pulseImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [pulseImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"po_Line2"]]];
    
    [self.drawView addSubview:pulseImageView];
    
   

    //绿色对比
    heartImageView = [[UIImageView alloc]init];
    heartImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [heartImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"po_Line1"]]];
    
    [self.drawView addSubview:heartImageView];
    
    //对比灰色
    piImageView = [[UIImageView alloc]init];
    piImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [piImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"po_Line2"]]];
    
    [self.drawView addSubview:piImageView];
    
     */
    
    //绿色背景 - 约束
    //Width Constraint
    NSLayoutConstraint *pulseBKWidthConstraint = [NSLayoutConstraint constraintWithItem:pulseBKImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:8.0];
    [pulseBKImageView addConstraints:@[pulseBKWidthConstraint]];
    //Height Constraint
    NSLayoutConstraint *pulseBKHeightConstraint = [NSLayoutConstraint constraintWithItem:pulseBKImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeHeight multiplier:0.8 constant:0];
    //Center.X Constraint
    NSLayoutConstraint *pulseBKCenterX = [NSLayoutConstraint constraintWithItem:pulseBKImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeCenterX multiplier:0.2 constant:0.0];
    //Center.Y Constraint
    NSLayoutConstraint *pulseBKTop = [NSLayoutConstraint constraintWithItem:pulseBKImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
    
    
    [self.drawView addConstraints:@[pulseBKHeightConstraint, pulseBKCenterX, pulseBKTop]];
    
    
    //波形图的背景图 - 约束
    //Width Constraint
    NSLayoutConstraint *waveKWidthConstraint = [NSLayoutConstraint constraintWithItem:waveBKImgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0.0];
    //Height Constraint
    NSLayoutConstraint *waveBKHeightConstraint = [NSLayoutConstraint constraintWithItem:waveBKImgeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeHeight multiplier:0.8 constant:0];
    //Center.X Constraint
    NSLayoutConstraint *waveBKLeft = [NSLayoutConstraint constraintWithItem:waveBKImgeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pulseBKImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:20.0];
    //Center.Y Constraint
    NSLayoutConstraint *waveBKTop = [NSLayoutConstraint constraintWithItem:waveBKImgeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
    
    
    [self.drawView addConstraints:@[waveKWidthConstraint, waveBKHeightConstraint, waveBKLeft, waveBKTop]];
    
    
    //提示信息 - 约束
    //Width Constraint
    NSLayoutConstraint *tipLabelWidthConstraint = [NSLayoutConstraint constraintWithItem:tipLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0.0];
    //Center.X Constraint
    NSLayoutConstraint *tipLabelCenterX = [NSLayoutConstraint constraintWithItem:tipLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    //Center.Y Constraint
    NSLayoutConstraint *tipLabelTop = [NSLayoutConstraint constraintWithItem:tipLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:waveBKImgeView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    
    [self.drawView addConstraints:@[tipLabelWidthConstraint, tipLabelCenterX, tipLabelTop]];
    
    /*
    //Width Constraint
    NSLayoutConstraint *bkWidthConstraint = [NSLayoutConstraint constraintWithItem:bkView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:8.0];
    [bkView addConstraints:@[bkWidthConstraint]];
    //Height Constraint
    NSLayoutConstraint *bkHeightConstraint = [NSLayoutConstraint constraintWithItem:bkView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeHeight multiplier:0.8 constant:0];
    //Center.X Constraint
    NSLayoutConstraint *bkCenterX = [NSLayoutConstraint constraintWithItem:bkView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeCenterX multiplier:0.2 constant:0.0];
    //Center.Y Constraint
    NSLayoutConstraint *bkTop = [NSLayoutConstraint constraintWithItem:bkView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
    
    
    [self.drawView addConstraints:@[bkHeightConstraint, bkCenterX, bkTop]];
    
    
    
    
    //灰色遮挡 - 约束
    //Width Constraint
    NSLayoutConstraint *pulseWidthConstraint = [NSLayoutConstraint constraintWithItem:pulseImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:8.0];
    [pulseImageView addConstraints:@[pulseWidthConstraint]];
    //Height Constraint
    NSLayoutConstraint *pulseHeightConstraint = [NSLayoutConstraint constraintWithItem:pulseImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeHeight multiplier:0.6 constant:0];
    //Center.X Constraint
    NSLayoutConstraint *pulseCenterX = [NSLayoutConstraint constraintWithItem:pulseImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeCenterX multiplier:0.2 constant:0.0];
    //Center.Y Constraint
    NSLayoutConstraint *pulseTop = [NSLayoutConstraint constraintWithItem:pulseImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
    
    
    [self.drawView addConstraints:@[pulseHeightConstraint, pulseCenterX, pulseTop]];
    
    
    
    //灰色对比 - 约束
    //Width Constraint
    NSLayoutConstraint *piWidthConstraint = [NSLayoutConstraint constraintWithItem:piImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:8.0];
    [piImageView addConstraints:@[piWidthConstraint]];
    //Height Constraint
    NSLayoutConstraint *piHeightConstraint = [NSLayoutConstraint constraintWithItem:piImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeHeight multiplier:0.6 constant:0];
    //Center.X Constraint
    NSLayoutConstraint *piCenterX = [NSLayoutConstraint constraintWithItem:piImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeCenterX multiplier:0.23 constant:0.0];
    //Center.Y Constraint
    NSLayoutConstraint *piTop = [NSLayoutConstraint constraintWithItem:piImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
    
    
    [self.drawView addConstraints:@[piHeightConstraint, piCenterX, piTop]];
    
    
    //绿色对比 - 约束
    //Width Constraint
    NSLayoutConstraint *heartWidthConstraint = [NSLayoutConstraint constraintWithItem:heartImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:8.0];
    [heartImageView addConstraints:@[heartWidthConstraint]];
    //Height Constraint
    NSLayoutConstraint *heartHeightConstraint = [NSLayoutConstraint constraintWithItem:heartImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeHeight multiplier:0.6 constant:0];
    //Center.X Constraint
    NSLayoutConstraint *heartCenterX = [NSLayoutConstraint constraintWithItem:heartImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeCenterX multiplier:0.17 constant:0.0];
    //Center.Y Constraint
    NSLayoutConstraint *heartTop = [NSLayoutConstraint constraintWithItem:heartImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.drawView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
    
    [self.drawView addConstraints:@[heartHeightConstraint, heartCenterX, heartTop]];


     */
    
//    [self performSelector:@selector(changePulse) withObject:nil afterDelay:0.2f];

    
}


- (void)changePulse {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        pulseBKImageView.frame = CGRectMake(pulseBKImageView.frame.origin.x, pulseBKImageView.frame.origin.y, pulseBKImageView.frame.size.width, pulseBKImageView.frame.size.height - 1.0);
        
//        pulseImageView.frame = CGRectMake(pulseImageView.frame.origin.x, pulseImageView.frame.origin.y, pulseImageView.frame.size.width, pulseImageView.frame.size.height - 1.0);
        
//        piImageView.frame = CGRectMake(piImageView.frame.origin.x, self.drawView.frame.size.height - 30.0f - piImageView.frame.size.height, piImageView.frame.size.width, piImageView.frame.size.height - 1.0);

    });
    
    [self performSelector:@selector(changePulse) withObject:nil afterDelay:0.2f];
}

- (void)goToResult {
    [self performSegueWithIdentifier:@"ResultViewControllerID" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResultViewControllerID"]) {
        NSLog(@"Prepare for segue result view controller");
    }
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
