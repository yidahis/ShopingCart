//
//  CountView.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/18.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit

class CountView: UIView {
    var reduceButton: UIButton = UIButton()
    var countLabel: UILabel = UILabel()
    var plusButton: UIButton = UIButton()
    
    var maxCount = 9
    var count: Int = 1 {
        didSet{
            countLabel.text = "\(count)"
            if count <= 1{
                reduceButton.isEnabled = false
            }else{
                reduceButton.isEnabled = true
            }
            
            if count >= maxCount{
                plusButton.isEnabled = false
            }else{
                plusButton.isEnabled = true
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(reduceButton)
        self.addSubview(countLabel)
        self.addSubview(plusButton)
        
        reduceButton.setImage(UIImage.init(named: "button_reduce"), for: UIControlState.normal)
        reduceButton.setImage(UIImage.init(named: "button_reduce_disable"), for: UIControlState.disabled)
        
        plusButton.setImage(UIImage.init(named: "button_plus"), for: UIControlState.normal)
        plusButton.setImage(UIImage.init(named: "button_plus_disable"), for: UIControlState.disabled)
        
        countLabel.backgroundColor = UIColor.lightGray
        reduceButton.backgroundColor = UIColor.lightGray
        plusButton.backgroundColor = UIColor.lightGray
        
        reduceButton.addTarget(self, action: #selector(reduce), for: UIControlEvents.touchUpInside)
        plusButton.addTarget(self, action: #selector(plus), for: UIControlEvents.touchUpInside)
        
        countLabel.textAlignment = .center
        
        countLabel.text = "1"
        reduceButton.isEnabled = false
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reduceButton.frame = CGRect(x: 0, y: 0, width: self.height, height: self.height)
        plusButton.frame = CGRect(x: self.width - self.height, y: 0, width: self.height, height: self.height)
        countLabel.frame = CGRect(x: reduceButton.right + 2, y: 0, width: self.width - 2 * self.height - 4, height: self.height)
    }
    
    @objc func reduce(){
        count -= 1
    }
    @objc func plus(){
        count += 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
