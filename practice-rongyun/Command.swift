//
//  Command.swift
//  practice-rongyun
//
//  Created by 李书康 on 2018/12/25.
//  Copyright © 2018 com.li.www. All rights reserved.
//

import Foundation

private let appDelegate = UIApplication.shared.delegate as! AppDelegate

protocol Command {
    func execute()
}

struct InitializeExampleCommand: Command {
    func execute() {
        // 第三方库初始化代码
    }
}

final class StartupCommandsBuilder {
    
    func setKeyWindow(window: UIWindow) -> StartupCommandsBuilder {
        window.frame = UIScreen.main.bounds
        appDelegate.window = window
        appDelegate.window?.backgroundColor = UIColor.white
        appDelegate.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        appDelegate.window?.makeKeyAndVisible()
        return self
    }
    
    func build() -> [Command] {
        return [
            InitializeRongCloudCommand()
        ]
    }
}

//MARK: 融云
struct InitializeRongCloudCommand: Command {
    func execute() {
        ///在官网上申请的App Key. 同时获取的App Secret我们并不需要,是后台需要的.
        RCIM.shared().initWithAppKey("y745wfm8yjzbv")
        ///是否将用户信息和群组信息在本地持久化存储
        RCIM.shared().enablePersistentUserInfoCache = false
        ///是否在发送的所有消息中携带当前登录的用户信息
        RCIM.shared().enableMessageAttachUserInfo = true
        ///收到信息的代理
        RCIM.shared().receiveMessageDelegate = appDelegate
        ///用户信息提供代理
        RCIM.shared().userInfoDataSource = RCIMDataSource
        RCIM.shared().groupInfoDataSource = RCIMDataSource
        RCIM.shared().groupUserInfoDataSource = RCIMDataSource
        
        ///融云并不管理用户信息,不管是登录账号还是与之聊天的人的信息,所以我们需要在连接融云服务器时就将登录账号的昵称与头像设定好.这样才能在会话页显示正确的数据
        /// token也是从后台获取,理论上顺序是登录时获取后台传来的token,再使用这个token链接融云服务.
        RCIM.shared().connect(withToken: "dQBWciyYegIh7UpkkirIqP/V9gk1Pf9ZryuCvogQH2pvFx4QxzGsb+jL8Kx0zVRqv//9jeTWRkR5S5eole51Dw==", success: { (userId) in
            ///这两个都是从后台获取
            let username = "登录账号的昵称"
            let iconurl = "登录账号的头像路径"
            let currentUserInfo = RCUserInfo(userId: userId!, name: username, portrait: iconurl)
            ///将设置的用户信息赋值给登录账号
            RCIM.shared().currentUserInfo = currentUserInfo
        }, error: { (error) in
            print("连接融云服务器失败， errpr：\(error)")
        }) {
            print("token错误")
        }
    }
}

//MARK: - 融云获取信息delegate
extension AppDelegate: RCIMReceiveMessageDelegate {
    /// 收到信息时的回调方法
    ///
    /// - Parameters:
    ///   - message: 信息主体
    ///   - left: 剩余数量,当一次有大量的信息传入时,融云选择重复调用这个方法的形式,left就是剩余未接收的信息数量
    func onRCIMReceive(_ message: RCMessage!, left: Int32) {
        switch message.conversationType {
        ///群组聊天数据
        case .ConversationType_GROUP:
            var dic = getMessageDic(GROUPMESSAGEKEY)
            ///以发送者的targetID作为Key将数量存储进字典
            guard var num = dic[message.targetId] else {
                dic[message.targetId] = 1
                UserDefaults.standard.setValue(dic, forKey: GROUPMESSAGEKEY)
                ///获取信息,发送通知
                NotificationCenter.default.post(name: Notification.Name(rawValue: "onRCIMReceive"), object: nil)
                return
            }
            ///如果字典内已经有发送者的targetID字段,将存储的消息数量加1
            num += 1
            dic[message.targetId] = num
            ///保存
            UserDefaults.standard.setValue(dic, forKey: GROUPMESSAGEKEY)
        ///个人聊天信息
        case .ConversationType_PRIVATE:
            var dic = getMessageDic(PERSONMESSAGEKEY)
            ///以发送者的targetID作为Key将数量存储进字典
            guard var num = dic[message.targetId] else {
                dic[message.targetId] = 1
                UserDefaults.standard.setValue(dic, forKey: PERSONMESSAGEKEY)
                ///获取信息,发送通知
                NotificationCenter.default.post(name: Notification.Name(rawValue: "onRCIMReceive"), object: nil)
                return
            }
            ///如果字典内已经有发送者的targetID字段,将存储的消息数量加1
            num += 1
            dic[message.targetId] = num
            ///保存
            UserDefaults.standard.setValue(dic, forKey: PERSONMESSAGEKEY)
        default:
            return
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "onRCIMReceive"), object: nil)
    }
}


