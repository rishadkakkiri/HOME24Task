//
//  ReviewCollectionCell.swift
//  home24
//
//  Created by Beegains on 25/07/18.
//  Copyright © 2018 Beegains. All rights reserved.
//

import UIKit

class ReviewCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var ArticleImage: UIImageView!
    
    @IBOutlet weak var CellBackgroundView: UIView!
    
    @IBOutlet weak var ArticleReviewStatusImage: UIImageView!
    
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var TitleLabelLeadingConstraints: NSLayoutConstraint!
    @IBOutlet weak var ImgArticleLeadingConstraints: NSLayoutConstraint!
    @IBOutlet weak var ImgArticleWidthConstraints: NSLayoutConstraint!
}
