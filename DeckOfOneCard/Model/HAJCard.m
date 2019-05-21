//
//  HAJCard.m
//  DeckOfOneCard
//
//  Created by Haley Jones on 5/21/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

#import "HAJCard.h"

@implementation HAJCard

- (instancetype)initFromDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self){
        NSDictionary *targetCard = dictionary[@"cards"][0];
        NSLog(@"Card: %@", targetCard);
        _suit = targetCard[@"suit"];
        _value = targetCard[@"value"];
        _imageLink = targetCard[@"image"];
    }
    return self;
}

@end
