
//
//  Config.swift
//  AVStudy
//
//  Created by zhz on 22/08/2017.
//  Copyright © 2017 zhz. All rights reserved.
//

import UIKit
import AVFoundation

let ScreenW: CGFloat = UIScreen.main.bounds.width

let ScreenH: CGFloat = UIScreen.main.bounds.height

let ScreenBounds: CGRect = UIScreen.main.bounds

let filePath: String = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/tempAudio.m4a"))!

/* 获取音频文件 时长 */
func getAudioDuration(path: String) -> CGFloat {
    let exist: Bool = FileManager.default.fileExists(atPath: path)
    guard exist else {
        return 0.0;
    }
    let asset: AVURLAsset = AVURLAsset(url: URL.init(fileURLWithPath: path))
    let time: CMTime = asset.duration
    let sections: CGFloat = CGFloat(ceilf(Float(time.value / Int64(time.timescale))))
    return sections
}

/* 获取文件大小 */
func getFileSize(path: String) -> CGFloat {
    let exist: Bool = FileManager.default.fileExists(atPath: path)
    guard exist else {
        return 0.0;
    }
    
    do {
        let dict: Dictionary = try FileManager.default.attributesOfItem(atPath: path)
        print(dict[FileAttributeKey.size] as Any)
        print(dict[FileAttributeKey.referenceCount] as Any)
        print(dict[FileAttributeKey.posixPermissions] as Any)
        print(dict[FileAttributeKey.systemNumber] as Any)
        print(dict[FileAttributeKey.systemFileNumber] as Any)
        print(dict[FileAttributeKey.creationDate] as Any)
        print(dict[FileAttributeKey.modificationDate] as Any)
        print(dict[FileAttributeKey.type] as Any)
        print(dict[FileAttributeKey.extensionHidden] as Any)
        print(dict[FileAttributeKey.ownerAccountName] as Any)
        print(dict[FileAttributeKey.ownerAccountID] as Any)
        print(dict[FileAttributeKey.groupOwnerAccountID] as Any)
        print(dict[FileAttributeKey.groupOwnerAccountName] as Any)
        let size: CGFloat = dict[FileAttributeKey.size] as! CGFloat
        
        return size / 1024
    } catch let error {
        print(error)
        return 0.0
    }
}

