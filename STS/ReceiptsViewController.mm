//
//  ReceiptsViewController.m
//  STS
//
//  Created by Ian Bettison on 19/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "ReceiptsViewController.h"
#import "Scanner.h"

void WrapError(void* pThis,const char* str)
{
	ReceiptsViewController* p = (ReceiptsViewController*)pThis;
	[p onError:str];
	
}
void WrapNotify(void* pThis,const char* str)
{
	ReceiptsViewController* p = (ReceiptsViewController*)pThis;
	[p onNotify:str];
	
}
void WrapDecode(void* pThis,const unsigned short* str,const char* SymbolType,const char* SymbolMode)
{
	ReceiptsViewController* p = (ReceiptsViewController*)pThis;
    
	[p onDecode:str:SymbolType:SymbolMode];
}
void WrapCameraStopOrStart(int on,void* pThis)
{
	ReceiptsViewController* p = (ReceiptsViewController*)pThis;
	[p OnCameraStopOrStart:on];
    if (on)
    {
        [p onError:""];
        [p onNotify:""];
    }
}

@interface ReceiptsViewController ()
    
@end

@implementation ReceiptsViewController


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [self setScanContainer:nil];
    ((CScanner*)m_pScanner)->CloseCamera();
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        //ScanClass *initScan = [[ScanClass alloc] init];
        [self initLocal];
        //[initScan autorelease];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    [super initWithCoder:coder];
	[self initLocal];	
	return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait
       || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown){
        yValue = yPos - 160;
    }else{
        yValue = yPos;
    }
    StopButton.frame = CGRectMake(500,yValue,30,30);
    NSLog(@"%d, yValue = %d",[[UIDevice currentDevice] orientation], yValue);
    if (m_pScanner){
        ((CScanner*)m_pScanner)->SetOrientation(toInterfaceOrientation);
    }
}

/*
 If you were to create the view programmatically, you would use initWithFrame:.
 You want to make sure the placard view is set up in this case as well (as in initWithCoder:).
 */

- (void)dealloc {
    if (m_pScanner){
        delete ((CScanner*)m_pScanner);
    }
    [super dealloc];
}

int yPos = 320;
int yValue = yPos;

-(void) initLocal
{
	m_pScanner = new CScanner(self);
	StopButton = NULL;
	CloseButton = NULL;
    m_bTorch = 0;
}
-(void) onError: (const char*) str
{
    
}
-(void) onNotify: (const char*) str
{
    
}
-(void) onDecode: (const unsigned short*) str: (const char*) strType: (const char*) strMode{
    ScanClass *sound = [[ScanClass alloc] init];
    
    [sound PlaySound:@"beep" withFileExtension:@"mp3"];
    [sound autorelease];
    NSString *strLocal;
	strLocal = [NSString stringWithFormat:@"%S" , str];
    
    if([self.fieldCaller isEqualToString:@"ScanReceipt"]){
        [_ScanReceivedSample setText:strLocal];
    }else{
        [_ScanContainer setText:strLocal];
    }
}
-(void) OnCameraStopOrStart:(int) on
{
  	if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait
       || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown){
        yValue = yPos - 160;
    }else{
        yValue = yPos;
    }
    if (on == 1){
		if (StopButton)
		{
			StopButton.hidden = NO;
            StopButton.frame = CGRectMake(500,yValue,30,30);
			[StopButton setNeedsLayout];
        }else{
			StopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[StopButton addTarget:self action:@selector(StopPressed) forControlEvents:UIControlEventTouchUpInside];
            [StopButton setBackgroundImage:[UIImage imageNamed:@"Close.png"] forState:UIControlStateNormal];
            StopButton.frame = CGRectMake(500,yValue,30,30);
			[self.view addSubview:StopButton];
		}
    }
	if (on == 0){
		StopButton.hidden=YES;
		[StopButton setNeedsLayout];
	}
}

- (IBAction)StopPressed
{
	
	((CScanner*)m_pScanner)->Abort();
    StopButton = NULL;
}


- (IBAction)ScanReceiptButtonPressed:(id)sender{
    self.fieldCaller = [NSString stringWithFormat:@"ScanReceipt"];
    NSLog(@"%@ %@", self.fieldCaller, @"ScanReceipt");
    ScanClass *sound = [[ScanClass alloc] init];
    [sound PlaySound:@"click" withFileExtension:@"wav"];
    [sound autorelease];
    ((CScanner*)m_pScanner)->Scan(self.view,30,30,520,920);
    ((CScanner*)m_pScanner)->SetOrientation([ScanClass FindOrientation]);
}

- (IBAction)ContainerButtonPressed:(id)sender {
    self.fieldCaller = [NSString stringWithFormat:@"ScanContainer"];
    NSLog(@"%@ %@", self.fieldCaller, @"ScanContainer");
    ScanClass *sound = [[ScanClass alloc] init];
    [sound PlaySound:@"click" withFileExtension:@"wav"];
    [sound autorelease];
    ((CScanner*)m_pScanner)->Scan(self.view,30,30,520,920);
    ((CScanner*)m_pScanner)->SetOrientation([ScanClass FindOrientation]);
}

@end
