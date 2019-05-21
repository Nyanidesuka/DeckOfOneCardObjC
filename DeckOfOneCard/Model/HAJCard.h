//
//  HAJCard.h
//  DeckOfOneCard
//
//  Created by Haley Jones on 5/21/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HAJCard : NSObject

-(instancetype)initFromDictionary: (NSDictionary<NSString *, NSString *> *)dictionary;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *suit;
@property (nonatomic, copy) NSString *imageLink;

@end

NS_ASSUME_NONNULL_END
