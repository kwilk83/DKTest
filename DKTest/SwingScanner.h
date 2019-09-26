//
//  SwingScanner.h
//  DKTest
//
//  Created by Kevin Wilkinson on 9/25/19.
//  Copyright © 2019 kwilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwingScanner : NSObject

-(int)searchContinuityAboveValue:(NSArray*)data
                       indexBegin:(int)indexBegin
                         indexEnd:(int)indexEnd
                        threshold:(float)threshold
                        winLength:(int)winLength;

-(int)backSearchContinuityWithinRange:(NSArray*)data
                            indexBegin:(int)indexBegin
                              indexEnd:(int)indexEnd
                           thresholdLo:(float)thresholdLo
                           thresholdHi:(float)thresholdHi
                             winLength:(int)winLength;

-(int)searchContinuityAboveValueTwoSignals:(NSArray*)data1
                                      data2:(NSArray*)data2
                                 indexBegin:(int)indexBegin
                                   indexEnd:(int)indexEnd
                                 threshold1:(float)threshold1
                                 threshold2:(float)threshold2
                                  winLength:(int)winLength;

-(NSArray*)searchMultiContinuityWithinRange:(NSArray*)data
                             indexBegin:(int)indexBegin
                               indexEnd:(int)indexEnd
                            thresholdLo:(float)thresholdLo
                            thresholdHi:(float)thresholdHi
                              winLength:(int)winLength;
@end

NS_ASSUME_NONNULL_END
