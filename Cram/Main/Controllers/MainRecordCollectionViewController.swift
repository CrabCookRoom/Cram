//
//  MainRecordCollectionViewController.swift
//  Cram
//
//  Created by Harly on 16/8/19.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import Bond

class MainRecordCollectionViewController: BaseViewController {
    
    let mainRecordCellIdentifier = "manRecordIdentifier"
    
    @IBOutlet weak var recordCollection: UICollectionView!
        {
        didSet
        {
            recordCollection.registerNib(UINib(nibName: "MainRecordCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: mainRecordCellIdentifier)
            
            let layout = recordCollection.collectionViewLayout as! PBDCarouselCollectionViewLayout
            
            layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width/2 , height: 230)
            layout.interItemSpace = 10
            recordCollection.decelerationRate = UIScrollViewDecelerationRateFast
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dataSource =  ObservableArray([ObservableArray(["1","2","3","4","5"])])
        dataSource.bindTo(recordCollection) {[weak self] (indexPath, dataSource, collectionView) -> UICollectionViewCell in
            guard let strongSelf = self else { return UICollectionViewCell() }
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(strongSelf.mainRecordCellIdentifier, forIndexPath: indexPath) as! MainRecordCell
            return cell
        }
    }
}

extension MainRecordCollectionViewController : UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

//        let navigationMode = NavigationMode.Push({ (vc)  in } , true )
        
//        CramNavigator.globalNavigator.navigateToVc(navigationMode, fromVc: self ,targetVc: TestMainViewController())
        
        CramNavigator.globalNavigator.navigateToIdentifier("showRecordDetailSegue", parameter: "harly")
    }
}

