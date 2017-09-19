//
//  asd.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/18.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit

typealias clickAction = (String,String) -> Void

class ShopingCartViewCell: UITableViewCell {
    var tipLabel: UILabel = UILabel()
    var lineView: UIView = UIView()
    
    var buttonTapAction: clickAction?
    
    var model: SpecKeyVaules!{
        didSet{
            tipLabel.text = model.key
            var index = 10000
            //如果没有button子视图就创建，否则直接操作
            if (contentView.viewWithTag(10000) != nil) {
                contentView.subviews.forEach({ (view) in
                    if let button = view as? UIButton{
                        var selectedItem = SpecItem()
                        model.vaules.forEach({ (item) in//取出选中的item
                            if  item.isSelected == true {
                                selectedItem = item
                            }
                        })
                        //如果选择的item.content 等于 当前button的title 时，设置这个button为选中
                        if let buttonTitle = button.titleLabel?.text, buttonTitle == selectedItem.content {
                            button.isSelected = true
                        }else{
                            button.isSelected = false
                        }
                    }
                })
                return
            }
            Array(model.vaules).forEach { (item) in
                let button = UIButton()
                button.setTitle(item.content, for: UIControlState.normal)
                button.isSelected = item.isSelected
                
                button.setTitleColor(UIColor.red, for: UIControlState.selected)
                button.setTitleColor(UIColor.white, for: UIControlState.normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                button.backgroundColor = UIColor.gray
                button.titleLabel?.textAlignment = .center
                button.addTarget(self, action: #selector(click), for: UIControlEvents.touchUpInside)
                contentView.addSubview(button)
                button.tag = index
                index += 1
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tipLabel.frame = CGRect(x: XSpace, y: XSpace, width: 100, height: 16)
        lineView.frame = CGRect(x: 0, y: contentView.height - 1, width: contentView.width, height: 1)
        let maxX = self.width - XSpace
        var minY = tipLabel.bottom + XSpace
        var minX = XSpace
        contentView.subviews.forEach { (view) in
            if let button = view as? UIButton, let width = button.titleLabel?.text?.stringWidthWithSpace(fontSize: 14){
                if minX + width + XSpace  > maxX {
                    minX = XSpace
                    minY = minY + 28 + XSpace
                }
                
                button.frame = CGRect(x: minX, y: minY, width: width, height: 28)
                minX = button.right + XSpace
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(tipLabel)
        contentView.addSubview(lineView)

        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.tag = 1000
        
        lineView.backgroundColor = UIColor.groupTableViewBackground
        
    }
    
    @objc func click(sender: UIButton)  {
        print(sender.tag)
        if let text = sender.titleLabel?.text {
            buttonTapAction?(tipLabel.text! ,text)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
