//
//  DailyCramViewModel.swift
//  Cram
//
//  Created by Harly on 16/9/6.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import RxSwift
import RxDataSources

class DailyCramViewModel: BaseViewModel
{
    let dailyDate : Variable<NSDate>
    let dailyId : Variable<Int>
    let dailyScore : Variable<Int>
    let dailyComment : Variable<String>
    
    init(model : DailyItem)
    {
        dailyDate = generateVariableVMPara(model.dailyDate)
        dailyId = generateVariableVMPara(model.dailyId)
        dailyScore = generateVariableVMPara(model.dailyScore)
        dailyComment = generateVariableVMPara(model.dailyComment)
    }
}
