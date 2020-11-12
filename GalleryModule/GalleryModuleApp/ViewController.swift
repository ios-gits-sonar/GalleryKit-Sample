//
//  ViewController.swift
//  GalleryModuleApp
//
//  Created by Ajie Pramono Arganata on 28/02/20.
//  Copyright © 2020 GITS Indonesia. All rights reserved.
//

import UIKit
import GalleryModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func open(_ sender: UIButton) {
        GalleryModuleWireframe.performToGallery(caller: self, onResultChooseImage: { image in
            
        })
    }
}

