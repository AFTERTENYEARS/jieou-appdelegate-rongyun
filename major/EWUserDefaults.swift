//
//  practice-rongyun
//
//  Created by 李书康 on 2018/12/24.
//  Copyright © 2018 com.li.www. All rights reserved.
//

import Foundation
///群组聊天标识
let GROUPMESSAGEKEY = "groupMessageNum"
///个人聊天标识
let PERSONMESSAGEKEY = "personMessageNum"

///将消息数量存储进userDefaults,获取message存储字典.如果没有则新建
func getMessageDic(_ key: String) -> Dictionary<String,Int>{
    var dic = UserDefaults.standard.value(forKey: key)
    if dic == nil {
        dic = Dictionary<String,Int>()
        UserDefaults.standard.setValue(dic, forKey: key)
    }
    return dic as! Dictionary<String, Int>
}
