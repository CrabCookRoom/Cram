//
//  CramProfileStepOneControllerViewController.swift
//  Cram
//
//  Created by Harly on 16/9/6.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import RxSwift

class CramProfileStepOneControllerViewController: BaseViewController
{

    @IBOutlet weak var myNameTextField: UITextField!
    @IBOutlet weak var myJobTextField: UITextField!
    @IBOutlet weak var nextBtn: UIControl!
    
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func configViewModel() {
        
        //Step 1. UI元素双向绑定呐
        myNameTextField.rx_text <-> profileViewModel.myName
        myJobTextField.rx_text <-> profileViewModel.myJob
        
        //Step 2. 验证功能添加
        let nameValidationObserve = myNameTextField.rx_text.map { $0 != "" }
        let jobValidationObserve = myJobTextField.rx_text.map { $0 != "" }
        
        //两者都有才能看到next按钮哟
        Observable.combineLatest(nameValidationObserve, jobValidationObserve)
        { [$0, $1] }.map { CGFloat($0.reduce(true, combine: { $0 && $1 } )) }.subscribeNext({[weak self] (alpha) in
            guard let strongSelf = self else { return }
            UIView.animateWithDuration(0.4, animations: {
                strongSelf.nextBtn.alpha = alpha
            })
            
        }).addDisposableTo(disposeBag)
    }
    
    override func configUI() {
        nextBtn.rx_controlEvent(.TouchUpInside).subscribeNext { (_) in
            print("next tapped")
        }.addDisposableTo(disposeBag)
    }

}
