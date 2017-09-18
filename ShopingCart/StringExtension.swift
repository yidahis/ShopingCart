//
//  StringExtension.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/18.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit

extension String {
    func stringWidthWithSpace(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat{
        return stringWidth(fontSize: fontSize, height: height) + 20
    }
    
    func stringWidth(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
}
