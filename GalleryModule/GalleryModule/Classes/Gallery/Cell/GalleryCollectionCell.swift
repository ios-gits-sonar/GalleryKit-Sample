//
//  GalleryCollectionCell.swift
//  GalleryModule
//
//  Created by Ajie Pramono Arganata on 28/02/20.
//  Copyright © 2020 GITS Indonesia. All rights reserved.
//

import UIKit
import GITSFramework
import Shimmer

class GalleryCollectionCell: BaseCollectionCell {
    // MARK: Properties
    private var galleryContentVw: CardView!
    public var shimmeringVw: FBShimmeringView!
    private var galleryImageCardVw: CardView!
    public var galleryImageVw: UIImageView!
    public var galleryBtn: CustomButton!
    /// Item Gallery List
    public var item: GalleryModel? {
        didSet {
            guard let asset = item?.asset else { return }
            self.galleryImageVw.g_loadImage(asset)
        }
    }
    
    // MARK: Function
    /** Initialization Frame, will setup the component to view
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configGalleryContent()
        self.configShimmering()
        self.configGalleryImage()
        self.updateConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /** Update Constraint
    */
    override func updateConstraints() {
        self.initConstraint()
        super.updateConstraints()
    }
    
    /** Content Cell Size
    */
    static func cellSize(screenWidth: CGFloat) -> CGSize {
        let width = screenWidth
        let orientation = UIApplication.shared.statusBarOrientation
        let maxItem: CGFloat = orientation == .portrait ? 3 : 5
        let collectionLeftAndRight: CGFloat = 16*(maxItem+1)
        let totalSize = ((width - collectionLeftAndRight) / maxItem)
        let size = CGSize(width: totalSize, height: totalSize)
        return size
    }
}

extension GalleryCollectionCell {
    /** Content View
    */
    private func configGalleryContent() {
        self.galleryContentVw = CardView(frame: .zero, cornerRadius: 8)
        self.galleryContentVw.backgroundColor = .white
        self.contentView.addSubview(self.galleryContentVw)
        
        self.galleryBtn = CustomButton(frame: .zero)
        self.galleryBtn.applyStyle(title: "", font: nil, fontColor: .white, backgroundColor: .clear, shadow: 0, borderRadius: 8)
        self.contentView.addSubview(self.galleryBtn)
    }
    
    private func configShimmering() {
        self.shimmeringVw = FBShimmeringView(frame: .zero)
        self.galleryContentVw.addSubview(self.shimmeringVw)
        self.shimmeringVw.isShimmering = false
    }
    
    /** Gallery Image
    */
    private func configGalleryImage() {
        self.galleryImageCardVw = CardView(frame: .zero, cornerRadius: 8)
        self.galleryImageCardVw.clipsToBounds = true
        self.galleryImageVw = UIImageView()
        self.galleryImageVw.cornerRadiusPreset = .cornerRadius3
        self.galleryImageVw.clipsToBounds = true
        self.galleryImageVw.contentMode = .scaleAspectFill
        self.galleryImageVw.backgroundColor = .lightGray
        self.galleryImageCardVw.addSubview(self.galleryImageVw)
        self.galleryContentVw.addSubview(self.galleryImageCardVw)
    }
    
    /** Initialization the constraint
     */
    private func initConstraint() {
        if shouldSetupConstraints {
            self.galleryContentVw.autoPinEdgesToSuperviewEdges(with: .zero)
            self.shimmeringVw.autoPinEdgesToSuperviewEdges(with: .zero)
            self.galleryBtn.autoPinEdgesToSuperviewEdges()
            self.galleryImageCardVw.autoPinEdgesToSuperviewEdges(with: .zero)
            self.galleryImageVw.autoPinEdgesToSuperviewEdges(with: .zero)
            // Auto Layout Constraints
            shouldSetupConstraints = false
        }
    }
    
    public func setButtonHandler(handler: ((UIView)->())?) {
        self.galleryBtn.addHandlerButton(handler: handler)
    }
}
