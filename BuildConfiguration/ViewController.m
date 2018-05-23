//
//  ViewController.m
//  BuildConfiguration
//
//  Created by Tamilarasu on 22/05/18.
//  Copyright © 2018 Itamilan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flavourLabel.text = [NSString stringWithFormat:@"%@\n%@",[[NSBundle mainBundle] bundleIdentifier], [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
