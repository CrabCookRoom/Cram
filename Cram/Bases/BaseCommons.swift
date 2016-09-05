//
//  BaseCommons.swift
//  Cram
//
//  Created by Harly on 16/8/17.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

protocol BaseModel {
    
}


import RxSwift
import RxDataSources

class BaseViewModel : NSObject {
    
}


/**
 将普通model转化为VM中用的Variable属性
 
 - parameter modelPara: model中属性
 
 - returns: VM中使用属性
 */
func generateVariableVMPara<T:Hashable>( modelPara : T? ) -> Variable<T> {
    if let realPara = modelPara
    {
        return Variable(realPara)
    }
    else
    {
        if T.self == String.self
        {
            return Variable("" as! T)
        }
        else if T.self == Double.self
        {
            return Variable(0 as! T)
        }
        else if T.self == Int.self
        {
            return Variable(0 as! T)
        }
        else if T.self == Bool.self
        {
            return Variable(false as! T)
        }
        else
        {
            //More types to added
            assert(true, "Unknow type in vm generation -> \(T.self)")
            print("generation failed")
            return Variable("" as! T)
        }
        
    }
}


