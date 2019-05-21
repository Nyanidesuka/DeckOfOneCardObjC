//
//  HAJCardController.h
//  DeckOfOneCard
//
//  Created by Haley Jones on 5/21/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HAJCard.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HAJCardController : NSObject

+ (void)fetchCardFromDeck: (NSString *)deck completion: (void (^) (HAJCard * _Nullable))completion;
+ (void)fetchImageForCard: (HAJCard *)card completion: (void(^) (UIImage * _Nullable))completion;
+ (void)getDeckID: (NSString *)url completion: (void(^) (NSString * _Nullable))completion;
+ (void)shuffleDeck: (NSString *)deckID;

@property (nonatomic, readwrite, copy) NSString *deckID;

@end

NS_ASSUME_NONNULL_END
