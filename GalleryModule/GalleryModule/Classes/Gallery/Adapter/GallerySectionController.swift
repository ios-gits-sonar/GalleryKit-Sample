//
//  GallerySectionController.swift
//  GalleryModule
//
//  Created by Ajie Pramono Arganata on 28/02/20.
//  Copyright © 2020 GITS Indonesia. All rights reserved.
//

import IGListKit

/// Gallery Section Controller Class
class GallerySectionController: ListSectionController {
    // MARK: Properties
    /// Product List Items
    public var items: [GalleryModel] = []
    /// A Closure for refresh data section
    public var onRefreshDataSection: (()->())?
    /// A Closure for selected data
    public var onSelectedItem: ((_ idx: Int)->())?
    
    // MARK: Function
    /** Initialization
     */
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.minimumInteritemSpacing = 16
        self.minimumLineSpacing = 16
        self.onRefreshDataSection = {
            self.collectionContext?.performBatch(animated: true, updates: { batchContext in
              batchContext.reload(self)
            }, completion: nil)
        }
    }
    
    /** Number of items in one section
    */
    override func numberOfItems() -> Int {
        return items.count == 0 ? 12 : items.count
    }
    
    /** Set the cell here
    */
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = GalleryCollectionCell.initCell(collectionContext, section: self, index: index) as! GalleryCollectionCell
        if items.count != 0 {
            cell.item = self.items[index]
            cell.shimmeringVw.isShimmering = false
        } else {
            cell.item = nil
            cell.shimmeringVw.isShimmering = true
        }
        cell.setButtonHandler { (view) in
            cell.galleryBtn.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            cell.galleryImageVw.setLoad(isLoad: true, style: .white)
            self.onSelectedItem?(index)
        }
        return cell
    }
    
    /** Size of the item
    */
    override func sizeForItem(at index: Int) -> CGSize {
        return GalleryCollectionCell.cellSize(screenWidth: self.collectionContext?.containerSize.width ?? 0)
    }
    
    override func didUpdate(to object: Any) {
        self.items = object as? [GalleryModel] ?? []
    }
}
