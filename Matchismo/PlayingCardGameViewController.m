//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Juan Posadas on 10/9/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateMatchingsLabel];
    [self updateUI];
}

- (void)setTitleAndBackgroundForCardButton:(UIButton *)cardButton UsingCard:(Card *)card
{
    [cardButton setTitle:[self titleForCard:card]
                forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (void) setMatchMode
{
    self.game.gameMode = 2;
}

- (NSAttributedString *)generateAttributedStringFromArray:(NSMutableArray *)cards indecesArray:(NSMutableArray *)indeces matchScore:(NSUInteger)score
{
    NSString *resultString;
    
    
    NSMutableArray *cardsContents = [[NSMutableArray alloc] init];
    
    for (PlayingCard *card in cards) {
        [cardsContents addObject:card.contents];
    }
    
    if (self.game.justMatched) {
        resultString = [NSString stringWithFormat:@"Matched %@ for %d points", [cardsContents componentsJoinedByString:@" "], self.game.matchScore];
    } else if (self.game.justMismatched) {
        resultString = [NSString stringWithFormat:@"%@ don't match! %d point penalty", [cardsContents componentsJoinedByString:@" "], self.game.matchScore];
    } else {
        if ([cardsContents count] == 0) {
            resultString = self.firstLabel;
        } else if ([cardsContents count] < self.game.gameMode) {
            resultString = [NSString stringWithFormat:@"Flipped %@", [cardsContents componentsJoinedByString:@" "]];
        }
    }
    
    return [[NSAttributedString alloc] initWithString:resultString];
}


@end
