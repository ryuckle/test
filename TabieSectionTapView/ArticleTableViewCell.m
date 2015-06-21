//
//  ArticleTableViewCell.m
//  NewsAppSample
//
//  Created by jun on 2014/12/18.
//  Copyright (c) 2014年 edu.self. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
//        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
//        self.descriptionLabel.textColor = [UIColor blackColor];
//        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
//        
//        [self addSubview:self.descriptionLabel];
    }
    return self;
}

@end
