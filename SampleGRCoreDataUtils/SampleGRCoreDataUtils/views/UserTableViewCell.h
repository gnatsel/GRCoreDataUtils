//
//  PresenterTableViewCell.h
//  SampleGRCoreDataUtils
//
//  Created by Olivier Lestang [DAN-PARIS] on 28/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPresenter.h"

@interface UserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UserPresenter *userPresenter;

@end
