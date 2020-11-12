//
//  GalleryDataSource.swift
//  GalleryModule
//
//  Created by Ajie Pramono Arganata on 28/02/20.
//  Copyright © 2020 GITS Indonesia. All rights reserved.
//

import IGListKit
import GITSFramework

/// Gallery Data Source is a class for collection data source
class GalleryDataSource: NSObject, ListAdapterDataSource {
    public var sectionList = GallerySectionController()
    var item: [GalleryModel] = []
    
    func addGalleryListItem(item: [GalleryModel]) {
        self.item = item
        self.sectionList.items = item
        self.sectionList.onRefreshDataSection?()
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return ["list"] as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return sectionList
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
