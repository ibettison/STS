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
    m_bTorch = 0;
}
- (void)dealloc {
    if (m_pScanner){
        delete ((CScanner*)m_pScanner);
    }
    
    [_ScanContainer release];
	[super dealloc];
	
}

-(void)PlaySound:(NSString *)resourceName withFileExtension: (NSString *)extName {
    NSURL *musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:[NSString stringWithFormat:@"%@",resourceName]
                                               ofType:[NSString stringWithFormat:@"%@", extName]]];
    NSError *error;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:&error];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer play]; //will need to release this memory after showing the server information
    
}-(void) onError: (const char*) str
{
    
}
-(void) onNotify: (const char*) str
{
    
}
-(void) onDecode: (const unsigned short*) str: (const char*) strType: (const char*) strMode{
    [self PlaySound:@"beep" withFileExtension:@"mp3"];
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
    
}
- (IBAction)ScanReceiptButtonPressed:(id)sender{
    self.fieldCaller = [NSString stringWithFormat:@"ScanReceipt"];
    NSLog(@"%@ %@", self.fieldCaller, @"ScanReceipt");
    [self PlaySound:@"click" withFileExtension:@"wav"];
    ((CScanner*)m_pScanner)->Scan(self.view,30,30,520,920);
}

- (IBAction)ContainerButtonPressed:(id)sender {
    self.fieldCaller = [NSString stringWithFormat:@"ScanContainer"];
    NSLog(@"%@ %@", self.fieldCaller, @"ScanContainer");
    [self PlaySound:@"click" withFileExtension:@"wav"];
    ((CScanner*)m_pScanner)->Scan(self.view,30,30,520,920);
}
@end
