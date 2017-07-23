//
//  KZViewSizeCache.swift
//  KZProject
//
//  Created by Konrad Zdunczyk on 23/07/2017.
//  Copyright © 2017 Konrad Zdunczyk. All rights reserved.
//

import UIKit

protocol KZViewSizeCacheDelegate: class {
    func viewSizeCache(_ viewSizeCache: KZViewSizeCache, precalculateActionForView view: KZViewSizeCache.ViewType)
}

class KZViewSizeCache {
    typealias ViewType = UIView

    weak var delegate: KZViewSizeCacheDelegate?

    internal let view: ViewType
    private let sizePersistance = KZSizePersistence<String>()
    private let viewHeightCalculator: KZViewHeightCalculator

    init(view: ViewType) {
        self.view = view
        self.viewHeightCalculator = KZViewHeightCalculator(view: view)
    }

    func clearCache() {
        sizePersistance.clearCache()
    }

    func getItemSize(withWidth width: CGFloat,
                     andItemId itemId: String) -> CGSize {
        if let cachedHeight = sizePersistance.getCachedHeight(forWidth: width, andId: itemId) {
            return CGSize(width: width, height: cachedHeight)
        }

        let calculatedSize = calculateSize(forWidth: width)
        sizePersistance.cache(size: calculatedSize, forId: itemId)

        return calculatedSize
    }

    private func calculateSize(forWidth width: CGFloat) -> CGSize {
        delegate?.viewSizeCache(self, precalculateActionForView: view)

        return viewHeightCalculator.calculateSize(forWidth: width)
    }
}
