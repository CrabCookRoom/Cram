//
//  RecordDetailViewController.swift
//  Cram
//
//  Created by Harly on 16/8/24.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit

class RecordDetailViewController: BaseViewController {
    @IBOutlet weak var backToMainBtn: UIButton!

    @IBOutlet weak var currentScore: UILabel!
    var testPara = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(testPara)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func cramBackBtn() -> (UIButton?) {
        return backToMainBtn
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
