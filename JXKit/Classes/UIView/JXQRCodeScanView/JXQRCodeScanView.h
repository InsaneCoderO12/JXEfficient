//
//  JXQRCodeScannerView.h
//  二维码扫描
//
//  Created by augsun on 12/2/16.
//  Copyright © 2016 codersun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface JXQRCodeScanView : UIView

@property (nonatomic, readonly) AVAuthorizationStatus status;

@property (nonatomic, copy) void (^didOutputStringValue)(NSString *stringValue);

- (BOOL)configScannerWithMetadataObjectTypes:(NSArray *)metadataObjectTypes;

- (void)startRunning;

- (void)stopRunning;

@end
