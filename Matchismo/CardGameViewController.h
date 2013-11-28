//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Juan Posadas on 9/27/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSString *firstLabel;

// abstract classes
- (Deck *)createDeck;
- (IBAction)touchCardButton:(UIButton *)sender;
- (void)updateMatchingsLabel;
- (void)updateUI;
- (void)setTitleAndBackgroundForCardButton:(UIButton *)cardButton UsingCard:(Card *)card;
- (NSString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (void)setMatchMode;
- (NSAttributedString *)generateAttributedStringFromArray:(NSMutableArray *)cards indecesArray:(NSMutableArray *)indeces matchScore:(NSUInteger)score;

@end
