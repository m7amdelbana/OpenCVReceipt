//
//  PhotoCell.swift
//  OpenCVReceipt
//
//  Created by Mohamed Elbana on 3/23/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    func setupCell(_ image: UIImage, _ count: Int) {
        img.image = image
        if count != 0 && count != 1 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
