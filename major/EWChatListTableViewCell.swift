//
//  practice-rongyun
//
//  Created by 李书康 on 2018/12/24.
//  Copyright © 2018 com.li.www. All rights reserved.
//

import UIKit

class EWChatListTableViewCell: UITableViewCell {

    static let identifier = "EWChatListTableViewCell"

    private let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 24, y: 0, width: 250, height: 50))
        return label
    }()
    private let badgeValueLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 80, y: 13, width: 24, height: 24))
        label.backgroundColor = UIColor.red
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
//        label.isHidden = true
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawMyView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func drawMyView() {
        self.addSubview(label)
        self.addSubview(badgeValueLabel)
    }
    public func setData(name: String, badge: Int){
        self.label.text = name
        if badge == 0 {
            badgeValueLabel.isHidden = true
        }else {
            self.badgeValueLabel.text = "\(badge)"
            self.badgeValueLabel.isHidden = false
        }
    }

}

