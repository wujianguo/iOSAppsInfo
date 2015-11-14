//
//  LMApp.m
//  WatchSpringboard
//
//  Created by Andreas Verhoeven on 28-10-14.
//  Copyright (c) 2014 Lucas Menge. All rights reserved.
//

#import "LMApp.h"

@interface UIImage ()
+ (id)_iconForResourceProxy:(id)arg1 variant:(int)arg2 variantsScale:(float)arg3;
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2 scale:(double)arg3;
@end

#pragma mark -

@interface PrivateApi_LSApplicationProxy

+ (instancetype)applicationProxyForIdentifier:(NSString*)identifier;
@property (nonatomic, readonly) NSString* localizedShortName;
@property (nonatomic, readonly) NSString* localizedName;
@property (nonatomic, readonly) NSString* bundleIdentifier;
@property (nonatomic, readonly) NSArray* appTags;

@property (nonatomic, readonly) NSString *applicationDSID;
@property (nonatomic, readonly) NSString *applicationIdentifier;
@property (nonatomic, readonly) NSString *applicationType;
@property (nonatomic, readonly) NSNumber *dynamicDiskUsage;

@property (nonatomic, readonly) NSArray *groupIdentifiers;
@property (nonatomic, readonly) NSNumber *itemID;
@property (nonatomic, readonly) NSString *itemName;
@property (nonatomic, readonly) NSString *minimumSystemVersion;
@property (nonatomic, readonly) NSArray *requiredDeviceCapabilities;
@property (nonatomic, readonly) NSString *roleIdentifier;
@property (nonatomic, readonly) NSString *sdkVersion;
@property (nonatomic, readonly) NSString *shortVersionString;
@property (nonatomic, readonly) NSString *sourceAppIdentifier;
@property (nonatomic, readonly) NSNumber *staticDiskUsage;
@property (nonatomic, readonly) NSString *teamID;
@property (nonatomic, readonly) NSString *vendorName;

@end

#pragma mark -

@implementation LMApp
{
	PrivateApi_LSApplicationProxy* _applicationProxy;
	UIImage* _icon;
}

- (NSString*)name
{
	return _applicationProxy.localizedName ?: _applicationProxy.localizedShortName;
}

- (NSString*)bundleIdentifier
{
	return [_applicationProxy bundleIdentifier];
}

- (UIImage*)icon
{
	if(nil == _icon)
	{
		_icon = [UIImage _applicationIconImageForBundleIdentifier:self.bundleIdentifier format:10 scale:2.0];
	}
	
	return _icon;
}

- (NSString*)applicationDSID
{
    return _applicationProxy.applicationDSID;
}

- (NSString*)applicationIdentifier
{
    return _applicationProxy.applicationIdentifier;
}

- (NSString*)applicationType
{
    return _applicationProxy.applicationType;
}

- (NSArray*)groupIdentifiers
{
    return _applicationProxy.groupIdentifiers;
}

- (NSNumber*)itemID
{
    return _applicationProxy.itemID;
}

- (NSString*)itemName
{
    return _applicationProxy.itemName;
}

- (NSString*)minimumSystemVersion
{
    return _applicationProxy.minimumSystemVersion;
}

- (NSArray*)requiredDeviceCapabilities
{
    return _applicationProxy.requiredDeviceCapabilities;
}

- (NSString*)sdkVersion
{
    return _applicationProxy.sdkVersion;
}

- (NSString*)shortVersionString
{
    return _applicationProxy.shortVersionString;
}

- (NSNumber*)staticDiskUsage
{
    return _applicationProxy.staticDiskUsage;
}

- (NSString*)teamID
{
    return _applicationProxy.teamID;
}

- (NSString*)vendorName
{
    return _applicationProxy.vendorName;
}

- (BOOL)isHiddenApp
{
	return [[_applicationProxy appTags] indexOfObject:@"hidden"] != NSNotFound;
}

- (id)initWithPrivateProxy:(id)privateProxy
{
  self = [super init];
  if(self != nil)
  {
      _applicationProxy = (PrivateApi_LSApplicationProxy*)privateProxy;
      /*
      NSLog(@"%@,%@", _applicationProxy.localizedName, _applicationProxy.bundleIdentifier);

      NSLog(@"applicationDSID:%@", _applicationProxy.applicationDSID);
      NSLog(@"applicationIdentifier:%@", _applicationProxy.applicationIdentifier);
      NSLog(@"applicationType:%@", _applicationProxy.applicationType);
      NSLog(@"dynamicDiskUsage:%@", _applicationProxy.dynamicDiskUsage);

      NSLog(@"groupIdentifiers:%@", _applicationProxy.groupIdentifiers);
      NSLog(@"itemID:%@", _applicationProxy.itemID);
      NSLog(@"itemName:%@", _applicationProxy.itemName);
      NSLog(@"minimumSystemVersion:%@", _applicationProxy.minimumSystemVersion);
      NSLog(@"requiredDeviceCapabilities:%@", _applicationProxy.requiredDeviceCapabilities);
      NSLog(@"roleIdentifier:%@", _applicationProxy.roleIdentifier);
      NSLog(@"sdkVersion:%@", _applicationProxy.sdkVersion);
      NSLog(@"shortVersionString:%@", _applicationProxy.shortVersionString);
      NSLog(@"sourceAppIdentifier:%@", _applicationProxy.sourceAppIdentifier);
      NSLog(@"staticDiskUsage:%@", _applicationProxy.staticDiskUsage);
      NSLog(@"teamID:%@", _applicationProxy.teamID);
      NSLog(@"vendorName:%@", _applicationProxy.vendorName);
      */
  }
  
  return self;
}

- (instancetype)initWithBundleIdentifier:(NSString*)bundleIdentifier
{
  self = [super init];
  if(self != nil)
  {
    _applicationProxy = [NSClassFromString(@"LSApplicationProxy") applicationProxyForIdentifier:bundleIdentifier];
  }
  
  return self;
}

+ (instancetype)appWithPrivateProxy:(id)privateProxy
{
  return [[self alloc] initWithPrivateProxy:privateProxy];
}

+ (instancetype)appWithBundleIdentifier:(NSString*)bundleIdentifier
{
  return [[self alloc] initWithBundleIdentifier:bundleIdentifier];
}

@end
