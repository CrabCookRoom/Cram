//
//  ToolProvider.swift
//  Cram
//
//  Created by Harly on 16/8/17.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

struct ToolItem : BaseModel {
    var toolName : String?
    var toolDescription : String?
    var toolIcon : String?
    var toolIdentifier : String?
    var toolInstalled : Bool?
}

struct ToolProvider {
    static let tools : [ToolItem] = {
        let plistPath = NSBundle.mainBundle().pathForResource("MyToolList", ofType: "plist")

        var toolList = [ToolItem]()
        NSArray(contentsOfFile: plistPath!)?.forEach({ (item) in
            if let toolDic = item as? [String : AnyObject]
            {
                toolList.append(ToolItem(toolName: toolDic["toolName"] as? String, toolDescription: toolDic["toolDescription"] as? String,
                    toolIcon: toolDic["toolIcon"] as? String,
                    toolIdentifier: toolDic["toolIdentifier"] as? String,
                    toolInstalled : toolDic["toolInstalled"] as? Bool ))
            }

        })
        
        return toolList
    }()
}
