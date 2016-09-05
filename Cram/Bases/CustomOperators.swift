//
//  CustomOperators.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/15.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

infix operator <-> { precedence 130 associativity left }
func <-><T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let variableToProperty = variable.asObservable()
        .bindTo(property)
    
    let propertyToVariable = property
        .subscribe(onNext: {
            variable.value = $0
            }, onCompleted: {
                variableToProperty.dispose()
        })
    
    return StableCompositeDisposable.create(variableToProperty, propertyToVariable)
}

