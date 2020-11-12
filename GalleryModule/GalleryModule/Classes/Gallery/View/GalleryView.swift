//
//  GalleryView.swift
//  GalleryModule
//
//  Created by Ajie Pramono Arganata on 28/02/20.
//  Copyright © 2020 GITS Indonesia. All rights reserved.
//

import UIKit
import GITSFramework
import IGListKit

class GalleryView: BaseCustomView {
    // MARK: Properties
    var collectionVw: UICollectionView!
    var navItem: UINavigationItem!
    var cancelBarBtn: CustomUIBarButtonItem!
    
    // MARK: Function
    init(frame: CGRect, navItem: UINavigationItem) {
        super.init(frame: frame)
        self.navItem = navItem
        self.configCancelBarButton()
        self.configCollection()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateConstraints() {
        if shouldSetupConstraints {
            self.collectionVw.autoPinEdgesToSuperviewEdges(with: .zero)
            // Auto Layout Constraints
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}

extension GalleryView {
    func configCollection() {
        let collectionFlowLayout = ListCollectionViewLayout.init(stickyHeaders: false, scrollDirection: .vertical, topContentInset: 0, stretchToEdge: true)
        self.collectionVw = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        self.collectionVw.alwaysBounceVertical = true
        self.collectionVw.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        if #available(iOS 13.0, *) {
            self.collectionVw.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            self.collectionVw.backgroundColor = .white
        }
        self.addSubview(collectionVw)
    }
    
    func configCancelBarButton() {
        self.cancelBarBtn = CustomUIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        navItem.leftBarButtonItem = cancelBarBtn
    }
    
    func setupHandlerBarButton(handler: ((UIBarButtonItem)->())?) {
        cancelBarBtn.addHandlerButton(handler: handler)
    }
}
