//
//  GlobalNavigator.swift
//  Cram
//
//  Created by Harly on 16/8/25.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit

/// Navigator模块 在vc中不再执行perform和prepare
// MARK: - Storyboard support
class CramNavigator : NSObject
{
    
    // MARK: - Fields
    static let globalNavigator = CramNavigator()
    
    typealias destinationVcCallback = (paraToPass : AnyObject , destinationVc : BaseViewController) -> Void
    
    private var globalNavigations = [(segueIdentifier : String , sourceVc : BaseViewController , beforeNav:destinationVcCallback?)]()
    
    // MARK: - Publics
    /**
     注册navigation
     所有identifier都必须注册后才能正常perform
     
     - parameter identifier: segue identifier
     - parameter sourceVc:   触发push的vc
     - parameter callBack:   需要在push时执行的操作
     */
    func registerNavigationPara(identifier : String,sourceVc:BaseViewController , callBack :destinationVcCallback?)
    {
        globalNavigations.append((identifier, sourceVc, callBack))
    }
    
    /**
     执行navigation
     未被注册的identifier无法执行
     
     - parameter identifer: 执行的segue identifier
     - parameter parameter: push时所需要的参数
     */
    func navigateToIdentifier(identifer:String , parameter : AnyObject)
    {
        let navigationDetail = findIdentifierInStore(identifer)
        
        guard let realDetail = navigationDetail else
        {
            print("Identifier: " + identifer + " ---" + "Navigation not registered.")
            return
        }
        
        //将vc中的prepare for segue找粗来替换
        let segueSelector = #selector(UIViewController.prepareForSegue(_:sender:))
        
        //用以替换的segue方法
        let swizzledSegueSelector = #selector(cramPerformSegue(_: sender:))
        
        let originalMethod = class_getInstanceMethod(BaseViewController.self, segueSelector)

        let swizzledMethod = class_getInstanceMethod(CramNavigator.self, swizzledSegueSelector)
        
        //最终执行的block
        let finalSegueBlock: @convention(block) (AnyObject,UIStoryboardSegue,AnyObject?) -> Void = { _, segue, obj in
            
            guard let identifier = segue.identifier else
            {
                print("No segueIdentifier defined while performing.")
                return
            }
            
            let navigationDetail = CramNavigator.globalNavigator.findIdentifierInStore(identifier)
            
            guard let realDetail = navigationDetail else
            {
                print("Identifier: " + identifier + " ---" + "cannot be found while performing")
                return
            }
            
            guard let navigationPreparation = realDetail.beforeNav else
            {
                print("Identifier: " + identifier + " succeeed performed without closures. ")
                return
            }
            
            guard segue.destinationViewController is BaseViewController else
            {
                print("Identifier: " + identifier + " failed performed since the destination vc is not inherited from BaseVc")
                return
            }
            
            let destVc = segue.destinationViewController as! BaseViewController
            
            navigationPreparation(paraToPass: parameter, destinationVc: destVc)
        }
        
        let objBlock : AnyObject = unsafeBitCast(finalSegueBlock, AnyObject.self)
        
        //将最终的block替换当前的swizzle的method，即swizzle替换performSegue后，用block替换
        //swizzle
        method_setImplementation(swizzledMethod , imp_implementationWithBlock(objBlock))
        
        let didAddMethod = class_addMethod(BaseViewController.self, segueSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod
        {
            class_replaceMethod(BaseViewController.self, swizzledSegueSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else
        {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        //最终执行segue
        realDetail.sourceVc.performSegueWithIdentifier(realDetail.segueIdentifier, sender: nil)
    }
    
    // MARK: - Privates
    private func findIdentifierInStore(identifier:String) -> (segueIdentifier : String , sourceVc : BaseViewController , beforeNav:destinationVcCallback?)? {
        let navigationDetail = globalNavigations.filter { (storedIdentifier,_,_) -> Bool in
            return storedIdentifier == identifier
            }.first
        return navigationDetail
    }
    
    func cramPerformSegue(segue : UIStoryboardSegue , sender : AnyObject?)
    {
        
    }
    
}

// MARK: - Xib support
extension CramNavigator
{
    /**
     Navigate至xib创建的vc
     
     - parameter navigationMode: NavigationMode: Push/Present
     - parameter fromVc:         源Vc
     - parameter targetVc:       即将被推送的vc
     */
    func navigateToVc<T : BaseViewController>(navigationMode : NavigationMode , fromVc : BaseViewController ,targetVc : T = T())
    {
        
        switch navigationMode {
        case .Present(let navBlock , let animated):
            navBlock(targetVc)
            fromVc.presentViewController(targetVc, animated: animated, completion: nil)
        case .Push(let navBlock , let animated):
            
            if let navVc = fromVc.navigationController
            {
                navBlock(targetVc)
                navVc.pushViewController(targetVc, animated: animated)
            }
            else
            {
                print("The controller hasn't embedded in NavigationVc, performing presenting instead.")
                navBlock(targetVc)
                fromVc.presentViewController(targetVc, animated: animated, completion: nil)
            }
        }
    }
}

enum NavigationMode
{
    case Push((BaseViewController)->Void , Bool)
    case Present((BaseViewController)->Void ,Bool)
}

