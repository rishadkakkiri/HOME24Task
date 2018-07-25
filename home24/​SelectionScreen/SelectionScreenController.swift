//
//  SelectionScreenController.swift
//  home24
//
//  Created by Beegains on 24/07/18.
//  Copyright © 2018 Beegains. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class SelectionScreenController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //TODO:- Outlets
    @IBOutlet weak var ReviewBtnHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var MessageBoxViewNoImage: UIView!
    @IBOutlet weak var ActivityLoadingOutlet: UIActivityIndicatorView!
    @IBOutlet weak var ArticleCollectionView: UICollectionView!
    @IBOutlet weak var BtnReviewOutlet: UIButton!
    //TODO:- Variables
    
    // ArticleList HOLD THE ARTICLES AFTER THE API CALL
    var ArticleList:[ArticleMDL]=[ArticleMDL]()
    //TODO:- Main
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //THIS IS USED TO ALTER THE ALERT BOX FOR NO INAME
        MessageBoxViewNoImage.layer.cornerRadius=6.0
        MessageBoxViewNoImage.layer.shadowColor=UIColor.lightGray.cgColor
        MessageBoxViewNoImage.layer.shadowOpacity=0.5
        MessageBoxViewNoImage.layer.shadowOpacity=10.0
        MessageBoxViewNoImage.layer.shadowOffset = .zero
        MessageBoxViewNoImage.layer.shouldRasterize=true
        MessageBoxViewNoImage.clipsToBounds=true
        MessageBoxViewNoImage.isHidden=true
        ReviewBtnHeightConstraints.constant=0
        BtnReviewOutlet.alpha=0
        self.ActivityLoadingOutlet.hidesWhenStopped=true
        self.BtnReviewOutlet.isEnabled=false
        //UPCarouselFlowLayout IS USED TO ALTER THE COLLECTION VIEW STYLE AND ANIMATION ITS AN FRAMEWORK,I USED UPCarouselFlowLayout.swift FILE
        let floawLayout=UPCarouselFlowLayout()
        floawLayout.itemSize=CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: self.ArticleCollectionView.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale=0.8
        floawLayout.sideItemAlpha=1.0
        floawLayout.spacingMode = .fixed(spacing: 0.5)
        ArticleCollectionView.collectionViewLayout = floawLayout
        ArticleCollectionView.delegate=self
        ArticleCollectionView.dataSource=self
        // THSI FUNCTION IS USED FOR THE APL CALLING,FROM HERE THE API CALLING TAKE PLACE
        GetArticles()
        
        
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
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleSelectionCollectionCell_id", for: indexPath) as! ArticleSelectionCollectionCell
        //BACKGROUND VIEW ALTRATION OF THE CELL
        cell.CellBackgroundView.layer.cornerRadius=13.0
        cell.CellBackgroundView.layer.shadowColor=UIColor.lightGray.cgColor
        cell.CellBackgroundView.layer.shadowOpacity=0.5
        cell.CellBackgroundView.layer.shadowOpacity=10.0
        cell.CellBackgroundView.layer.shadowOffset = .zero
        cell.CellBackgroundView.layer.shadowPath=UIBezierPath(rect: cell.CellBackgroundView.bounds).cgPath
        cell.CellBackgroundView.layer.shouldRasterize=true
        cell.CellBackgroundView.clipsToBounds=true
        cell.LblArticlePosition.text="\(indexPath.row+1) / \(ArticleList.count)"
        //URL STRING CONVERTING TO URL, HERE AM USING sd webimage FRAMEWORK FOR CACHE THE IMAGE FOR BATTER LOADING AND AM USING ONE PLACEHOLDER INMAGE
        let image_url : URL = NSURL(string: ArticleList[indexPath.row].image_link)! as URL
        cell.ArticleImageView.sd_setImage(with:image_url, placeholderImage:UIImage.init(named: "Placeholder"))
        cell.BtnDisLikeOutlet.tag=indexPath.row
        cell.BtnLikeOutlet.tag=indexPath.row
        return cell
    }
    //TODO:-Actions
    @IBAction func BtnReviewAction(_ sender: UIButton)
    {
        let ReviewScreenControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "ReviewScreenController_id") as! ReviewScreenController
        ReviewScreenControllerObj.ArticleList=ArticleList
        self.navigationController?.pushViewController(ReviewScreenControllerObj, animated: true)
        
    }
    
    @IBAction func BtnArticleLikeAction(_ sender: UIButton)
    {
        if sender.tag < self.ArticleList.count-1
        {
            ArticleList[sender.tag].like_status=1
            let indexPath = IndexPath(item: sender.tag+1, section: 0)
            self.ArticleCollectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
            
        }
        else
        {
            if(ArticleList.last?.like_status != 0)
            {
                MessageBoxViewNoImage.isHidden=false
                Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(SelectionScreenController.hideMessageBox), userInfo: nil, repeats: false)
            }
            ArticleList[sender.tag].like_status=1
            
            ShowReviewButton()
            self.BtnReviewOutlet.isEnabled=true
        }
        
    }
    @IBAction func BtnArticleDisLikeAction(_ sender: UIButton)
    {
        
        if sender.tag < self.ArticleList.count-1
        {
            ArticleList[sender.tag].like_status=2
            
            let indexPath = IndexPath(item: sender.tag+1, section: 0)
            self.ArticleCollectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        }
        else
        {
            
            if(ArticleList.last?.like_status != 0)
            {  MessageBoxViewNoImage.isHidden=false
                
                Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(SelectionScreenController.hideMessageBox), userInfo: nil, repeats: false)
            }
            ArticleList[sender.tag].like_status=2
            ShowReviewButton()
            
            self.BtnReviewOutlet.isEnabled=true
        }
        
    }
    //TODO:- User Functions
    
    func ShowReviewButton()
    {
        
        
        UIView.animate(withDuration:0.5, animations: {

                self.ReviewBtnHeightConstraints.constant=59
                self.BtnReviewOutlet.alpha=1
                self.view.layoutIfNeeded()
                
                

        })
        
    }
    @objc func hideMessageBox()
    {
        self.MessageBoxViewNoImage.isHidden=true
    }
    func GetArticles()
    {
        // BEFORE MAKING THE APL CALL CHECKIMNG THE INTERNET IS AVALABE OR NOT
        if NetworkReachabilityManager()!.isReachable
        {
            self.ActivityLoadingOutlet.startAnimating()
            
            
            // Alamofire FRAMEWORK IS USING FOR API CALLING
            Alamofire.request(AppURLS.ArticleLink, method: .get)
                .responseJSON { response in
                    guard response.result.error == nil else {
                        self.ActivityLoadingOutlet.stopAnimating()
                        
                        if let error = response.result.error {
                            print("Error: \(error)")
                        }
                        
                        return
                    }
                    
                    self.ActivityLoadingOutlet.stopAnimating()
                    let result=response.value as AnyObject
                    
                    let _embedded=result["_embedded"] as AnyObject
                    let articles = _embedded["articles"] as! [AnyObject]
                    
                    for item in articles
                    {
                        let ArticleItem:ArticleMDL=ArticleMDL()
                        ArticleItem.sku=item["sku"] as! String
                        ArticleItem.title=item["title"] as! String
                        ArticleItem.like_status=0
                        
                        var image_urls=item["media"] as! [AnyObject]
                        ArticleItem.image_link=image_urls[0]["uri"] as! String
                        
                        self.ArticleList.append(ArticleItem)
                        
                        
                    }
                    DispatchQueue.main.async {
                        self.ArticleCollectionView.reloadData()
                    }
            }
            
        }
        else
        {
            
            let alert = UIAlertController(title: "Alert", message: "Internet is not rechable", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler:  { action in
                self.GetArticles()
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:  { action in
                
                self.GoBack()
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func GoBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//TODO:-Extension
extension UIButton {
    // AM ADDING pulsateOne EXTENTION IN BUTTON FOR PULSING ANIMATION FOR THE BUTTON
    func pulsateOne() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.2
        pulse.damping = 0.2
        
        layer.add(pulse, forKey: "pulse")
    }
    
}
