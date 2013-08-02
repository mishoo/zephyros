//
//  AppDelegate.m
//  Zephyros
//
//  Created by Steven on 4/13/13.
//  Copyright (c) 2013 Giant Robot Software. All rights reserved.
//

#import "AppDelegate.h"

#import "SDOpenAtLogin.h"
#import "SDConfigLoader.h"
#import "SDAppStalker.h"

#import "SDLogWindowController.h"
#import "SDPreferencesWindowController.h"


#import "SDAlertWindowController.h"
#import "SDClientListener.h"


@interface AppDelegate ()

@property NSStatusItem* statusItem;

@end

@implementation AppDelegate

- (void) prepareStatusItem {
    [[SDClientListener sharedListener] startListening];
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.image = [NSImage imageNamed:@"statusitem"];
    self.statusItem.alternateImage = [NSImage imageNamed:@"statusitem_pressed"];
    self.statusItem.menu = self.statusItemMenu;
    self.statusItem.highlightMode = YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self prepareStatusItem];
    
    
    
//    [[SDConfigLoader sharedConfigLoader] prepareScriptingBridge];
//    [[SDConfigLoader sharedConfigLoader] reloadConfig];
    [[SDAppStalker sharedAppStalker] beginStalking];
    
    [[SDAlertWindowController sharedAlertWindowController] show:@"Zephyros power, activate!"
                                                          delay:@1.5];
}

- (IBAction) showPreferencesWindow:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [[SDPreferencesWindowController sharedConfigChooserWindowController] show];
}

- (IBAction) relaunchConfig:(id)sender {
//    [[SDConfigLoader sharedConfigLoader] reloadConfig];
}

- (void) menuNeedsUpdate:(NSMenu *)menu {
    [[menu itemWithTitle:@"Open at Login"] setState:([SDOpenAtLogin opensAtLogin] ? NSOnState : NSOffState)];
}

- (IBAction) showLogWindow:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [[SDLogWindowController sharedLogWindowController] showWindow:self];
}

- (IBAction) showAboutPanel:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp orderFrontStandardAboutPanel:sender];
}

- (IBAction) toggleOpensAtLogin:(id)sender {
	NSInteger changingToState = ![sender state];
	[SDOpenAtLogin setOpensAtLogin: changingToState];
}

@end
