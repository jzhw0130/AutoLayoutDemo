//
//  ViewController.m
//  LayerApp
//
//  Created by jing on 4/24/17.
//  Copyright © 2017 jing. All rights reserved.
//

#import "ViewController.h"
#import <sys/utsname.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tipTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"iHealth Layered App(Measurement Only)", @"");
    
    
    UIDevice *currentDevice = [UIDevice currentDevice];
    

    //orientation
    UIDeviceOrientation orientation = [currentDevice orientation];
    //model
    NSString *model = [self deviceModel];
    if ((orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) && [model compare:@"iPhone6"] == NSOrderedAscending ) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0]}];
    }
    
    //phone or pad
    UIUserInterfaceIdiom idiom = [currentDevice userInterfaceIdiom];
    if (UIUserInterfaceIdiomPhone == idiom) {
        self.tipTextView.text = NSLocalizedString(@"Please note this is an invite only app.\nIf you don't have a invitation code.\nYou won't be able to log in.", @"");
    } else {
        self.tipTextView.text = NSLocalizedString(@"Please note this is an invite only app.If you don't have a invitation code.\nYou won't be able to log in.", @"");
    }
    
    self.tipTextView.font = [UIFont fontWithName:@"BebasNeueBold" size:20.0f];
    
    
    __weak ViewController *vc = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"You have connected a BP5, are you ready to do a measurement now?", @"") preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"ok, measure now");
            [vc performSegueWithIdentifier:@"MeasureViewControllerID" sender:vc];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Later", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"measure later");
        }]];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    });
    
//    for (NSString *font in [UIFont familyNames]) {
//        NSLog(@"font:%@",font);
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:font]) {
//            NSLog(@"---fontName:%@", fontName);
//        }
//    }
    
}

- (NSString *)deviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *model = [NSString stringWithUTF8String:systemInfo.machine];
    
    return model;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MeasureViewControllerID"]) {
        NSLog(@"Prepare for segue for measure view controller");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
