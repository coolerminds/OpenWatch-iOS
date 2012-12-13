//
//  OWFeedSelectionViewController.m
//  OpenWatch
//
//  Created by Christopher Ballinger on 12/13/12.
//  Copyright (c) 2012 OpenWatch FPC. All rights reserved.
//

#import "OWFeedSelectionViewController.h"
#import "OWStrings.h"
#import "OWUtilities.h"

@interface OWFeedSelectionViewController ()
@end

#define FEED_SECTION 0
#define TAG_SECTION 1

@implementation OWFeedSelectionViewController
@synthesize tagNames, feedNames, selectionTableView, delegate, popOver, popoverSize;

- (id)init
{
    self = [super init];
    if (self) {
        self.feedNames = @[@"Top", @"Local"];
        self.tagNames = @[@"awesome", @"apple"];
        self.popoverSize = CGSizeMake(200, 300);
        self.selectionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, popoverSize.width, popoverSize.height) style:UITableViewStylePlain];
        //self.selectionTableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:selectionTableView];
        self.selectionTableView.dataSource = self;
        self.selectionTableView.delegate = self;
        self.popOver = [[WEPopoverController alloc] initWithContentViewController:self];
        self.popOver.containerViewProperties = [OWUtilities improvedContainerViewProperties];
    }
    return self;
}

- (void) presentPopoverFromBarButtonItem:(UIBarButtonItem *)buttonItem {
    self.popOver.popoverContentSize = self.popoverSize;
    self.selectionTableView.frame = CGRectMake(0, 0, popoverSize.width, popoverSize.height);
    UIPopoverArrowDirection arrowDirection = UIPopoverArrowDirectionUp;
    if(!popOver.isPopoverVisible){
        [popOver presentPopoverFromBarButtonItem:buttonItem permittedArrowDirections:arrowDirection animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case FEED_SECTION:
            return feedNames.count;
            break;
        case TAG_SECTION:
            return tagNames.count;
        default:
            return 0;
            break;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case FEED_SECTION:
            return FEEDS_STRING;
            break;
        case TAG_SECTION:
            return TAGS_STRING;
        default:
            return @"";
            break;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.section) {
        case FEED_SECTION:
            cell.textLabel.text = [feedNames objectAtIndex:indexPath.row];
            break;
        case TAG_SECTION:
            cell.textLabel.text = [tagNames objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case FEED_SECTION:
            [self.delegate didSelectFeedWithName:[feedNames objectAtIndex:indexPath.row]];
            break;
        case TAG_SECTION:
            [self.delegate didSelectTagWithName:[tagNames objectAtIndex:indexPath.row]];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [popOver dismissPopoverAnimated:YES];
}

@end
