//
//  ToolItemViewModel.swift
//  Cram
//
//  Created by Harly on 16/8/17.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import RxSwift
import RxDataSources

class ToolItemViewModel : BaseViewModel
{
    let toolName : Variable<String>
    let toolDescription : Variable<String>
    let toolIcon : Variable<String>
    let toolIdentifier : Variable<String>
    let toolInstalled : Variable<Bool>
    
    init(model : ToolItem)
    {
        toolName = generateVariableVMPara(model.toolName)
        toolDescription = generateVariableVMPara(model.toolDescription)
        toolIcon = generateVariableVMPara(model.toolIcon)
        toolIdentifier = generateVariableVMPara(model.toolIdentifier)
        toolInstalled = generateVariableVMPara(model.toolInstalled)
    }
    
}
