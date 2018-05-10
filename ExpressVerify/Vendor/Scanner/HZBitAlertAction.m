//
//  HZBitAlertAction.m
//  HZBitApp
//
//  Created by Apple on 9/5/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZBitAlertAction.h"
#import "UIAlertView+Express.h"
#import "UIActionSheet+Express.h"
#import "UIWindow+Express.h"


@implementation HZBitAlertAction

+ (BOOL)isIosVersion8AndAfter
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ;
}

+ (void)showAlertWithTitle:(NSString*)title msg:(NSString*)message buttonsStatement:(NSArray<NSString*>*)arrayItems chooseBlock:(void (^)(NSInteger buttonIdx))block
{
    
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithArray:arrayItems];
    
    
    if ( [HZBitAlertAction isIosVersion8AndAfter])
    {
        //UIAlertController style
        
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (int i = 0; i < [argsArray count]; i++)
        {
            UIAlertActionStyle style =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
            // Create the actions.
            UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
                if (block) {
                    block(i);
                }
            }];
            [alertController addAction:action];
        }
        
        [[HZBitAlertAction getTopViewController] presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:argsArray[0] otherButtonTitles:nil, nil];
#pragma clang diagnostic pop
    [argsArray removeObject:argsArray[0]];
    for (NSString *buttonTitle in argsArray) {
        
        DLog(@"buttonTitle:%@",buttonTitle);
        [alertView addButtonWithTitle:buttonTitle];
    }
    
    [alertView showWithBlock:^(NSInteger buttonIdx)
     {
         
         block(buttonIdx);
     }];
}


+ (UIViewController*)getTopViewController
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    return window.currentViewController;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+ (void)showActionSheetWithTitle:(NSString*)title
message:(NSString*)message
cancelButtonTitle:(NSString*)cancelString
destructiveButtonTitle:(NSString*)destructiveButtonTitle
otherButtonTitle:(NSArray<NSString*>*)otherButtonArray
chooseBlock:(void (^)(NSInteger buttonIdx))block
{
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    
    if (cancelString) {
        [argsArray addObject:cancelString];
    }
    if (destructiveButtonTitle) {
        [argsArray addObject:destructiveButtonTitle];
    }
    
    [argsArray addObjectsFromArray:otherButtonArray];
    
    if ( [HZBitAlertAction isIosVersion8AndAfter])
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (int i = 0; i < [argsArray count]; i++)
        {
            UIAlertActionStyle style =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
            
            if (1==i && destructiveButtonTitle) {
                
                style = UIAlertActionStyleDestructive;
            }
            
            // Create the actions.
            UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
                if (block) {
                    block(i);
                }
            }];
            [alertController addAction:action];
        }
        
        [[HZBitAlertAction getTopViewController] presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    //UIActionSheet
    UIView *view = [self getTopViewController].view;
    UIActionSheet *sheet = nil;
    
    NSInteger count = argsArray.count;
    
    if (cancelString) {
        [argsArray removeObject:cancelString];
    }
    if (destructiveButtonTitle) {
        [argsArray removeObject:destructiveButtonTitle];
    }
    if (argsArray.count == 0)
    {
        sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil, nil];
    }
    
    switch (argsArray.count) {
        case 0:
            sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil, nil];
            break;
            
        case 1:
            sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:argsArray[0], nil];
            break;
            
        case 2:
            sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:argsArray[0],argsArray[1], nil];
            break;
        case 3:
            sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:argsArray[0],argsArray[1],argsArray[2], nil];
            break;
            
        case 4:
            sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:argsArray[0],argsArray[1],argsArray[2],argsArray[3], nil];
            break;
            
        case 5:
            sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:argsArray[0],argsArray[1],argsArray[2],argsArray[3],argsArray[4], nil];
            break;
            
        case 6:
            sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:argsArray[0],argsArray[1],argsArray[2],argsArray[3],argsArray[4],argsArray[5], nil];
            break;
            
        case 7:
            sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:argsArray[0],argsArray[1],argsArray[2],argsArray[3],argsArray[4],argsArray[5],argsArray[6], nil];
            break;
            
        case 8:
            sheet =  [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:argsArray[0],argsArray[1],argsArray[2],argsArray[3],argsArray[4],argsArray[5],argsArray[6],argsArray[7], nil];
            break;
            
        default:
            break;
    }
    
    [sheet showInView:view block:^(NSInteger buttonIdx,NSString* buttonTitle)
     {
         NSInteger idx = buttonIdx;
         
         if (idx == count -1) {
             idx = 0;
         }
         else
         {
             ++idx;
         }
         
         if (block) {
             block(idx);
         }
     }];
    
    
}
#pragma clang diagnostic pop



@end
