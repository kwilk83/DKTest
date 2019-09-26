//
//  ViewController.m
//  DKTest
//
//  Created by Kevin Wilkinson on 9/25/19.
//  Copyright © 2019 kwilkinson. All rights reserved.
//

#import "ViewController.h"
#import "SwingData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SwingData* data = [[SwingData alloc]initWithFileName:@"latestSwing.csv"];
}


@end
