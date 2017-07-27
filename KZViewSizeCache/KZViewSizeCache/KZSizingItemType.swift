//
//  KZSizingItemType.swift
//  KZProject
//
//  Created by Konrad Zdunczyk on 23/07/2017.
//  Copyright © 2017 Konrad Zdunczyk. All rights reserved.
//

import UIKit

enum KZSizingItemType {
    case cell
    case header
    case footer
}

protocol KZSizingItem {
    var sizingView: UIView { get }
    var additionalHeight: CGFloat { get }
}

extension KZSizingItem where Self: UIView {
    var additionalHeight: CGFloat {
        return 0
    }

    var sizingView: UIView {
        if let withContentView = self as? KZViewWithContentViewType {
            return withContentView.contentView
        }

        return self
    }
}
