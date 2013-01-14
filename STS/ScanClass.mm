//
//  ScanClass.m
//  STS
//
//  Created by Ian Bettison on 19/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import "ScanClass.h"
#import "Scanner.h"



@interface ScanClass ()

@end

@implementation ScanClass



-(void)PlaySound:(NSString *)resourceName withFileExtension: (NSString *)extName {
    NSURL *musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:[NSString stringWithFormat:@"%@",resourceName]
                                               ofType:[NSString stringWithFormat:@"%@", extName]]];
    NSError *error;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:&error];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer play]; //will need to release this memory after showing the server information
}

+(int)FindOrientation {
    
    return [[UIDevice currentDevice] orientation];
}
@end
