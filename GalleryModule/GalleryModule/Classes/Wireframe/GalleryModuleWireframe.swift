//
//  GalleryModuleWireframe.swift
//  GalleryModule
//
//  Created by Ajie Pramono Arganata on 28/02/20.
//  Copyright © 2020 GITS Indonesia. All rights reserved.
//

import UIKit

public struct GalleryModuleWireframe {
    
    public static func performToGallery(caller: UIViewController, onResultChooseImage: ((UIImage)->())?) {
        let vc = GalleryVC()
        vc.onResultChooseImage = onResultChooseImage
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
//        nav.navigationBar.barTintColor = .white
//        nav.navigationBar.tintColor = 
        nav.navigationBar.isTranslucent = true
        caller.present(nav, animated: true, completion: nil)
    }
}
