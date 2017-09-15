//
//  SKUModel.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/15.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class SKUModel: NSObject {
    
    class SpecsModel: NSObject {
        @objc dynamic var spec_value: String = ""
        @objc dynamic var spec_key: String = ""
        
        required init(json: JSON) {
            self.spec_key = json["spec_key"].stringValue
            self.spec_value = json["spec_value"].stringValue
        }

    }
    
    
    @objc dynamic var sold_quantity: Int = 0
    @objc dynamic var price: Int = 0
    @objc dynamic var thumb_url: String = ""
    @objc dynamic var limit_quantity: Int = 0
    @objc dynamic var weight: Int = 0
    @objc dynamic var market_price: Int = 0
    @objc dynamic var group_price: Int = 0
    @objc dynamic var goods_id: Int = 0
    @objc dynamic var normal_price: Int = 0
    @objc dynamic var spec: float_t = 0.0
    var specs: Array<SpecsModel> = Array<SpecsModel>()
    @objc dynamic var quantity: Int = 0
    @objc dynamic var sku_id: Int = 0
    @objc dynamic var init_quantity: Int = 0
    @objc dynamic var is_onsale: Int = 0
    
    required init(json: JSON) {
        super.init()
        self.sold_quantity = json["sold_quantity"].intValue
        self.price = json["price"].intValue
        self.thumb_url = json["thumb_url"].stringValue
        self.limit_quantity = json["limit_quantity"].intValue
        self.weight = json["weight"].intValue
        self.market_price = json["market_price"].intValue
        self.group_price = json["group_price"].intValue
        self.goods_id = json["goods_id"].intValue
        self.normal_price = json["normal_price"].intValue
        self.spec = json["spec"].floatValue
        self.quantity = json["quantity"].intValue
        self.sku_id = json["sku_id"].intValue
        self.init_quantity = json["init_quantity"].intValue
        self.is_onsale = json["is_onsale"].intValue
        
        self.specs = specsArray(json: json["specs"])
    }
    
    func specsArray(json: JSON) -> Array<SpecsModel>{
        var array: Array<SpecsModel> =  Array<SpecsModel>()
        json.arrayValue.forEach { (subJson) in
            let model = SpecsModel(json: subJson)
            array.append(model)
        }
        return array
    }
    

}
