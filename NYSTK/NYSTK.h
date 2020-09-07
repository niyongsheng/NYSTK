//
//  NYSTK.h
//  NYSTK <https://github.com/niyongsheng/NYSTK>
//
//  Created by 倪永胜 on 2020/9/3.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<NYSTK/NYSTK.h>)

FOUNDATION_EXPORT double NYSTKVersionNumber;
FOUNDATION_EXPORT const unsigned char NYSTKVersionString[];

#import <NYSTK/NYSTKConst.h>
#import <NYSTK/NYSTKConfig.h>
#import <NYSTK/NYSTKEmitterUtil.h>

#import <NYSTK/NYSTKAlert.h>

#else

#import "NYSTKConst.h"
#import "NYSTKConfig.h"
#import "NYSTKEmitterUtil.h"

#import "NYSTKAlert.h"


#endif
