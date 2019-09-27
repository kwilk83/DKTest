//
//  SwingScanner.m
//  DKTest
//
//  Created by Kevin Wilkinson on 9/25/19.
//  Copyright © 2019 kwilkinson. All rights reserved.
//

#import "SwingScanner.h"
#import "SwingData.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation SwingScanner

-(int)searchContinuityAboveValue:(NSArray *)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd threshold:(float)threshold winLength:(int)winLength {
    
    return [self searchData:data data2:nil indexBegin:indexBegin indexEnd:indexEnd threshold1:threshold threshold2:CGFLOAT_MAX winLength:winLength];
}

-(int)backSearchContinuityWithinRange:(NSArray *)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd thresholdLo:(float)thresholdLo thresholdHi:(float)thresholdHi winLength:(int)winLength {
    
    NSArray* reveresedArray = [[data reverseObjectEnumerator] allObjects];
    return [self searchData:reveresedArray data2:nil indexBegin:indexBegin indexEnd:indexEnd threshold1:thresholdLo threshold2:thresholdHi winLength:winLength];
}

-(int)searchContinuityAboveValueTwoSignals:(NSArray *)data1 data2:(NSArray *)data2 indexBegin:(int)indexBegin indexEnd:(int)indexEnd threshold1:(float)threshold1 threshold2:(float)threshold2 winLength:(int)winLength {
    
    return [self searchData:data1 data2:data2 indexBegin:indexBegin indexEnd:indexEnd threshold1:threshold1 threshold2:threshold2 winLength:winLength];
}

-(NSArray*)searchMultiContinuityWithinRange:(NSArray *)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd thresholdLo:(float)thresholdLo thresholdHi:(float)thresholdHi winLength:(int)winLength {
    
    NSMutableArray* returnArray = [NSMutableArray new];
    NSMutableArray* mutArr = [NSMutableArray new];
    long continuityCounter = 0;
    
    for (long i = indexBegin; i <= indexEnd; i++)  {
        
        float value = [data[i] floatValue];
        
        if (value > thresholdLo && value < thresholdHi) {
            continuityCounter++;
            [mutArr addObject:[NSIndexPath indexPathWithIndexes:(NSUInteger*)i - continuityCounter length:continuityCounter]];
        } else if (continuityCounter >= winLength) {
            [returnArray addObject:mutArr];
            mutArr = [NSMutableArray new];
            continuityCounter = 0;
        } else {
            continuityCounter = 0;
        }
    }
    
    return returnArray;
}


-(int)searchData:(NSArray*)data1 data2:(NSArray*)data2 indexBegin:(int)indexBegin indexEnd:(int)indexEnd threshold1:(float)threshold1 threshold2:(float)threshold2 winLength:(int)winLength {
    int continuityCounter = 0;
    
    for (int i = indexBegin; i <= indexEnd; i++)  {
        
        if (data2) {

            float value1 = [data1[i] floatValue];
            float value2 = [data2[i] floatValue];
            
            if (value1 > threshold1 && value2 > threshold2) {
                continuityCounter++;
            } else {
                continuityCounter = 0;
            }
            
        } else {
            
            float value = [data1[i] floatValue];
            if (value > threshold1 && value < threshold2) {
                continuityCounter++;
            } else {
                continuityCounter = 0;
            }
        }
        
        
        if (continuityCounter >= winLength) {
            return i - continuityCounter;
        }
    }
    return -1;
}
@end
