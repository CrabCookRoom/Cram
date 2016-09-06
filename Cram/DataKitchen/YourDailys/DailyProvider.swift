//
//  DailyProvider.swift
//  Cram
//
//  Created by Harly on 16/9/6.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

struct DailyItem : BaseModel {
    var dailyDate : NSDate?
    var dailyId : Int?
    var dailyScore : Int?
    var dailyComment : String?
}


class DailyProvider: NSObject {
    static let dailys : [DailyItem] = {
        let plistPath = NSBundle.mainBundle().pathForResource("MyDailysList", ofType: "plist")
        
        var dailyList = [DailyItem]()
        NSArray(contentsOfFile: plistPath!)?.forEach({ (item) in
            if let dailyDic = item as? [String : AnyObject]
            {
                dailyList.append(DailyItem(dailyDate: dailyDic["dailyDate"] as? NSDate, dailyId: dailyDic["dailyId"] as? Int,
                    dailyScore: dailyDic["dailyScore"] as? Int,
                    dailyComment: dailyDic["dailyComment"] as? String))
            }
            
        })
        return dailyList
    }()
}
