//
//  CramTableViewDelegateProxy.swift
//  Cram
//
//  Created by Harly on 16/9/5.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

/// CramProxy for tableView didSelect
/// Use rx_itemSelected instead currently.
class CramTableViewDelegateProxy : DelegateProxy ,UITableViewDelegate ,DelegateProxyType
{
    static func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let tableView = object as! UITableView
        return tableView.delegate
    }
    
    static func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let tableView = object as! UITableView
        tableView.delegate = delegate as? UITableViewDelegate
    }
}

private extension Selector {
    static let didSelectRowAtIndexPath =
        #selector(UITableViewDelegate
            .tableView(_:didSelectRowAtIndexPath:))
}

extension UITableView
{
    var rxTableViewDelegate : CramTableViewDelegateProxy
    {
        return CramTableViewDelegateProxy.proxyForObject(self)
    }
    
    var rxTableViewDidSelectAtIndexPath : Observable<(UITableView , NSIndexPath)>{
        return rxTableViewDelegate.observe(.didSelectRowAtIndexPath)
            .map { params in
                return (params[0] as! UITableView,
                    params[1] as! NSIndexPath)
        }
    }
}