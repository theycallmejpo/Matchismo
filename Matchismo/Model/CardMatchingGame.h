//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Juan Posadas on 9/30/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger matchScore;

@property (nonatomic) NSInteger gameMode;

@property (nonatomic) BOOL justMatched;
@property (nonatomic) BOOL justMismatched;
@property (nonatomic, strong) NSMutableArray *flippedCards;
@property (nonatomic, strong) NSMutableArray *flippedCardsIndeces;

@end
