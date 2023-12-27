//
//  VmeTest.m
//  VmeTest
//
//  Created by nccsoft on 12/26/23.
//

#import "VmeTest.h"

//@implementation VmeTest
#import <Metal/Metal.h>
#include <SystemExtensions/SystemExtensions.h>
#include <VmeTest-Swift.h>

extern "C" {
    UniCamEx *uniCamExModel = [[UniCamEx alloc] init];

    void UniCamExSendTest(unsigned char* textureData) {
        NSLog(@"hello123");
//        printf("helloeee UniCamExSendTest");
//        @throw [NSException exceptionWithName:@"TestException" reason:@"An exception occurred" userInfo:nil];
        // Example: Reconstructing the texture (a simplified representation)
        MTLTextureDescriptor *textureDescriptor = [[MTLTextureDescriptor alloc] init];
        // Set texture properties such as width, height, pixel format, etc.
        NSArray<id<MTLDevice>> *devices = MTLCopyAllDevices(); // Retrieve all available Metal devices

        if ([devices count] > 0) {

        } else {
            NSLog(@"No Metal devices available.");
        }
        
        id<MTLDevice> device = MTLCreateSystemDefaultDevice();
        if (device) {
            MTLTextureDescriptor *textureDescriptor = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatRGBA8Unorm
                                                                                                         width:512  // Specify width
                                                                                                        height:512  // Specify height
                                                                                                     mipmapped:NO];
            id<MTLTexture> texture = [device newTextureWithDescriptor:textureDescriptor];
            
            // Check if the texture was created successfully
            if (texture) {
                NSLog(@"Texture width: %lu", (unsigned long)texture.width);
                NSLog(@"Texture height: %lu", (unsigned long)texture.height);
                NSLog(@"Texture pixel format: %lu", (unsigned long)texture.pixelFormat);
                // Log other properties or perform operations with the texture
            } else {
                NSLog(@"Failed to create the texture.");
            }
        } else {
            NSLog(@"Metal is not supported on this device.");
        }
        id<MTLTexture> reconstructedTexture = [device newTextureWithDescriptor:textureDescriptor];

        textureDescriptor.pixelFormat = MTLPixelFormatRGBA8Unorm;
        textureDescriptor.width = 1280;
        textureDescriptor.height = 720;
        // Assuming the received data is in RGBA format and needs to be copied into the texture
        NSUInteger bytesPerRow = textureDescriptor.width * 4; // 4 bytes per pixel (RGBA)
        NSUInteger bytesPerImage = bytesPerRow * textureDescriptor.height;
        MTLRegion region = {
            { 0, 0, 0 }, // Origin (x, y, z)
            { textureDescriptor.width, textureDescriptor.height, 1 } // Size (width, height, depth)
        };
        printf("helloeee");
        // Copy the received texture data into the reconstructed texture
        
        [reconstructedTexture replaceRegion:region mipmapLevel:0 withBytes:textureData bytesPerRow:bytesPerRow];
        
        // Log texture properties
        NSLog(@"Texture width: %lu", (unsigned long)reconstructedTexture.width);
        NSLog(@"Texture height: %lu", (unsigned long)reconstructedTexture.height);
        NSLog(@"Texture pixel format: %lu", (unsigned long)reconstructedTexture.pixelFormat);

        
//        id<MTLTexture> tex = (__bridge id<MTLTexture>)mtlTexture;
//        printf("helllo 123");
        [uniCamExModel UniCamExSendWithTexture:reconstructedTexture];
//        @throw [NSException exceptionWithName:@"TestException" reason:@"An exception occurred" userInfo:nil];
//        uint8_t *  tex = (uint8_t*)mtlTexture;
//        @throw [NSException exceptionWithName:@"TestException" reason:@"An exception occurred" userInfo:nil];
//        [uniCamExModel UniCamExSendWithTexture:tex];
//        [uniCamExModel UniCamExSendTestWithImageData:tex error:nil];
    }
}

//@end
