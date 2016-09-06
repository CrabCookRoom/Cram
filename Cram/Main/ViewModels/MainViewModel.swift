//
//  MainViewModel.swift
//  Cram
//
//  Created by Harly on 16/9/6.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import RxSwift
import SINQ
import RxDataSources

class MainViewModel
{
    var dailyCramsViewModels : Variable<[SectionModel<String, DailyCramViewModel>]>?
    
    init()
    {
        let dailyDatas = sinq(DailyProvider.dailys).whereTrue({ (item) -> Bool in
            return true
        }).select { (item, _) -> DailyCramViewModel in
            let dailyVM = DailyCramViewModel(model: item)
            return dailyVM
            }.toArray()
        dailyCramsViewModels = Variable([SectionModel(model: "", items: dailyDatas)])
    }
}
