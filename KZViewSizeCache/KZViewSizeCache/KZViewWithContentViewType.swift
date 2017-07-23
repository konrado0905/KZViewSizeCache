//
//  KZViewWithContentViewType.swift
//  KZProject
//
//  Created by Konrad Zdunczyk on 23/07/2017.
//  Copyright © 2017 Konrad Zdunczyk. All rights reserved.
//

import UIKit

internal protocol KZViewWithContentViewType {
    var contentView: UIView { get }
}

extension UICollectionViewCell: KZViewWithContentViewType { }
extension UITableViewCell: KZViewWithContentViewType { }
