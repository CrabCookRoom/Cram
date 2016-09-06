//
//  MainViewController.swift
//  Cram
//
//  Created by Harly on 16/8/17.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var profileBtn: UIButton!
    var recordVc : MainRecordCollectionViewController!
    let mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let recordDetailVc = childViewControllers.filter({ (vc) -> Bool in
//            return vc is MainRecordCollectionViewController
//        }).first
//
//        if let record = recordDetailVc
//        {
//            recordVc = record as? MainRecordCollectionViewController
//            recordVc.mainViewModel = mainViewModel
//        }
        
        CramNavigator.globalNavigator.registerNavigationPara("showRecordDetailSegue", sourceVc: self, callBack: { paramenter , destinationController in
        
            guard paramenter is String else { return }
            guard destinationController is RecordDetailViewController else { return }
            
            let stringPara = paramenter as! String
            let destVc = destinationController as! RecordDetailViewController
            destVc.testPara = stringPara
            
        } )
        
        
        CramNavigator.globalNavigator.registerNavigationPara("showProfileSegue", sourceVc: self, callBack: { paramenter , destinationController in
            
        } )
        
        
    }
    
    override func configUI() {
        profileBtn.rx_tap.subscribeNext {(_) in
            CramNavigator.globalNavigator.navigateToIdentifier("showProfileSegue", parameter: "")
        }.addDisposableTo(disposeBag)
    }
    
    override func configViewModel() {
        
    }
}





