//
//  ViewController.m
//  inigmaSDKDemo
//
//  Created by 1 1 on 4/1/12.
//  Copyright (c) 2012 1. All rights reserved.
//

#import "ViewController.h"
#import "Scanner.h"


void WrapError(void* pThis,const char* str)
{
	ViewController* p = (ViewController*)pThis;
	[p onError:str];
	
}
void WrapNotify(void* pThis,const char* str)
{
	ViewController* p = (ViewController*)pThis;
	[p onNotify:str];
	
}
void WrapDecode(void* pThis,const unsigned short* str,const char* SymbolType,const char* SymbolMode)
{
	ViewController* p = (ViewController*)pThis;
    
	[p onDecode:str:SymbolType:SymbolMode];
}
void WrapCameraStopOrStart(int on,void* pThis)
{
	ViewController* p = (ViewController*)pThis;
	[p OnCameraStopOrStart:on];	
    if (on)
    {
        [p onError:""];
        [p onNotify:""];
    }
}


@interface ViewController ()

@end

@implementation ViewController



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [self initLocal];
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
    if (m_pScanner){
        ((CScanner*)m_pScanner)->SetOrientation(toInterfaceOrientation);
    }
}
    
/*
 If you were to create the view programmatically, you would use initWithFrame:.
 You want to make sure the placard view is set up in this case as well (as in initWithCoder:).
 */
-(void) initLocal
{
	m_pScanner = new CScanner(self);
	StopButton = NULL;
	CloseButton = NULL;
    m_bTorch = 0;
}
- (void)dealloc {
    if (m_pScanner){
        delete ((CScanner*)m_pScanner);
    }
    
	[super dealloc];	
	
}

- (IBAction)ScanPressed {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        ((CScanner*)m_pScanner)->Scan(self.view,30,30,720,920);
    }else{
        ((CScanner*)m_pScanner)->Scan(self.view,5,5,310,400);
    }
}
- (IBAction)UdateLicPressed
{
	
	((CScanner*)m_pScanner)->UpdateLicense();
	
}
- (IBAction)StopPressed
{
	
	((CScanner*)m_pScanner)->Abort();
}
- (IBAction)ClosePressed
{
	
	((CScanner*)m_pScanner)->CloseCamera();
	StopButton = NULL;
}
- (IBAction)TorchPressed
{
	if (m_bTorch == 0){
        m_bTorch = 1;
        ((CScanner*)m_pScanner)->TurnTorch(1);
    }else{
        m_bTorch = 0;
        ((CScanner*)m_pScanner)->TurnTorch(0);
        
    }
}


-(void) onError: (const char*) str
{
	NSString *strLocal;
	strLocal = [NSString stringWithFormat:@"%s" , str];
	[Label setText:strLocal];
	[Label layoutIfNeeded];
}
-(void) onNotify: (const char*) str
{
	NSString *strLocal;
	strLocal = [NSString stringWithFormat:@"%s" , str];
	[LabelNoti setText:strLocal];
	[LabelNoti layoutIfNeeded];
}
-(void) onDecode: (const unsigned short*) str: (const char*) strType: (const char*) strMode

{
	NSString *strLocal;
	strLocal = [NSString stringWithFormat:@"%S" , str];
	[LabelDecode setText:strLocal];
	[LabelDecode layoutIfNeeded];
    
    NSString *strLocalT;
    if (strMode==0)
        strLocalT = [NSString stringWithFormat:@"%s" , strType];
    else
        strLocalT = [NSString stringWithFormat:@"%s (%s)" , strType, strMode];
	[LabelType setText:strLocalT];
	[LabelType layoutIfNeeded];
    
}
-(void) OnCameraStopOrStart:(int) on  
{
	if (on == 1){
        if (((CScanner*)m_pScanner)->IsTorchAvailable()){
            TorchButton.hidden = NO;
            [TorchButton setNeedsDisplay];
        }
		if (StopButton)
		{
			StopButton.hidden = NO;
			[StopButton setNeedsLayout];
			CloseButton.hidden = NO;
			[CloseButton setNeedsLayout];
        }else{
			StopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[StopButton addTarget:self action:@selector(StopPressed) forControlEvents:UIControlEventTouchUpInside];
			[StopButton setTitle:@"Abort" forState:UIControlStateNormal];
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                StopButton.frame = CGRectMake(200,860,160,70);
            }else{
                StopButton.frame = CGRectMake(30,340,115,50);
            }
			[self.view addSubview:StopButton];
			CloseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[CloseButton addTarget:self action:@selector(ClosePressed) forControlEvents:UIControlEventTouchUpInside];
			[CloseButton setTitle:@"Close" forState:UIControlStateNormal];
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                CloseButton.frame = CGRectMake(460,860,160,70);
            }else {
                CloseButton.frame = CGRectMake(175,340,115,50);
            }
			[self.view addSubview:CloseButton];
		}
    }
	if (on == 0){
		StopButton.hidden=YES;
		[StopButton setNeedsLayout];
		CloseButton.hidden=YES;
		[CloseButton setNeedsLayout];
        TorchButton.hidden = YES;
        [TorchButton setNeedsDisplay];
        
		
	}
}

- (void)OnBackground {
    ((CScanner*)m_pScanner)->OnBackground();
}

- (void)OnForground {
    ((CScanner*)m_pScanner)->OnForground();
}
@end
