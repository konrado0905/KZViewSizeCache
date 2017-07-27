//
//  StringCell.swift
//  KZProject
//
//  Created by Konrad Zdunczyk on 23/07/2017.
//  Copyright © 2017 Konrad Zdunczyk. All rights reserved.
//

import UIKit

class StringCell: UICollectionViewCell, KZSizingItem {
    @IBOutlet weak var lblString: UILabel!

    var additionalHeight: CGFloat {
        return 70
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
