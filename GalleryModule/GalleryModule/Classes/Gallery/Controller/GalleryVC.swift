//
//  GalleryVC.swift
//  GalleryModule
//
//  Created by Ajie Pramono Arganata on 28/02/20.
//  Copyright © 2020 GITS Indonesia. All rights reserved.
//

import UIKit
import GITSFramework
import IGListKit
import TOCropViewController

/// This is a controller class of Gallery
class GalleryVC: BaseVC {
    // MARK: Properties
    /// Gallery View
    private var galleryVw: GalleryView!
    /// Product List View Model
    private lazy var viewModel = GalleryVM()
    /// Product List Data Source
    private lazy var dataSource = GalleryDataSource()
    /// Product List Adapter
    private lazy var adapter: ListAdapter = {
        return ListAdapter(
            updater: ListAdapterUpdater(),
            viewController: self,
            workingRangeSize: 0)
    }()
    public var onResultChooseImage: ((UIImage)->())?
    
    // MARK: Function
    /** When this view loaded it will setup the view
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    /** Configure Something here
     */
    override func configureView() {
        self.title = "Gallery"
        self.galleryVw = GalleryView(frame: .zero, navItem: self.navigationItem)
        self.galleryVw.instantiateView(from: self.view)
        self.galleryVw.setupHandlerBarButton { (barBtn) in
            self.dismiss(animated: true, completion: nil)
        }
        self.adapter.collectionView?.isUserInteractionEnabled = false
        self.adapter.collectionView = self.galleryVw.collectionVw
        self.adapter.dataSource = self.dataSource
        self.dataSource.sectionList.onSelectedItem = { (idx) in
            self.galleryVw.collectionVw.isUserInteractionEnabled = false
            self.galleryVw.cancelBarBtn.isEnabled = false
            self.viewModel.loadChoosePhoto(asset: self.dataSource.item[idx].asset)
        }
        self.observableLiveData()
        self.viewModel.loadGalleryData(rootVC: self)
    }
    
    override func becomeActive() {
        self.viewModel.loadGalleryData(rootVC: self)
    }
    
    override func rotated() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.dataSource.sectionList.onRefreshDataSection?()
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    /** Observabe function
     */
    func observableLiveData() {
        // Load Result Gallery Data
        viewModel.loadItems.observe = { data in
            self.adapter.collectionView?.isUserInteractionEnabled = true
            self.dataSource.addGalleryListItem(item: data)
        }
        // Load Result Choosed Image
        viewModel.loadImage.observe = { image in
            self.galleryVw.collectionVw.isUserInteractionEnabled = true
            self.galleryVw.cancelBarBtn.isEnabled = true
            self.dataSource.sectionList.onRefreshDataSection?()
            self.adapter.performUpdates(animated: true, completion: nil)
            self.openTOCropImage(with: image)
        }
        // Load Is Still Loading
        viewModel.loadApi.observe = { isLoad in
            if isLoad {
                self.showLoadNet()
            } else {
                self.stopLoadNet()
                self.stopRefresh()
            }
        }
        // Load Error Message
        viewModel.loadError.observe = { message in
            self.showSnackbar(message: message)
        }
    }
}

extension GalleryVC: TOCropViewControllerDelegate {
    func openTOCropImage(with image: UIImage) {
        let image: UIImage = image
        let cropViewController = TOCropViewController(croppingStyle: .default, image: image)
        cropViewController.modalPresentationStyle = .overFullScreen
        cropViewController.delegate = self
        self.present(cropViewController, animated: false, completion: nil)
    }

    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        // 'image' is the newly cropped version of the original image
        cropViewController.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
        self.onResultChooseImage?(image)
    }
}
