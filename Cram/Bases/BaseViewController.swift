//
//  BaseViewController.swift
//  Cram
//
//  Created by Harly on 16/8/17.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import Bond

protocol ICramViewController {
    
    func configViewModel()
    
    func configUI()
}

class BaseViewController: UIViewController    {

    override func viewDidLoad() {
        super.viewDidLoad()


        if let backBtn = cramBackBtn()
        {
            backBtn.bnd_tap.observe({ [weak self](_) in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.popViewControllerAnimated(true)
            })
        }
        
        configUI()
        
        configViewModel()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func cramBackBtn() -> UIButton?
    {
        return nil
    }
    
    func configViewModel()
    {
        
    }
    
    func configUI()
    {
        
    }
    
}



