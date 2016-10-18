//
//  PFPPayloadTypes.h
//  ProfilePayloads
//
//  Created by Erik Berglund.
//  Copyright (c) 2016 ProfileCreator. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import <Foundation/Foundation.h>
@class PFPPayloadType;
@class PFPPayloadTypeKey;

@interface PFPPayloadTypes : NSObject

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

@property (nonatomic, strong, readonly, nullable) NSArray<NSString *> *domains;
@property (nonatomic, strong, readonly, nullable) NSDictionary *payloadTypes;

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Instance Methods
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

- (PFPPayloadTypeKey *_Nullable)payloadKeyForPayloadKeyPath:(NSString *_Nonnull)payloadKeyPath error:(NSError *_Nullable *_Nullable)error; // Only last key

@end