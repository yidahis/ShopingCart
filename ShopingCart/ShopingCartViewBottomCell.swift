//
//  ShopingCartViewBottom.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/18.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit

class ShopingCartViewBottomCell: UITableViewCell {
    var tipLabel: UILabel = UILabel()
    var lineView: UIView = UIView()
    var countView: CountView = CountView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(tipLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(countView)
        
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.text = "数量"
        
        lineView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tipLabel.frame = CGRect(x: XSpace, y: 0, width: 100, height: 16)
        tipLabel.centerY = contentView.height/2
        
        lineView.frame = CGRect(x: 0, y: contentView.height - 1, width: contentView.width, height: 1)
        
        countView.frame = CGRect(x: contentView.width - 120 - XSpace, y: 0, width: 120, height: 26)
        countView.centerY = tipLabel.centerY
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
