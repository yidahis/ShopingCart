//
//  ShopingCartViewModel.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/18.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit
//Equatable 协议
func ==(lhs: SpecItem, rhs: SpecItem) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

struct SpecItem: Hashable {
    var isSelected: Bool = false
    var content: String = ""
    
    var hashValue: Int {
        get{
            return self.content.hashValue
        }
    }
    
}

struct SpecKeyVaules {
    var key: String
    var vaules: Array<SpecItem>
}

struct ShopingCartViewModel{
    var selectGoodsCount = 1
    var mySpecs: [SpecKeyVaules] = [SpecKeyVaules]()
    var selectSkuModel: SKUModel?
    
    var skuArray: [SKUModel] = [SKUModel](){
        didSet{
            dealData()
        }
    }
    
    mutating func dealData(){
        struct SpecKeyVaulesSet {
            var key: String
            var vaules: Set<SpecItem>
        }
        
        var myKeyValuesSets: [SpecKeyVaulesSet] = [SpecKeyVaulesSet]()
        
        
        skuArray.forEach { (sku) in
            sku.specs.forEach({ (spec) in
                print("key: \(spec.spec_key) , value: \(spec.spec_value)")
                var index = -1
                for i in 0..<myKeyValuesSets.count {
                    if myKeyValuesSets[i].key == spec.spec_key {
                        index = i
                        break
                    }
                }
                
                if index >= 0 {
                    myKeyValuesSets[index].vaules.insert(SpecItem(isSelected: false, content: spec.spec_value))
                }else{
                    var set = Set<SpecItem>()
                    set.insert(SpecItem(isSelected: false, content: spec.spec_value))
                    myKeyValuesSets.append(SpecKeyVaulesSet(key: spec.spec_key, vaules: set))
                }
            })
        }
        
        myKeyValuesSets.forEach { (keyValuesSet) in
            let keyValues = SpecKeyVaules(key: keyValuesSet.key, vaules: Array(keyValuesSet.vaules))
            mySpecs.append(keyValues)
        }
        print(mySpecs)
    }
}
