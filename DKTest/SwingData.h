//
//  SwingData.h
//  DKTest
//
//  Created by Kevin Wilkinson on 9/25/19.
//  Copyright © 2019 kwilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwingData : NSObject

@property (strong, nonatomic) NSArray *timestamps;
@property (strong, nonatomic) NSArray *ax;
@property (strong, nonatomic) NSArray *ay;
@property (strong, nonatomic) NSArray *az;
@property (strong, nonatomic) NSArray *wx;
@property (strong, nonatomic) NSArray *wy;
@property (strong, nonatomic) NSArray *wz;

-(id)initWithFileName:(NSString*)filename;

@end

NS_ASSUME_NONNULL_END
