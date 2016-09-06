//
//  MainRecordCollectionViewController.swift
//  Cram
//
//  Created by Harly on 16/8/19.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class MainRecordCollectionViewController: BaseViewController {
    
    let mainRecordCellIdentifier = "manRecordIdentifier"
    
    let mainViewModel = MainViewModel()
    
    let dailyDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, DailyCramViewModel>>()
    
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

    }
    
    override func configViewModel() {
        guard let dailyData = mainViewModel.dailyCramsViewModels else { return }
        
        dailyDataSource.configureCell = {
            [weak self] _, collectionView, indexPath, dailyData in
            
            guard let strongSelf = self else { return UICollectionViewCell() }
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(strongSelf.mainRecordCellIdentifier, forIndexPath: indexPath) as! MainRecordCell
            cell.tag = indexPath.row
            cell.dailyViewModel = dailyData
            return cell
        }
        
        dailyData.asObservable().bindTo(recordCollection.rx_itemsWithDataSource(dailyDataSource))
            .addDisposableTo(disposeBag)
        
        recordCollection.rx_itemSelected.subscribeNext { (indexPath) in
            CramNavigator.globalNavigator
                .navigateToIdentifier("showRecordDetailSegue", parameter: "harly")
        }.addDisposableTo(disposeBag)
    }
}

