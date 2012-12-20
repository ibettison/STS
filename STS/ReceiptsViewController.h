//
//  ReceiptsViewController.h
//  STS
//
//  Created by Ian Bettison on 19/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptsViewController : UIViewController {
	void* m_pScanner;
    int m_bTorch;
}
-(void) initLocal;
-(void) onError: (const char*) str;
-(void) onNotify: (const char*) str;
-(void) onDecode: (const unsigned short*) str: (const char*) strType: (const char*) strMode;
-(void) OnCameraStopOrStart:(int) on;
-(void)PlaySound:(NSString *)resourceName withFileExtension: (NSString *)extName;
- (IBAction)ScanReceiptButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *ScanReceivedSample;
- (IBAction)ContainerButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *ScanContainer;
@property (strong, nonatomic) NSString *fieldCaller;
@end