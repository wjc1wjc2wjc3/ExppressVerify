//
//  Macro.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#ifndef Macro_h
#define Macro_h

#define LOCALIZEDSTRING(str) NSLocalizedString(str, "")

#define NAVIBAR_BLUE RGB(40, 146, 227)
#define NAVIGATIONBAR_HEIGHT 50

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define ExpressWeakSelf()        __weak typeof (self) weakSelf = self

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#endif /* Macro_h */
