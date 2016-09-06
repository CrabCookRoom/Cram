//
//  MainRecordCell.swift
//  Cram
//
//  Created by Harly on 16/8/19.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class MainRecordCell: UICollectionViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var dailyViewModel : DailyCramViewModel?
    {
        didSet
        {
            guard let dailyVm = dailyViewModel else { return }
            dailyVm.dailyScore.asDriver().map{ "\($0)" }.drive(scoreLabel.rx_text).addDisposableTo(disposeBag)
        }
    }

}
