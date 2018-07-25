//
//  ReviewScreenController.swift
//  home24
//
//  Created by Beegains on 24/07/18.
//  Copyright © 2018 Beegains. All rights reserved.
//

import UIKit

class ReviewScreenController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //TODO:- Outlets
    @IBOutlet weak var BtnListViewOutLet: UIButton!
    @IBOutlet weak var BtnGridViewOutLet: UIButton!
    @IBOutlet weak var ArticleReviewCollectionView: UICollectionView!
    
    //TODO:- Variables
    
    // ViewTypeStatusFlag IS USED TO INDICATE WHETHER ITS IN LIST VIEW OR GRID VIEW IF THE ViewTypeStatusFlag IS 1 MEANS ITS GRID VIEW IF IS IS 2 MEANS ITS LIST VIEW IS ACTIVE ,DEFUALT IT WILL BE ON GRID VIEW
    var ViewTypeStatusFlag  = 1
    var ArticleList:[ArticleMDL]=[ArticleMDL]()
    
    //TODO:- Main
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //TODO:- Collection View Deligate functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return ArticleList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionCell_id", for: indexPath) as! ReviewCollectionCell
        
        // CELL BACKGROUND VIEW ALTRATION
        cell.CellBackgroundView.layer.cornerRadius=5
        cell.CellBackgroundView.layer.shadowColor=UIColor.lightGray.cgColor
        cell.CellBackgroundView.layer.shadowOpacity=0.5
        cell.CellBackgroundView.layer.shadowOpacity=10.0
        cell.CellBackgroundView.layer.shadowOffset = .zero
        cell.CellBackgroundView.layer.shadowPath=UIBezierPath(rect: cell.CellBackgroundView.bounds).cgPath
        cell.CellBackgroundView.layer.shouldRasterize=true
        cell.CellBackgroundView.clipsToBounds=true
        cell.LblTitle.text=ArticleList[indexPath.row].title
        
        //URL STRING CONVERTING TO URL, HERE AM USING sd webimage FRAMEWORK FOR CACHE THE IMAGE FOR BATTER LOADING AND AM USING ONE PLACEHOLDER INMAGE
        let image_url : URL = NSURL(string: ArticleList[indexPath.row].image_link)! as URL
        cell.ArticleImage.sd_setImage(with:image_url, placeholderImage:UIImage.init(named: "Placeholder"))
        
        //  THIS CONDITION IS USED SHOW THAT LIKED IMAGE AND DILIKED IMAGE IF THE like_status IS 2 MEANS ITS DISLIKED AND IF ITS 1 MEANS LIKED
        if ArticleList[indexPath.row].like_status == 2
        {
            cell.ArticleReviewStatusImage.image=UIImage(named: "dislike_rev")
        }
        else
        {
            cell.ArticleReviewStatusImage.image=UIImage(named: "like_rev")
            
        }
        
        // ViewTypeStatusFlag IS USED TO INDICATE WHETHER ITS IN LIST VIEW OR GRID VIEW IF THE ViewTypeStatusFlag IS 1 MEANS ITS GRID VIEW IF IS IS 2 MEANS ITS LIST VIEW IS ACTIVE ,DEFUALT IT WILL BE ON GRID VIEW
        if ViewTypeStatusFlag == 1
        {
            cell.ImgArticleLeadingConstraints.constant = 0
            cell.TitleLabelLeadingConstraints.constant = 0
            return cell
        }
        else
        {
            
            cell.ImgArticleLeadingConstraints.constant = cell.frame.size.width - cell.ImgArticleWidthConstraints.constant
            cell.TitleLabelLeadingConstraints.constant = 8
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        // CHECKING THE VIEW TYPE GRID OR LIST
        if ViewTypeStatusFlag == 1
        {
            
            return CGSize(width: 116, height: 100)
        }
        else
        {
            return CGSize(width: ArticleReviewCollectionView.frame.size.width, height: 100)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
    
    //TODO:- Actions
    
    @IBAction func BtnListViewAction(_ sender: UIButton)
    {
        if ViewTypeStatusFlag != 2
        {
        ViewTypeStatusFlag = 2
        ArticleReviewCollectionView.reloadData()
        }
    }
    
    @IBAction func BtnGridViewAction(_ sender: UIButton)
    {
        if ViewTypeStatusFlag != 1
        {
        ViewTypeStatusFlag = 1
        ArticleReviewCollectionView.reloadData()
        }
        
    }
    
    
}
