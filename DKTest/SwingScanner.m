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

-(NSUInteger)searchContinuityAboveValue:(NSArray *)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd threshold:(float)threshold winLength:(int)winLength {
    
    return [self searchData:data
                  indexBegin:indexBegin
                    indexEnd:indexEnd
                   winLength:winLength comparisonBlock:^BOOL(float value) {
        return value < threshold;
    }];
}

-(NSUInteger)backSearchContinuityWithinRange:(NSArray *)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd thresholdLo:(float)thresholdLo thresholdHi:(float)thresholdHi winLength:(int)winLength {
    
    NSArray* reveresedArray = [[data reverseObjectEnumerator] allObjects];
    NSIndexPath* indexPath = [self searchData:reveresedArray
                                   indexBegin:indexBegin
                                     indexEnd:indexEnd
                                    winLength:winLength
                              comparisonBlock:^BOOL(float value) {
        return value > thresholdLo && value < thresholdHi;
    }];
    
    return [reveresedArray count] - [indexPath indexAtPosition:0];
}

-(NSUInteger)searchContinuityAboveValueTwoSignals:(NSArray *)data1 data2:(NSArray *)data2 indexBegin:(int)indexBegin indexEnd:(int)indexEnd threshold1:(float)threshold1 threshold2:(float)threshold2 winLength:(int)winLength {
    
    int index = indexBegin;
    
    do {
        NSIndexPath *indexPath1 = [self searchData:data1
                                       indexBegin:index
                                         indexEnd:indexEnd
                                         winLength:winLength
                                   comparisonBlock:^BOOL(float value) {
            return value > threshold1;
        }];
        
        if (indexPath1) {
            NSIndexPath *indexPath2 = [self searchData:data2
                                            indexBegin:(int)[indexPath1 indexAtPosition:0]
                                              indexEnd:(int)[indexPath1 indexAtPosition:0] + winLength
                                             winLength:winLength
                                       comparisonBlock:^BOOL(float value) {
                return value > threshold2;
            }];
            
            if (indexPath2) {
                return [indexPath2 indexAtPosition:0];
            } else {
                // ensures subsequent search starts at last start + 1
                index = (int)[indexPath1 indexAtPosition:0] + 1;
            }
            
        } else {
            index = indexEnd;
        }
    } while (index < (indexEnd - winLength));
    
    return -1;
}

-(NSArray*)searchMultiContinuityWithinRange:(NSArray *)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd thresholdLo:(float)thresholdLo thresholdHi:(float)thresholdHi winLength:(int)winLength {
    
    NSMutableArray* returnArray = [NSMutableArray new];
    int index = indexBegin;
    
    do {
        NSIndexPath *indexPath = [self searchData:data
                                       indexBegin:index
                                         indexEnd:indexEnd
                                        winLength:winLength
                                  comparisonBlock:^BOOL(float value) {
            return value > thresholdLo && value < thresholdHi;
        }];
        
        if (indexPath) {
            [returnArray addObject:indexPath];
            
            // ensures subsequent search starts at the end of the last search
            index = (int)[indexPath indexAtPosition:0] + winLength + 1;
        } else {
            index = indexEnd;
        }
    } while (index < (indexEnd - winLength));
    
    return returnArray;
}


-(NSIndexPath*)searchData:(NSArray*)data indexBegin:(int)indexBegin indexEnd:(int)indexEnd winLength:(int)winLength comparisonBlock:(BOOL(^)(float value))comparisonBlock {
    long continuityCounter = 0;
    
    for (long i = indexBegin; i <= indexEnd; i++)  {
        
        float value = [data[i] floatValue];
        if (comparisonBlock(value)) {
            continuityCounter++;
        } else {
            continuityCounter = 0;
        }
        
        if (continuityCounter >= winLength) {
            return [NSIndexPath indexPathWithIndexes:(NSUInteger*)i - continuityCounter length:continuityCounter];
        }
    }
    return nil;
}
@end
