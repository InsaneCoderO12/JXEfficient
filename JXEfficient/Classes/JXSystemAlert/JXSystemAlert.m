//
//  JXSystemAlert.m
//  JXEfficient
//
//  Created by augsun on 8/27/16.
//  Copyright © 2016 CoderSun. All rights reserved.
//

#import "JXSystemAlert.h"

@implementation JXSystemAlert

// ====================================================================================================
#pragma mark - UIAlertControllerStyleAlert

+ (void)jx_alertFromVC:(UIViewController *)viewController
            alertTitle:(NSString *)alertTitle
          alertMessage:(NSString *)alertMessage
         defaultTtitle:(NSString *)defaultTtitle
        defaultHandler:(void (^)(void))defaultHandler {
    
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionDefault = [UIAlertAction actionWithTitle:defaultTtitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !defaultHandler ? : defaultHandler();
    }];
    [alertCtl addAction:actionDefault];
    [viewController presentViewController:alertCtl animated:YES completion:nil];
}

+ (void)jx_alertFromVC:(UIViewController *)viewController
            alertTitle:(NSString *)alertTitle
           cancelTitle:(NSString *)cancelTitle
      destructiveTitle:(NSString *)destructiveTitle
         cancelHandler:(void (^)(void))cancelHandler
    destructiveHandler:(void (^)(void))destructiveHandler {
    
    [self jx_alertFromVC:viewController alertTitle:alertTitle alertMessage:nil cancelTitle:cancelTitle destructiveTitle:destructiveTitle cancelHandler:cancelHandler destructiveHandler:destructiveHandler];
}

+ (void)jx_alertFromVC:(UIViewController *)viewController
            alertTitle:(NSString *)alertTitle
          alertMessage:(NSString *)alertMessage
           cancelTitle:(NSString *)cancelTitle
      destructiveTitle:(NSString *)destructiveTitle
         cancelHandler:(void (^)(void))cancelHandler
    destructiveHandler:(void (^)(void))destructiveHandler {
    
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        !cancelHandler ? : cancelHandler();
    }];
    UIAlertAction *actionDestructive = [UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        !destructiveHandler ? : destructiveHandler();
    }];
    [alertCtl addAction:actionCancel];
    [alertCtl addAction:actionDestructive];
    [viewController presentViewController:alertCtl animated:YES completion:nil];
}

+ (void)jx_alertFromVC:(UIViewController *)viewController
            alertTitle:(NSString *)alertTitle
          alertMessage:(NSString *)alertMessage
     defaultTtitleLeft:(NSString *)defaultTtitleLeft
    defaultTtitleRight:(NSString *)defaultTtitleRight
           leftHandler:(void (^)(void))leftHandler
          rightHandler:(void (^)(void))rightHandler {
    
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionLeft = [UIAlertAction actionWithTitle:defaultTtitleLeft style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !leftHandler ? : leftHandler();
    }];
    UIAlertAction *actionRight = [UIAlertAction actionWithTitle:defaultTtitleRight style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !rightHandler ? : rightHandler();
    }];
    [alertCtl addAction:actionLeft];
    [alertCtl addAction:actionRight];
    [viewController presentViewController:alertCtl animated:YES completion:nil];
}

// ====================================================================================================
#pragma mark - UIAlertControllerStyleActionSheet

+ (void)jx_sheetFromVC:(UIViewController *)viewController
         default0Title:(NSString *)title0
         default1Title:(NSString *)title1
                cancel:(NSString *)cancelTitle
      default0Callback:(void (^)(void))default0Callback
      default1Callback:(void (^)(void))default1Callback
        cancelCallback:(void (^)(void))cancelCallback {
    
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:title0 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !default0Callback ? : default0Callback();
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !default1Callback ? : default1Callback();
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    
    [alertCtl addAction:action0];
    [alertCtl addAction:action1];
    [alertCtl addAction:actionCancel];
    [viewController presentViewController:alertCtl animated:YES completion:nil];
}

@end





























