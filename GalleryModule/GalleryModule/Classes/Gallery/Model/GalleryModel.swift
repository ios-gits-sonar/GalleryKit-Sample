//
//  GalleryModel.swift
//  GalleryModule
//
//  Created by Ajie Pramono Arganata on 28/02/20.
//  Copyright © 2020 GITS Indonesia. All rights reserved.
//

import Photos

/// This is a class of gallery model
class GalleryModel: NSObject {
    // MARK: Properties
    var idx: Int?
    var asset: PHAsset?
    
    /** Initialization Gallery Model
     */
    init(idx: Int?, asset: PHAsset?) {
        self.idx = idx
        self.asset = asset
    }
}
