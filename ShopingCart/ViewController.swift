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
        
        view.addSubview(cartView)
        view.sendSubview(toBack: cartView)
        cartView.frame = view.bounds
        cartView.selectDoneAction = { (skuModel) in
            if skuModel != nil {
                print("选择成功")
            }else{
                print("选择失败")
            }
        }
        
        request()
    }

    func request(){
        Alamofire.request("http://apiv4.yangkeduo.com/v5/goods/58693903?pdduid=6085803692").responseJSON {[weak self] (response) in

            if let data = response.data {
                let json = JSON(data: data)
                json["sku"].arrayValue.forEach({ (skuJson) in
                    self?.skuArray.append(SKUModel(json: skuJson))
                })
                
            }
            self?.cartView.viewModel.skuArray = (self?.skuArray)!
            self?.cartView.tableView.reloadData()
            self?.cartView.show()
        }
    }
    
    @IBAction func show(_ sender: Any) {
        
        cartView.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

