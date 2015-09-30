//
//  main.m
//  DownloadService
//
//  Created by ernesto on 29/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunesFeedDownloader.h"
#import "Item.h"

@interface ServiceDelegate : NSObject <NSXPCListenerDelegate>
@end

@implementation ServiceDelegate

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection {

    // Configure the interface and exported object
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(DownloadProtocol)];
    iTunesFeedDownloader *exportedObject = [iTunesFeedDownloader new];
    newConnection.exportedObject = exportedObject;
    
    [newConnection resume];
    
    return YES;
}

@end

int main(int argc, const char *argv[])
{
    // Create the delegate for the service.
    ServiceDelegate *delegate = [ServiceDelegate new];
    
    // Set up the one NSXPCListener for this service. It will handle all incoming connections.
    NSXPCListener *listener = [NSXPCListener serviceListener];
    listener.delegate = delegate;
    
    // Resuming the serviceListener starts this service. This method does not return.
    [listener resume];
    return 0;
}
