//
//  KZSizePersistence.swift
//  KZProject
//
//  Created by Konrad Zdunczyk on 23/07/2017.
//  Copyright © 2017 Konrad Zdunczyk. All rights reserved.
//

import UIKit

class KZSizePersistence<IdType: Hashable> {
    typealias HeightType = CGFloat
    typealias WidithType = CGFloat

    private var sizeCache: [IdType : [WidithType : HeightType]] = [:]

    func getCachedHeight(forWidth width: CGFloat,
                         andId id: IdType) -> CGFloat? {
        if let height = sizeCache[id]?[width] {
            return height
        }

        return nil
    }

    func cache(size: CGSize, forId id: IdType) {
        if sizeCache[id] == nil {
            sizeCache[id] = [:]
        }

        sizeCache[id]?[size.width] = size.height
    }

    func clearCache() {
        sizeCache.removeAll()
    }
}
