import Foundation
import Metal

enum MyError: Error {
    case onRaise(String)
}

func createMTLTextureFromRGBData(device: MTLDevice, imageWidth: Int, imageHeight: Int, imageData: UnsafeMutablePointer<UInt8>) -> MTLTexture? {
    let bytesPerPixel = 4 // Assuming RGBA format (3 bytes per pixel: R, G, B, A)

    // Create a MTLTextureDescriptor
    let textureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .rgba8Unorm,
                                                                     width: imageWidth,
                                                                     height: imageHeight,
                                                                     mipmapped: false)

    // Create MTLTexture
    guard let texture = device.makeTexture(descriptor: textureDescriptor) else {
        print("Failed to create texture")
        return nil
    }
    // Load image data into the texture
    texture.replace(region: MTLRegionMake2D(0, 0, imageWidth, imageHeight),
                    mipmapLevel: 0,
                    withBytes: imageData,
                    bytesPerRow: imageWidth * bytesPerPixel)

    return texture
}


@objcMembers
public class UniCamEx : NSObject {
    let uniCamExModel = UniCamExModel()

    public override init() {
        super.init()
    }

    public func UniCamExSend(texture: MTLTexture) {
        uniCamExModel.onRecieveTexture(texture: texture)
    }
    
    public func UniCamExSendTest(imageData: UnsafeMutablePointer<UInt8>) throws {
//        print("helllo shit the")
//        logBytes(pointer: imageData, count: 3*3)
        let device = MTLCreateSystemDefaultDevice()!
        let width = 1280
        let height = 720
        let texture2 = createMTLTextureFromRGBData(device: device, imageWidth: width, imageHeight: height, imageData: imageData)
        if (texture2 != nil) {
            uniCamExModel.onRecieveTexture(texture: texture2!)
        }
    }
    
    
//    private static let uniCamExModel = UniCamExModel()
        
//    private init() {
//        // Private initializer to prevent instance creation
//    }
    
//    public static func UniCamExSend(texture: MTLTexture) {
//        uniCamExModel.onRecieveTexture(texture: texture)
//    }
}
