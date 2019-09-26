//
//  SwingScanner.m
//  DKTest
//
//  Created by Kevin Wilkinson on 9/25/19.
//  Copyright © 2019 kwilkinson. All rights reserved.
//

#import "SwingScanner.h"
#import "SwingData.h"

@implementation SwingScanner

-(int)searchContinuityAboveValue:(NSArray *)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd threshold:(float)threshold winLength:(int)winLength {
    int continuityCounter = 0;
    
    for (int i = indexBegin; i <= indexEnd; i++)  {
        
        float value = [data[i] floatValue];
        if (value > threshold) {
            continuityCounter++;
        } else {
            continuityCounter = 0;
        }
        
        if (continuityCounter >= winLength) {
            return i - continuityCounter;
        }
    }
    return -1;
}

-(int)backSearchContinuityWithinRange:(NSArray *)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd thresholdLo:(float)thresholdLo thresholdHi:(float)thresholdHi winLength:(int)winLength {
    int continuityCounter = 0;
    
    for (int i = indexBegin; i >= indexEnd; i--)  {
        
        float value = [data[i] floatValue];
        if (value > thresholdLo && value < thresholdHi) {
            continuityCounter++;
        } else {
            continuityCounter = 0;
        }
        
        if (continuityCounter >= winLength) {
            return i;
        }
    }
    return -1;
}

-(int)searchContinuityAboveValueTwoSignals:(NSArray *)data1 data2:(NSArray *)data2 indexBegin:(int)indexBegin indexEnd:(int)indexEnd threshold1:(float)threshold1 threshold2:(float)threshold2 winLength:(int)winLength {
    int continuityCounter = 0;
    
    
    
    return -1;
}

-(NSArray*)searchMultiContinuityWithinRange:(NSArray *)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd thresholdLo:(float)thresholdLo thresholdHi:(float)thresholdHi winLength:(int)winLength {
    NSMutableArray* mutArr = [NSMutableArray new];
    int continuityCounter = 0;
    
    for (int i = indexBegin; i >= indexEnd; i--)  {
        
        float value = [data[i] floatValue];
        if (value > thresholdLo && value < thresholdHi) {
            continuityCounter++;
        } else if (continuityCounter >= winLength) {
            [mutArr addObject:[NSString stringWithFormat:@"%i", i - continuityCounter]];
            continuityCounter = 0;
        } else {
            continuityCounter = 0;
        }
    }
    
    return mutArr;
}

@end
