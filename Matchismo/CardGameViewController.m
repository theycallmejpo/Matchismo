//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Juan Posadas on 9/27/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()

@property (strong, nonatomic) Deck *playingDeck;
@property (weak, nonatomic) IBOutlet UILabel *matchingsLabel;

@end

@implementation CardGameViewController

- (NSString *)firstLabel
{
    return @"Flip a Card!";
}


- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

/* Initialization of deck of playing cards */
- (Deck *)playingDeck
{
    if (!_playingDeck) _playingDeck = [self createDeck];
    return _playingDeck;
}


- (Deck *)createDeck
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {} //handled in subclasses


/* The Decision to use the controller was because we want to 'control the
    the data and structures we have set up in our model. Nonetheless, we 
    still needed to add some extra features in the model to be able to use
    them in our controller. I make the controller communicate with the model
    and the view independently, keeping the MVC safe.*/

- (void)updateMatchingsLabel
{
    NSMutableArray *currentCards = self.game.flippedCards;
    NSAttributedString *labelText = [self generateAttributedStringFromArray:currentCards indecesArray:self.game.flippedCardsIndeces matchScore:self.game.matchScore];
    
    self.matchingsLabel.attributedText = labelText;

    
}

- (NSAttributedString *)generateAttributedStringFromArray:(NSMutableArray *)cards indecesArray:(NSMutableArray *)indeces matchScore:(NSUInteger)score
{
    return nil;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [self setTitleAndBackgroundForCardButton:cardButton UsingCard:card];
        
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (void)setTitleAndBackgroundForCardButton:(UIButton *)cardButton UsingCard:(Card *)card {}

- (NSString *)titleForCard:(Card *)card
{
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return nil;
}

/* Restart Game function */

- (IBAction)restartGame {
    self.game = nil;
    [self updateUI];
    [self setMatchMode];
    self.matchingsLabel.text = self.firstLabel;
}

- (void)setMatchMode {}


@end
