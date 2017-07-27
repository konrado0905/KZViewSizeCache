//
//  KZViewHeightCalculator.swift
//  KZProject
//
//  Created by Konrad Zdunczyk on 23/07/2017.
//  Copyright © 2017 Konrad Zdunczyk. All rights reserved.
//

import UIKit

class KZViewHeightCalculator {
    typealias ViewType = UIView & KZSizingItem

    let view: ViewType
    let viewWidthConstraint: NSLayoutConstraint

    private let sizingView: UIView

    init(view: ViewType) {
        self.view = view
        self.sizingView = view.sizingView

        view.translatesAutoresizingMaskIntoConstraints = false
        if !view.autoresizingMask.contains([.flexibleHeight, .flexibleWidth]) {
            sizingView.autoresizingMask.update(with: [.flexibleHeight, .flexibleWidth])
        }

        if let widthConstraint = KZViewHeightCalculator.getViewsWidthConstraint(view: view) {
            viewWidthConstraint = widthConstraint
        } else {
            viewWidthConstraint = NSLayoutConstraint(item: view,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 0)

            viewWidthConstraint.isActive = true
        }
    }

    func calculateSize(forWidth viewWidth: CGFloat, heightRoundUp: Bool = true) -> CGSize {
        // Preparing view
        if viewWidthConstraint.constant != viewWidth {
            viewWidthConstraint.constant = viewWidth
        }

        // Calculating
        view.setNeedsLayout()
        view.layoutIfNeeded()

        var itemHeight = sizingView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        itemHeight += view.additionalHeight
        if heightRoundUp {
            itemHeight = ceil(itemHeight)
        }

        return CGSize(width: viewWidth, height: itemHeight)
    }

    private class func getViewsWidthConstraint(view: UIView) -> NSLayoutConstraint? {
        return view.constraints.filter {
            ($0.firstItem as? UIView) == view &&
                $0.firstAttribute == .width &&
                $0.secondAttribute == .notAnAttribute &&
                $0.secondItem == nil &&
                $0.relation == .equal
            }.first
    }
}
