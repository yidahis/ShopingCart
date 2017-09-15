//
//  ViewController.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/15.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    var skuArray: [SKUModel] = [SKUModel]()
    var cartView: ShopingCartView = ShopingCartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var color:Set<String> = Set<String>()
        color.insert("黄色")
        color.insert("蓝色")
        color.insert("黄色")
        view.addSubview(cartView)
        cartView.frame = view.bounds
        
        request()
    }

    func request(){
        Alamofire.request("http://apiv4.yangkeduo.com/v5/goods/58693878?pdduid=6085803692").responseJSON {[weak self] (response) in

            if let data = response.data {
                let json = JSON(data: data)
                print("json: \(json)")
                json["sku"].arrayValue.forEach({ (skuJson) in
                    self?.skuArray.append(SKUModel(json: skuJson))
                })
                
            }
            print(self?.skuArray)
            self?.cartView.model.skuArray = (self?.skuArray)!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

