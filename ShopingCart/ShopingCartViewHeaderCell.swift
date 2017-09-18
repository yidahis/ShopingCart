//
//  ShopingCartViewHeader.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/18.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit
import SDWebImage

struct ShopingCartViewHeaderCellModel {
    var thumbUrl: String
    var price: Int
    var content: String
}

class ShopingCartViewHeaderCell: UITableViewCell {
    var lineView: UIView = UIView()
    var goodsImageView: UIImageView = UIImageView()
    var priceLabel: UILabel = UILabel()
    var selectLabel: UILabel = UILabel()
    var closeButton: UIButton = UIButton()
    
    var viewModel: ShopingCartViewHeaderCellModel!{
        didSet {
            goodsImageView.sd_setImage(with: URL(string: viewModel.thumbUrl), completed: nil)
            priceLabel.text = "￥\(viewModel.price/100)"
            selectLabel.text = "已选择:" + viewModel.content
        }
    }

    func priceModel(low: SKUModel, high: SKUModel){
        goodsImageView.sd_setImage(with: URL(string: low.thumb_url), completed: nil)
        if low.group_price == high.group_price {
            priceLabel.text = "￥\(low.group_price/100)"
        }else{
            priceLabel.text = "￥\(low.group_price/100) - \(high.group_price/100)"
        }
        
        var selectText = "请选择："
        low.specs.forEach { (spec) in
            selectText.append(spec.spec_key + " ")
        }
        selectLabel.text = selectText
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(lineView)
        contentView.addSubview(goodsImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(selectLabel)
        contentView.addSubview(closeButton)
        
        selectLabel.text = "请选择：颜色 尺码"
        
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        selectLabel.font = UIFont.systemFont(ofSize: 12)
        
        priceLabel.textColor = UIColor.red
        
        closeButton.setTitle("关闭", for: UIControlState.normal)
        
        lineView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineView.frame = CGRect(x: 0, y: contentView.height - 1, width: contentView.width, height: 1)
        let imageViewWidth = contentView.frame.size.height - 2 * XSpace
        goodsImageView.frame = CGRect(x: XSpace, y: XSpace, width: imageViewWidth, height: imageViewWidth)
        priceLabel.frame = CGRect(x: goodsImageView.right + XSpace, y: goodsImageView.y + XSpace, width: 150, height: 18)
        selectLabel.frame = CGRect(x: goodsImageView.right + XSpace, y: priceLabel.bottom + XSpace, width: 150, height: 16)
        closeButton.frame = CGRect(x: contentView.width - XSpace - 30, y: XSpace, width: 30, height: 30)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
