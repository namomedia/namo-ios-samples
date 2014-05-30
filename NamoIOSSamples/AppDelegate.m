// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import "AppDelegate.h"
#import "MainViewController.h"

#import <AdSupport/AdSupport.h>
#import <Namo/Namo.H>

@implementation AppDelegate

- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  // Namo initialization
  [Namo setApplicationId:@"app-test-id"];

  // The demo is always a test device, which prevents frequency capping.
  NSString *testId = nil;
  if (NSClassFromString(@"ASIdentifierManager")) {
    testId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [Namo setTestDevices:@[testId] includeSimulator:YES];
  }

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  MainViewController *mainViewController = [[MainViewController alloc] init];
  self.navigationController =
      [[UINavigationController alloc] initWithRootViewController:mainViewController];

  self.window.rootViewController = self.navigationController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
