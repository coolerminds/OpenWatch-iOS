//
//  OWLocalRecording.h
//  OpenWatch
//
//  Created by Christopher Ballinger on 12/3/12.
//  Copyright (c) 2012 OpenWatch FPC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OWManagedRecording.h"
#import "OWRecordingSegment.h"
#import "OWLocationController.h"

@interface OWLocalRecording : OWManagedRecording <OWLocationControlerDelegate>

@property (nonatomic, retain) NSString * localRecordingPath;
@property (nonatomic, retain) NSNumber * hqFileUploadState;
@property (nonatomic, retain) NSSet *segments;


+ (OWLocalRecording*) recordingWithPath:(NSString*)path;
- (void) setUploadState:(OWFileUploadState)uploadState forFileAtURL:(NSURL*)url;
- (OWFileUploadState)uploadStateForFileAtURL:(NSURL*)url;

- (NSArray*) failedFileUploadURLs;
- (NSUInteger) failedFileCount;
- (NSUInteger) completedFileCount;
- (NSUInteger) totalFileCount;
- (BOOL) isHighQualityFileUploaded;

- (void) saveMetadata;

- (void) startRecording;
- (void) stopRecording;

- (NSDictionary*) dictionaryRepresentation;

- (NSURL*) urlForNextSegment;
- (NSURL*) highQualityURL;

@end

@interface OWLocalRecording (CoreDataGeneratedAccessors)

- (void)addSegmentsObject:(OWRecordingSegment *)value;
- (void)removeSegmentsObject:(OWRecordingSegment *)value;
- (void)addSegments:(NSSet *)values;
- (void)removeSegments:(NSSet *)values;

@end