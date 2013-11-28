//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Juan Posadas on 10/13/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scoreLabel.text = @"View was loaded";
    [self setMatchMode];
    [self updateUI];
    
}

- (void)setTitleAndBackgroundForCardButton:(UIButton *)cardButton UsingCard:(Card *)card
{
    [cardButton setAttributedTitle:[self attributedTitleForCard:card]
                forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
}

- (NSMutableAttributedString *)attributedTitleForCard:(Card *)card
{
    SetCard *setCard = (SetCard *)card;
    NSMutableString *initialString = [[NSMutableString alloc] init];
    
    for (NSUInteger i = 1; i <= setCard.number; i++) {
        [initialString appendString:setCard.symbol];
    }
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:initialString];
    
    [title addAttribute:NSForegroundColorAttributeName
                  value:[self returnColorWithIndex:setCard.color - 1 AndAlpha:setCard.shading - 1]
                  range:NSMakeRange(0, [title length])];
    [title addAttributes:@{ NSStrokeWidthAttributeName : @-3,
                            NSStrokeColorAttributeName : [self listOfColors][setCard.color - 1] }
                   range:NSMakeRange(0, [title length])];
    
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    UIImage *image = [UIImage imageNamed:card.isChosen ? @"setcardchosen" : @"cardfront"];

    return image;
}

- (UIColor *)returnColorWithIndex:(NSUInteger)colorIndex AndAlpha:(NSUInteger)alphaIndex
{
    UIColor *result = [self listOfColors][colorIndex];
    NSNumber *alpha = [self listOfAlphaValues][alphaIndex];
    result = [result colorWithAlphaComponent:[alpha floatValue]];
    return result;
}

- (NSArray *)listOfColors
{
    return @[[UIColor redColor],[UIColor greenColor], [UIColor purpleColor]];
}

- (NSArray *)listOfAlphaValues
{
    return @[@0.0, @0.3, @1.0];
}

- (void)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateMatchingsLabel];
    [self updateUI];
}

- (void) setMatchMode
{
    self.game.gameMode = 3;
}

- (NSAttributedString *)generateAttributedStringFromArray:(NSMutableArray *)cards indecesArray:(NSMutableArray *)indeces matchScore:(NSUInteger)score
{
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *cardStrings = [self generateCardStringsUsingIndeces:indeces];
    
    
    if (self.game.justMatched) {
        
        [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Matched "]];
        [resultString appendAttributedString:cardStrings];
        [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %d points", score]]];
                                              
    } else if (self.game.justMismatched) {
        
        [resultString appendAttributedString:cardStrings];
        [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"don't match! -%d points", score]]];
        
    } else {
        
        if ([cards count] == 0) {
            
            [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:self.firstLabel]];
            
        } else if ([cards count] < self.game.gameMode) {
            
            [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Flipped "]];
            [resultString appendAttributedString:cardStrings];
            
        }
    }
    
    return resultString;
    
}

- (NSMutableAttributedString *)generateCardStringsUsingIndeces: (NSMutableArray *)indeces
{
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    for (NSNumber *index in indeces) {
        UIButton *button = [self.cardButtons objectAtIndex:[index integerValue]];
        [result appendAttributedString:[button attributedTitleForState:UIControlStateNormal]];
        [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
    }
    
    return result;
}


@end
