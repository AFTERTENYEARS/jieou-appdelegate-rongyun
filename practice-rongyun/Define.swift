//
//  Define.swift
//  diary
//
//  Created by 李书康 on 2018/12/21.
//  Copyright © 2018 com.li.www. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SwiftyJSON
import SnapKit

public func JSONFromData(data: Data) -> JSON? {
    return JSON(parseJSON: String(data: data, encoding: String.Encoding.utf8) ?? "{}")
}

public func dataFromJSON(json: JSON) -> Data? {
    if let data = try? json.rawData() { return data }
    return nil
}

public func codableFromData<T: Codable>(data: Data, codable: T.Type) -> T? {
    if let codable = try? JSONDecoder().decode(codable, from: data) { return codable }
    return nil
}

public func dataFromCodable<T: Codable>(codable: T) -> Data? {
    if let data = try? JSONEncoder().encode(codable) { return data }
    return nil
}

public func JSONFromCodable<T: Codable>(codable: T) -> JSON? {
    if let data = try? JSONEncoder().encode(codable) { return JSONFromData(data: data) }
    return nil
}

public func codableFromJSON<T: Codable>(json: JSON, codable: T.Type) -> T? {
    if let codable = try? JSONDecoder().decode(codable, from: json.rawData()) { return codable }
    return nil
}

//cell 取消cell选中效果
public func Cell_Cancel_Select(tableView: UITableView) {
    for item in tableView.visibleCells {
        item.setSelected(false, animated: true)
    }
}

extension UITableView {
    public func cell_cancel_select() {
        for item in self.visibleCells {
            item.setSelected(false, animated: true)
        }
    }
}

//随机颜色
extension UIColor {
    open class var randomColor:UIColor{
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

//UIImageView方法扩展
extension UIImageView {
    func sk_Image(url: String){
        self.kf.setImage(with: ImageResource(downloadURL: URL(string: url)!))
    }
}

extension UIScreen {
    public var width: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    public var height: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
    public var status_bar_h: CGFloat {
        get {
            return (UIScreen.main.bounds.size.height == 812.0 || UIScreen.main.bounds.size.height == 896.0) ? 44.0 : 20.0
        }
    }
    public var nav_bar_h: CGFloat {
        get {
            return 44.0
        }
    }
    public var status_nav_h: CGFloat {
        get {
            return (UIScreen.main.bounds.size.height == 812.0 || UIScreen.main.bounds.size.height == 896.0) ? 88.0 : 64.0
        }
    }
    public var tabbar_h: CGFloat {
        get {
            return 49.0
        }
    }
    public var bottom_line_h: CGFloat {
        get {
            return (UIScreen.main.bounds.size.height == 812.0 || UIScreen.main.bounds.size.height == 896.0) ? 34.0 : 0.0
        }
    }
}

// UIView属性扩展
extension UIView {
    public var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    public var top:CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newTop) {
            var frame = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    public var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    public var right:CGFloat {
        get {
            return self.left + self.width
        }
    }
    public var bottom:CGFloat {
        get {
            return self.top + self.height
        }
    }
    public var centerX:CGFloat {
        get {
            return self.center.x
        }
        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
}
