//
//  ToolsMainViewController.swift
//  Cram
//
//  Created by Harly on 16/8/17.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ToolsMainViewController: BaseViewController   {
    
    let cellIdentifier = "toolsTableViewIdentifier"
    
    let toolMainViewModel = MainToolViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var toolsTableView: UITableView!
    let toolDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ToolItemViewModel>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CramNavigator.globalNavigator
        .registerNavigationPara("showQRScannerIdentifier", sourceVc: self, callBack: nil)
    }
    
    
    /**
     UIConfiguration
     */
    override func configUI()
    {
        toolsTableView.registerNib(UINib.init(nibName: "ToolsTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
        toolsTableView.estimatedRowHeight = 66
        toolsTableView.rowHeight = UITableViewAutomaticDimension
        toolsTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    /**
     ViewModel Configuration
     */
    override func configViewModel()
    {
        toolDataSource.configureCell = {
            [weak self] _, tableView, indexPath, toolData in
            
            guard let strongSelf = self else { return UITableViewCell() }
            
            let cell = tableView.dequeueReusableCellWithIdentifier(strongSelf.cellIdentifier, forIndexPath: indexPath) as! ToolsTableViewCell
            cell.tag = indexPath.row
            cell.toolViewModel = toolData
            return cell
        }

        guard let toolDatas = toolMainViewModel.toolsViewModels else { return }
        toolDatas.asObservable().bindTo(toolsTableView.rx_itemsWithDataSource(toolDataSource))
            .addDisposableTo(disposeBag)
        
        toolsTableView.rx_itemSelected.subscribeNext { [weak self] (indexPath) in
            guard let strongSelf = self else { return }
            
            let sectionTool = toolDatas.value[indexPath.section]
            let tool = sectionTool.items[indexPath.row]
            let toolIdentifier = tool.toolIdentifier.value
            
            CramNavigator.globalNavigator.navigateToIdentifier(toolIdentifier, parameter: "")
            
            //            performSegueWithIdentifier(toolIdentifier, sender: nil)
            strongSelf.toolsTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }.addDisposableTo(disposeBag)
    }
    
}


