//
//  ToolsTableViewCell.swift
//  Cram
//
//  Created by Harly on 16/8/17.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ToolsTableViewCell: UITableViewCell {

    @IBOutlet weak var toolIcon: UIImageView!
    @IBOutlet weak var toolDescriotionLabel: UILabel!
    @IBOutlet weak var titleView: UILabel!
    
    let disposeBag = DisposeBag()
    
    var toolViewModel : ToolItemViewModel?
        {
        didSet
        {
            if let realTool = toolViewModel
            {
                realTool.toolName.asDriver().drive(titleView.rx_text).addDisposableTo(disposeBag)
            
                realTool.toolDescription.asDriver()
                    .drive(toolDescriotionLabel.rx_text).addDisposableTo(disposeBag)
                
                realTool.toolIcon.asDriver().map({ (imageUrl) -> UIImage in
                    if let image = UIImage(named: imageUrl)
                    {
                        return image
                    }
                    else
                    {
                        return UIImage(named: "ic_Tab_mainTool_Selected")!
                    }
                }).asDriver().drive(toolIcon.rx_image).addDisposableTo(disposeBag)
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
