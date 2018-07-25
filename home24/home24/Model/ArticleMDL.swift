//
//  ArticleMDL.swift
//  home24
//
//  Created by Beegains on 24/07/18.
//  Copyright © 2018 Beegains. All rights reserved.
//

import UIKit

class ArticleMDL: NSObject {
    
    var sku:String=String()
    var title:String=String()
    var image_link:String=String()
    
    //like_status = 0 FOR NON
    //like_status = 1 FOR LIKE
    //like_status = 2 FOR DISLIKE
    var like_status:Int=Int()
}
