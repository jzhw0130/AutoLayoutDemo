//
//  ResultViewController.m
//  LayerApp
//
//  Created by jing on 4/25/17.
//  Copyright © 2017 jing. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController () {
    NSTimer *printTimer;
    __weak IBOutlet UIView *downView;
}

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Pulse Oximetry", @"");
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Cancel", @"") style:UIBarButtonItemStylePlain target:self action:@selector(goToMeasureView)];
    
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [downView layoutIfNeeded];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:25.0f];
    self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height/2;
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.tintColor = [UIColor whiteColor];
    

    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [downView layoutIfNeeded];
    self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height/2;
}


- (void)printInfo {
    NSLog(@"self.saveButton.bounds:%@",NSStringFromCGRect(self.saveButton.bounds));
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    NSLog(@"viewWillTransitionToSize:%@",NSStringFromCGSize(size));
}

- (void)goToMeasureView {
    [self.navigationController popViewControllerAnimated:YES];
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
