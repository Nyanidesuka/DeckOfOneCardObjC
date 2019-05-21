//
//  HAJCardController.m
//  DeckOfOneCard
//
//  Created by Haley Jones on 5/21/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

#import "HAJCardController.h"
#import <UIKit/UIKit.h>

@implementation HAJCardController

+ (void)getDeckID:(NSString *)url completion:(void (^)(NSString * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:url];
    [[[NSURLSession sharedSession]dataTaskWithURL:baseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"%@", [error localizedDescription]);
            completion(nil);
            return;
        }
        if (data){
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSString *deckID = jsonDict[@"deck_id"];
            NSLog(@"%@", deckID);
            completion(deckID);
            return;
        }
        NSLog(@"There was an error decoding the data. %@", error.localizedDescription);
        completion(nil);
    }]resume];
}

+ (void)fetchCardFromDeck:(NSString *)deck completion:(void (^)(HAJCard * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:@"https://deckofcardsapi.com/api/deck/"];
    NSURL *intermURL = [[baseURL URLByAppendingPathComponent:deck]URLByAppendingPathComponent:@"draw"];
    NSURLQueryItem *drawQuery = [NSURLQueryItem queryItemWithName:@"draw" value:@"1"];
    NSURLComponents *components = [NSURLComponents componentsWithURL:intermURL resolvingAgainstBaseURL:false];
    components.queryItems = @[drawQuery];
    NSURL *finalURL = components.URL;
    NSLog(@"%@", finalURL.absoluteString);
    
    //get the actual card now
    [[[NSURLSession sharedSession]dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (data){
            NSDictionary *jsondict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            HAJCard *newCard = [[HAJCard alloc]initFromDictionary:jsondict];
            NSInteger remainingCard = [jsondict[@"remaining"]integerValue];
            if (remainingCard == 0){
                [HAJCardController shuffleDeck:deck];
            }
            NSLog(@"Remaining Cards: %@", jsondict[@"remaining"]);
            completion(newCard);
            return;
        }
        NSLog(@"No data was fetched.%@", [error localizedDescription]);
        completion(nil);
    }]resume];
}

+ (void)fetchImageForCard:(HAJCard *)card completion:(void (^)(UIImage * _Nullable))completion
{
    //ok first, url
    NSURL *imageURL = [NSURL URLWithString:card.imageLink];
    //then its really just go do the thing
    [[[NSURLSession sharedSession]dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (data){
            UIImage *cardImage = [UIImage imageWithData:data];
            completion(cardImage);
            return;
        }
        NSLog(@"There was an error decoding the data.%@", [error localizedDescription]);
    }]resume];
}

+ (void)shuffleDeck:(NSString *)deckID
{
    //all this has to do is shuffle the cards
    NSURL *shuffleURL = [NSURL URLWithString:@"https://deckofcardsapi.com/api/deck/"];
    NSURL *urlWithID = [shuffleURL URLByAppendingPathComponent:deckID];
    NSURL *finalURL = [urlWithID URLByAppendingPathComponent:@"shuffle"];
    [[[NSURLSession sharedSession]dataTaskWithURL:finalURL]resume];
}

@end
