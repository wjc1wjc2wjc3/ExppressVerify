//
//  Config.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#ifndef Config_h
#define Config_h

#define ARGB(a,b,c,al) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:(al)]
#define RGB(a,b,c) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:1.0]

#define MainColor RGB(58, 93, 193)

#define iPhoneX_Bang_Height 50

#ifdef DEBUG
#define DLog( s, ... ) NSLog( @" %@",[NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#endif /* Config_h */
