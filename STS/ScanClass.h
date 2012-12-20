//
//  ScanClass.h
//  STS
//
//  Created by Ian Bettison on 19/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scanner.h"

@interface ScanClass : UIViewController{

void* m_pScanner;
int m_bTorch;
}
+(void) onError: (const char*) str;
+(void) onNotify: (const char*) str;
+(void) onDecode: (const unsigned short*) str:(const char*) strType:(const char*) strMode;
+(void) OnCameraStopOrStart:(int) on;
@end
