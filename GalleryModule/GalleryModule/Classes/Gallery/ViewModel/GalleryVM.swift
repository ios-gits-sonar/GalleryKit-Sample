//
//  GalleryVM.swift
//  GalleryModule
//
//  Created by Ajie Pramono Arganata on 28/02/20.
//  Copyright © 2020 GITS Indonesia. All rights reserved.
//

import GITSFramework
import Photos

/// Product List View Model
class GalleryVM: BaseVM {
    // MARK: Properties
    /// Load Items Observable
    var loadItems = Observable<[GalleryModel]>()
    /// Load Choosed Image Assets
    var loadImage = Observable<UIImage>()
    
    // MARK: Function
    /** Initialization
     */
    override init() {
        loadItems.property = []
    }
    
    /** Load Gallery Data From API Source
     */
    func loadGalleryData(rootVC: UIViewController) {
        self.configRequestPhoto(rootVC: rootVC)
    }
    
    private func configRequestPhoto(rootVC: UIViewController) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case .authorized :
                self.configGetAlbum()
            case .denied :
                self.showDeniedDialog(rootVC: rootVC)
            default :
                break
            }
        }
    }
    
    private func configGetAlbum() {
        DispatchQueue.main.async {
            let albumFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
            albumFetchResult.enumerateObjects({ (album, _, _) in
                if album.assetCollectionSubtype == .smartAlbumUserLibrary {
                    self.configShowAlbum(albumName: album.localizedTitle ?? "", album: album)
                }
            })
        }
    }
        
    private func configShowAlbum(albumName: String, album: PHAssetCollection) {
        var dataPhoto: [GalleryModel] = []
        let option = PHFetchOptions()
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let result = PHAsset.fetchAssets(in: album, options: option)
        for i in 0..<result.count {
            if result[i].mediaType == .image {
                dataPhoto.append(GalleryModel(idx: i, asset: result[i]))//, num: 0, isChoose: false, isLoading: false))
            }
        }
        self.loadItems.property = dataPhoto
    }
    
    func loadChoosePhoto(asset: PHAsset?) {
        guard let asset = asset else { return }
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        //load image from library photos before go to review
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options, resultHandler: { (image, any) in
                if let image = image {
                    self.loadImage.property = image
                }
            })
        }
    }
    
    private func showDeniedDialog(rootVC: UIViewController) {
        let alert = UIAlertController(title: "Permission Dialog", message: "Your photo library permission is denied, you must change it on the setting menu", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            rootVC.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { (action) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            rootVC.present(alert, animated: true, completion: nil)
        })
    }
}
