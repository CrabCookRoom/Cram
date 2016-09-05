//
//  MainViewController.swift
//  Cram
//
//  Created by Harly on 16/8/17.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import Bond

class MainViewController: BaseViewController {

    var recordVc : MainRecordCollectionViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CramNavigator.globalNavigator.registerNavigationPara("showRecordDetailSegue", sourceVc: self, callBack: { paramenter , destinationController in
        
            guard paramenter is String else { return }
            guard destinationController is RecordDetailViewController else { return }
            
            let stringPara = paramenter as! String
            let destVc = destinationController as! RecordDetailViewController
            destVc.testPara = stringPara
            
        } )
        
        
    }
    
    override func configUI() {

    }
    
    override func configViewModel() {
        
    }
}





