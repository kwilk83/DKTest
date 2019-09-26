//
//  SwingData.m
//  DKTest
//
//  Created by Kevin Wilkinson on 9/25/19.
//  Copyright © 2019 kwilkinson. All rights reserved.
//

#import "SwingData.h"

@implementation SwingData

-(id)initWithFileName:(NSString *)filename {
    if (self = [super init]) {
        
        NSArray* components = [filename componentsSeparatedByString:@"."];
        NSString* path = [[NSBundle mainBundle] pathForResource:components[0] ofType:components[1]];
        NSString* contents = [[NSString stringWithContentsOfFile:path
                                                        encoding:NSUTF8StringEncoding
                                                           error:nil] stringByReplacingOccurrencesOfString:@"\r"
                                                                      withString:@""];
        [self parseCSVString:contents];
    }
    return self;
}

-(void)parseCSVString:(NSString*)content {
    NSArray* lines = [content componentsSeparatedByString:@"\n"];
    NSMutableArray* mutTimestamp = [[NSMutableArray alloc]initWithCapacity:[lines count]];
    NSMutableArray* mutAX = [[NSMutableArray alloc]initWithCapacity:[lines count]];
    NSMutableArray* mutAY = [[NSMutableArray alloc]initWithCapacity:[lines count]];
    NSMutableArray* mutAZ = [[NSMutableArray alloc]initWithCapacity:[lines count]];
    NSMutableArray* mutWX = [[NSMutableArray alloc]initWithCapacity:[lines count]];
    NSMutableArray* mutWY = [[NSMutableArray alloc]initWithCapacity:[lines count]];
    NSMutableArray* mutWZ = [[NSMutableArray alloc]initWithCapacity:[lines count]];
    
    for (int i = 0; i < [lines count]; i++){
        NSArray* components = [[lines objectAtIndex:i] componentsSeparatedByString:@","];
        [mutTimestamp addObject:components[0]];
        [mutAX addObject:components[1]];
        [mutAY addObject:components[2]];
        [mutAZ addObject:components[3]];
        [mutWX addObject:components[4]];
        [mutWY addObject:components[5]];
        [mutWZ addObject:components[6]];
    }
    
    self.timestamps = [NSArray arrayWithArray:mutTimestamp];
    self.ax = [NSArray arrayWithArray:mutAX];
    self.ay = [NSArray arrayWithArray:mutAY];
    self.az = [NSArray arrayWithArray:mutAZ];
    self.wx = [NSArray arrayWithArray:mutWX];
    self.wy = [NSArray arrayWithArray:mutWY];
    self.wz = [NSArray arrayWithArray:mutWZ];
}

@end
