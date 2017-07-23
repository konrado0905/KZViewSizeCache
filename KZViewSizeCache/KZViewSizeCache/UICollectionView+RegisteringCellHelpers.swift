//
//  UICollectionView+RegisteringCellHelpers.swift
//  KZProject
//
//  Created by Konrad Zdunczyk on 23/07/2017.
//  Copyright © 2017 Konrad Zdunczyk. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(nibNamed nibName: String, forCellWithReuseIdentifier reuseIdentifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func register(nibNamed nibName: String, forSupplementaryViewOfKind kind: String, withReuseIdentifier reuseIdentifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
    }
}
