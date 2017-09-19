//100
//  ShopingCartView.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/15.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit
let XSpace: CGFloat = 10

typealias shopCartViewDoneAction = (SKUModel?) -> Void

class ShopingCartView: UIView {
    //MARK: - property
    var tableView: UITableView!
    var doneButton: UIButton!
    let doneButtonHeight: CGFloat = 50
    var selectDoneAction: shopCartViewDoneAction?
    var closeActionBlock: NoneArgmentAction?
    var isShowing: Bool = false
    
    var viewModel: ShopingCartViewModel = ShopingCartViewModel()
    
    
    //MARK: - life
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ShopingCartViewHeaderCell.classForCoder(), forCellReuseIdentifier: "header")
        tableView.register(ShopingCartViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.register(ShopingCartViewBottomCell.classForCoder(), forCellReuseIdentifier: "bottom")
        tableView.layoutMargins = UIEdgeInsets.zero
        self.addSubview(tableView)
        
        doneButton = UIButton()
        self.addSubview(doneButton)
        doneButton.setTitle("确定", for: UIControlState.normal)
        doneButton.backgroundColor = UIColor.red
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: UIControlEvents.touchUpInside)
        
        tableView.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        

        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("keypath: " + keyPath!)
        print(change)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isShowing {
            self.tableView.frame = CGRect(x: 0, y: self.height/3, width: self.width, height: self.height*2/3  - self.doneButtonHeight)
            self.doneButton.frame = CGRect(x: 0, y: self.tableView.bottom, width: self.width, height: self.doneButtonHeight)
        }else{
            tableView.frame = CGRect(x: 0, y: self.height, width: self.width, height: self.height*2/3  - self.doneButtonHeight)
            doneButton.frame = CGRect(x: 0, y: tableView.bottom, width: self.width, height: self.doneButtonHeight)
        }

   

    }
    
    func show() {
        isShowing = true
        self.superview?.bringSubview(toFront: self)
        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseIn, animations: {
            self.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
            self.tableView.frame = CGRect(x: 0, y: self.height/3, width: self.width, height: self.height*2/3  - self.doneButtonHeight)
            self.doneButton.frame = CGRect(x: 0, y: self.tableView.bottom, width: self.width, height: self.doneButtonHeight)
        }) { (finished) in
            
        }
    }
    
    //MARK: - private method
    @objc func doneButtonAction(){
        selectDoneAction?(viewModel.selectSkuModel)
    }
    
    func close(){
        isShowing = false
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0)
            self.tableView.frame = CGRect(x: 0, y: self.height, width: self.width, height: self.height*2/3  - self.doneButtonHeight)
            self.doneButton.frame = CGRect(x: 0, y: self.tableView.bottom, width: self.width, height: self.doneButtonHeight)
        }) { (finished) in
            self.superview?.sendSubview(toBack: self)
        }
    }
    
    //计算第一行minY 到 最后一行 MaxY 之间的差值
    func height(contentItem items: [SpecItem]) -> CGFloat{
        
        let maxX: CGFloat = self.width - XSpace * 2
        var minY: CGFloat = 0
        var minX: CGFloat = XSpace
        items.forEach { (item) in
            let width = item.content.stringWidthWithSpace(fontSize: 14)
            minX = minX + width + XSpace + 2
            if minX >= maxX {
                minY = minY + 28 + XSpace
                minX = XSpace
            }
        }
        return minY + 28
        
    }

    func updateShopingCartViewCellData(tip: String, title: String){

        for i in 0..<viewModel.mySpecs.count {
            let specs = viewModel.mySpecs[i]
            if specs.key == tip {
                for j in 0..<specs.vaules.count {
                    let item = specs.vaules[j]
                    if item.content == title{
                        viewModel.mySpecs[i].vaules[j].isSelected = true
                    }else{
                        viewModel.mySpecs[i].vaules[j].isSelected = false
                    }
                }
            }
        }
    }
    
    /// 筛选已选样式的数据
    ///
    /// - Returns: ShopingCartViewHeaderCellModel
    func headerViewData()  -> ShopingCartViewHeaderCellModel?{
       
        var selectedKeyValue = [String: String]()
        //筛选出已选的样式选项
        viewModel.mySpecs.forEach { (specs) in
            specs.vaules.forEach({ (item) in
                if item.isSelected == true {
                    selectedKeyValue[specs.key] = item.content
                }
            })
        }
        
        guard let selectedSpec = selectedKeyValue.first else{
            return nil
        }
        
        var skuModel: SKUModel?
        viewModel.skuArray.forEach { (model) in
            model.specs.forEach({ (spec) in
                if spec.spec_key == selectedSpec.key, spec.spec_value == selectedSpec.value {
                    skuModel = model
                }
            })
        }
        
        guard let model = skuModel else {
            return nil
        }
        
        if model.specs.count == selectedKeyValue.count{
            viewModel.selectSkuModel = model
        }
        
        var content: String = ""
        selectedKeyValue.forEach { (keyValue) in
            content.append(keyValue.value + " ")
            
        }
        return ShopingCartViewHeaderCellModel(thumbUrl: model.thumb_url, price: model.group_price, content: content)
    }
    
    func lowAndHightPriceModel() -> (SKUModel?, SKUModel?){
        guard let first = viewModel.skuArray.first else {
            return (nil, nil)
        }
        
        var low: SKUModel = first
        var high: SKUModel  = first
        viewModel.skuArray.forEach { (model) in
            if model.group_price > high.group_price {
                high = model
            }
            
            if model.group_price < low.group_price {
                low = model
            }
        }
        return (low, high)
    }

}
 //MARK: - UITableViewDelegate,UITableViewDataSource
extension ShopingCartView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 112
        case viewModel.mySpecs.count + 1:
            return 55
        default:
            if viewModel.mySpecs.count > indexPath.row - 1 {
                return 34 + height(contentItem: Array(viewModel.mySpecs[indexPath.row - 1].vaules)) + 2*XSpace
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.mySpecs.count > 0{
            return viewModel.mySpecs.count + 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell: ShopingCartViewHeaderCell = tableView.dequeueReusableCell(withIdentifier: "header") as? ShopingCartViewHeaderCell else {
                return ShopingCartViewHeaderCell()
            }
            //是否有选择颜色尺码等，有就直接加载已选数据，否则加载默认数据
            if let model = headerViewData() {
                cell.viewModel = model
            }else {
                let (low, high) = lowAndHightPriceModel()
                if let lowModel = low, let hightModel = high {
                    cell.priceModel(low: lowModel, high: hightModel)
                }
            }
            
            cell.clossButtonActionBlock = { [weak self] in
               self?.close()
            }
            
            return cell
        case viewModel.mySpecs.count + 1 :
            guard let cell: ShopingCartViewBottomCell = tableView.dequeueReusableCell(withIdentifier: "bottom") as? ShopingCartViewBottomCell else {
                return ShopingCartViewBottomCell()
            }
            return cell
        default:
            guard let cell: ShopingCartViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ShopingCartViewCell else {
                return ShopingCartViewCell()
            }
            if viewModel.mySpecs.count > indexPath.row - 1 {
                cell.model = viewModel.mySpecs[indexPath.row - 1]
            }
            cell.buttonTapAction = { [weak self] (tip,title) in
                print(tip + " " + title)
                self?.updateShopingCartViewCellData(tip: tip, title: title)
                self?.tableView.reloadData()
            }
            return cell
        }
    }
}


