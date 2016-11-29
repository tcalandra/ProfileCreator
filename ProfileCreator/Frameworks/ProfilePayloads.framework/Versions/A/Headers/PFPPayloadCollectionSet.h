//
//  PFPPayloadCollectionSet.h
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

#pragma once

#import "PFPPayloadCollection.h"
#import "PFPViewTypeDelegate.h"
#import <Foundation/Foundation.h>
@class PFPPayloadCollections;

@protocol PFPPayloadCollectionSet <NSObject>

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

@property (nonatomic, readonly, nullable) NSArray<NSString *> *domains;
@property (nonatomic, readonly, nullable) NSArray<NSDictionary *> *placeholders;
@property (nonatomic, readonly, nullable) NSDictionary *payloadCollections;

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Init
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithViewModel:(PFPViewModel)viewModel viewTypeDelegate:(id<PFPViewTypeDelegate> _Nonnull)viewTypeDelegate payloadCollections:(PFPPayloadCollections *_Nonnull)payloadCollections;

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Instance Methods
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

- (id<PFPPayloadCollection> _Nullable)collectionWithIdentifier:(NSString *_Nonnull)identifier;

@end
