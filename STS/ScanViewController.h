//
//  ViewController.h
//  inigmaSDKDemo
//
//  Created by 1 1 on 4/1/12.
//  Copyright (c) 2012 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UIButton *ScanButton;
    IBOutlet UIButton *StopButton;
    IBOutlet UIButton *CloseButton;
    IBOutlet UILabel *Label;
	IBOutlet UILabel *LabelDecode;
    IBOutlet UILabel *LabelNoti;
    IBOutlet UILabel *LabelType;
	IBOutlet UIButton *UpdateButton;
	IBOutlet UIButton *TorchButton;
	void* m_pScanner;
    int m_bTorch;
}
-(void) initLocal;
-(void) onError: (const char*) str;
-(void) onNotify: (const char*) str;
-(void) onDecode: (const unsigned short*) str:(const char*) strType:(const char*) strMode;
-(void) OnCameraStopOrStart:(int) on;
- (IBAction)UdateLicPressed;
- (IBAction)StopPressed;
- (IBAction)ClosePressed;
- (IBAction)TorchPressed;
- (void) OnForground;
- (void) OnBackground;

@end

