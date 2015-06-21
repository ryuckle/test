//
//  ArticleTableViewCell.h
//  NewsAppSample
//
//  Created by jun on 2014/12/18.
//  Copyright (c) 2014年 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

@end
