//
//  ViewController.h
//  CCFrameworkTestApp
//
//  Created by Rodrigo Curiel on 3/17/15.
//  Copyright (c) 2015 Rodrigo Curiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
enum {
  LEVEL_NONE = -1,
  LEVEL_ERROR = 0,
  LEVEL_WARNING = 1,
  LEVEL_INFO = 2,
  LEVEL_TRACE = 3,
  LEVEL_DEBUG = 4
};
@property (weak, nonatomic) IBOutlet UITextView *txtLog;

@end
