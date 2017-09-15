//100
//  ShopingCartView.swift
//  ShopingCart
//
//  Created by zhouyi on 2017/9/15.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit
let XSpace: CGFloat = 10

class ShopingCartViewHeader: UITableViewCell {
    var goodsImageView: UIImageView = UIImageView()
    var priceLabel: UILabel = UILabel()
    var selectLabel: UILabel = UILabel()
    var closeButton: UIButton = UIButton()
    
    var slectModel: SKUModel!{
        didSet {
            goodsImageView.image = UIImage.init(named: model.thumb_url)
            priceLabel.text = "￥\(model.price)"
            var selectText = "已选择："
            model.specs.forEach { (spec) in
                selectText.append(spec.spec_value + " ")
            }
            selectLabel.text = selectText
        }
    }
    
    var model: SKUModel!{
        didSet{

            if model != nil {
                //            imageView.image = UIImage.init(named: model.thumb_url)
                priceLabel.text = "￥\(model.price)"
                var selectText = "请选择："
                model.specs.forEach { (spec) in
                    selectText.append(spec.spec_key + " ")
                }
                selectLabel.text = selectText
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(goodsImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(selectLabel)
        contentView.addSubview(closeButton)
        
        selectLabel.text = "请选择：颜色 尺码"
        
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        selectLabel.font = UIFont.systemFont(ofSize: 12)
        
        priceLabel.textColor = UIColor.red
        
        closeButton.setTitle("关闭", for: UIControlState.normal)
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
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


class ShopingCartViewBottom: UITableViewCell {
    var tipLabel: UILabel = UILabel()
    var countView: CountView = CountView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(tipLabel)
        contentView.addSubview(countView)
        
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.text = "数量"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tipLabel.frame = CGRect(x: XSpace, y: 0, width: 100, height: 16)
        tipLabel.centerY = contentView.height/2
        
        countView.frame = CGRect(x: contentView.width - 120 - XSpace, y: 0, width: 120, height: 26)
        countView.centerY = tipLabel.centerY
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ShopingCartViewCell: UITableViewCell {
    var tipLabel: UILabel = UILabel()
    
    var model: SpecKeyVaules!{
        didSet{
            tipLabel.text = model.key
            var index = 10000
            Array(model.vaules).forEach { (content) in
                let label = UILabel()
                label.font = UIFont.systemFont(ofSize: 14)
                label.backgroundColor = UIColor.gray
                label.text = content
                contentView.addSubview(label)
                label.tag = index
                index += 1
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tipLabel.frame = CGRect(x: XSpace, y: XSpace, width: 100, height: 16)
        let maxX = self.width - XSpace * 2
        var minY = tipLabel.bottom + XSpace
        var minX = XSpace
        contentView.subviews.forEach { (view) in
            if let label = view as? UILabel, let width = label.text?.stringWidth(fontSize: 14){
                label.frame = CGRect(x: minX, y: minY, width: width, height: 28)
                minX = label.right + XSpace + 2
                if minX >= maxX {
                    minY = label.bottom + XSpace
                    minX = XSpace
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(tipLabel)
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.tag = 1000
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShopingCartView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    var tableView: UITableView!
    var model: ShopingCartViewModel = ShopingCartViewModel(){
        didSet{
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ShopingCartViewHeader.classForCoder(), forCellReuseIdentifier: "header")
        tableView.register(ShopingCartViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.register(ShopingCartViewBottom.classForCoder(), forCellReuseIdentifier: "header")
        self.addSubview(tableView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = CGRect(x: 0, y: self.height/3, width: self.width, height: self.height*2/3)
    }
    
    //计算第一行minY 到 最后一行 MaxY 之间的差值
    func height(contentString strings: [String]) -> CGFloat{
        
        let maxX: CGFloat = self.width - XSpace * 2
        var minY: CGFloat = 0
        var minX: CGFloat = XSpace
        strings.forEach { (content) in
            let width = content.stringWidth(fontSize: 14)
            minX = minX + width + XSpace + 2
            if minX >= maxX {
                minY = minY + 28 + XSpace
                minX = XSpace
            }
        }
        return minY + 28
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 112
        case model.mySpecs.count:
            return 55
        default:
            if model.mySpecs.count > indexPath.row - 1 {
                 return 34 + height(contentString: Array(model.mySpecs[indexPath.row - 1].vaules)) + XSpace
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.mySpecs.count > 0{
            return model.mySpecs.count + 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell: ShopingCartViewHeader = tableView.dequeueReusableCell(withIdentifier: "header") as? ShopingCartViewHeader else {
                return ShopingCartViewHeader()
            }
            cell.model = model.skuArray.first
            return cell
        case model.mySpecs.count:
            guard let cell: ShopingCartViewBottom = tableView.dequeueReusableCell(withIdentifier: "bottom") as? ShopingCartViewBottom else {
                return ShopingCartViewBottom()
            }
            return cell
        default:
            guard let cell: ShopingCartViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ShopingCartViewCell else {
                return ShopingCartViewCell()
            }
            if model.mySpecs.count > indexPath.row - 1 {
                cell.model = model.mySpecs[indexPath.row - 1]
            }
            
            return cell
        }
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}


struct SpecKeyVaules {
    var key: String
    var vaules: Set<String>
}
struct ShopingCartViewModel{
    var selectGoodsCount = 1
    var mySpecs: [SpecKeyVaules] = [SpecKeyVaules]()
    var skuArray: [SKUModel] = [SKUModel](){
        didSet{
            dealData()
        }
    }
    
    mutating func dealData(){
        skuArray.forEach { (sku) in
            sku.specs.forEach({ (spec) in
                print("key: \(spec.spec_key) , value: \(spec.spec_value)")
                var index = -1
                for i in 0..<mySpecs.count {
                    if mySpecs[i].key == spec.spec_key {
                        index = i
                        break
                    }
                }
                
                if index >= 0 {
                    mySpecs[index].vaules.insert(spec.spec_value)
                }else{
                    var set = Set<String>()
                    set.insert(spec.spec_value)
                    mySpecs.append(SpecKeyVaules(key: spec.spec_key, vaules: set))
                }
            })
        }
        print(mySpecs)
    }
}
extension String {
    func stringWidth(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
}
