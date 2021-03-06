//
//  PFCLog.m
//  ProfileCreator
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

#import "PFCConstants.h"
#import "PFCLog.h"
#import "PFCLogFormatter.h"

DDLogLevel ddLogLevel;

@implementation PFCLog

+ (void)configureLoggingForSession:(int)sessionType {

    // -------------------------------------------------------------------------
    //  Log to Console (Xcode/Commandline)
    // -------------------------------------------------------------------------
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setLogFormatter:[[PFCLogFormatter alloc] init]];

    // -------------------------------------------------------------------------
    //  Log to file
    // -------------------------------------------------------------------------
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    [fileLogger setMaximumFileSize:10000000]; // 10000000 = 10 MB
    [fileLogger setRollingFrequency:0];
    [[fileLogger logFileManager] setMaximumNumberOfLogFiles:7];
    [fileLogger setLogFormatter:[[PFCLogFormatter alloc] init]];
    [DDLog addLogger:fileLogger];

    // -------------------------------------------------------------------------
    //  Set log level from user settings. If no setting is found. set DDLogLevelWarning
    // -------------------------------------------------------------------------
    NSNumber *logLevel = [[NSUserDefaults standardUserDefaults] objectForKey:PFCUserDefaultsLogLevel];
    if (logLevel) {

        // ---------------------------------------------------------------------
        //  If log level was set to Debug, lower to Info
        // ---------------------------------------------------------------------
        /* FIXME - Disable the automatic lowering of debug level for now
        if ([logLevel intValue] == (int)DDLogLevelDebug) {
            ddLogLevel = DDLogLevelInfo;
            [[NSUserDefaults standardUserDefaults] setObject:@((int)ddLogLevel) forKey:PFCUserDefaultsLogLevel];
        } else {
            ddLogLevel = (DDLogLevel)[logLevel intValue];
        }
         */
        ddLogLevel = (DDLogLevel)[logLevel intValue];
    } else {
        ddLogLevel = DDLogLevelWarning;
        [[NSUserDefaults standardUserDefaults] setObject:@((int)ddLogLevel) forKey:PFCUserDefaultsLogLevel];
    }

    NSString *logLevelName;

    // -------------------------------------------------------------------------
    //  Do different setup depending on what session type is in use
    // -------------------------------------------------------------------------
    switch (sessionType) {
    case kPFCSessionTypeCLI:
        // This switch is here for future implementation.
        break;

    case kPFCSessionTypeGUI:
        DDLogDebug(@"Starting ProfileCreator version %@ (build %@)...", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                   [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]);
        switch (ddLogLevel) {
        case 1:
            logLevelName = @"Error";
            break;
        case 3:
            logLevelName = @"Warn";
            break;
        case 7:
            logLevelName = @"Info";
            break;
        case 15:
            logLevelName = @"Debug";
            break;
        default:
            logLevelName = [@((int)ddLogLevel) stringValue];
            break;
        }
        DDLogDebug(@"Log level: %@", logLevelName);
        break;
    default:
        break;
    }
} // configureLoggingForSession

+ (DDFileLogger *)fileLogger {
    NSArray *allLoggers = [DDLog allLoggers];
    NSUInteger indexOfFileLogger = [allLoggers indexOfObjectPassingTest:^(id logger, NSUInteger __unused idx, BOOL __unused *stop) {
      return [logger isKindOfClass:[DDFileLogger class]];
    }];

    return indexOfFileLogger == NSNotFound ? nil : allLoggers[indexOfFileLogger];
} // fileLogger

@end
