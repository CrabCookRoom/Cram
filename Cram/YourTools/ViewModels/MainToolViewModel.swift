//
//  MainToolViewModel.swift
//  Cram
//
//  Created by Harly on 16/8/17.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import RxSwift
import SINQ
import RxDataSources

class MainToolViewModel
{
    var toolsViewModels : Variable<[SectionModel<String, ToolItemViewModel>]>?
    
    init()
    {
        let toolDatas = sinq(ToolProvider.tools).whereTrue({ (item) -> Bool in
            return item.toolInstalled!
        }).select { (item, _) -> ToolItemViewModel in
            let toolVM = ToolItemViewModel(model: item)
            return toolVM
            }.toArray()
        toolsViewModels = Variable([SectionModel(model: "", items: toolDatas)])
    }
}
