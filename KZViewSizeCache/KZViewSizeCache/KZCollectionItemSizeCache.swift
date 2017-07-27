//
//  KZCollectionItemSizeCache.swift
//  KZProject
//
//  Created by Konrad Zdunczyk on 23/07/2017.
//  Copyright © 2017 Konrad Zdunczyk. All rights reserved.
//

import UIKit

protocol KZCollectionItemSizeCacheDelegate: class {
    func collectionItemSizeCache(_ sizeCache: KZCollectionItemSizeCache,
                                 setupSizingItem sizingItem: UIView,
                                 withType type: KZSizingItemType,
                                 atIndexPath indexPath: IndexPath)
}

class KZCollectionItemSizeCache {
    typealias ViewType = UIView & KZSizingItem

    let type: KZSizingItemType
    weak var delegate: KZCollectionItemSizeCacheDelegate?

    private let viewSizeCache: KZViewSizeCache
    fileprivate var lastIndexPath: IndexPath!

    convenience init?(sizingItemFromNibNamed nibName: String, andType type: KZSizingItemType) {
        guard let sizingItem = Bundle.main.loadNibNamed(nibName,
                                                        owner: nil,
                                                        options: nil)?.first as? ViewType else {
                                                            // TODO: Assert on type check
                                                            return nil
        }

        self.init(sizingItem: sizingItem, type: type)
    }

    init(sizingItem: ViewType, type: KZSizingItemType) {
        self.type = type
        self.viewSizeCache = KZViewSizeCache(view: sizingItem)

        viewSizeCache.delegate = self
    }

    func getItemSize(withWidth itemWidth: CGFloat,
                     andItemId itemId: String,
                     forItemAtIndexPath indexPath: IndexPath) -> CGSize {
        lastIndexPath = indexPath

        return viewSizeCache.getItemSize(withWidth: itemWidth,
                                         andItemId: itemId)
    }

    func getItemSize(withWidth itemWidth: CGFloat,
                     andItemId itemId: String,
                     forItemAtSection section: Int) -> CGSize {
        assert(type != .cell, "sizeCache should be initialized for header or footer type to use this method.")

        let indexPath = IndexPath(item: 0, section: section)
        return getItemSize(withWidth: itemWidth,
                           andItemId: itemId,
                           forItemAtIndexPath: indexPath)
    }
}

extension KZCollectionItemSizeCache: KZViewSizeCacheDelegate {
    func viewSizeCache(_ viewSizeCache: KZViewSizeCache, precalculateActionForView view: KZViewSizeCache.ViewType) {
        delegate?.collectionItemSizeCache(self,
                                          setupSizingItem: view,
                                          withType: type,
                                          atIndexPath: lastIndexPath)
    }
}
