
import UIKit

extension UIView {
    
    /// X坐标
    var x: CGFloat {
        
        get { return self.frame.origin.x }
        
        set (newValue) {
            
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
            
        }
        
    }
    
    
    /// Y坐标
    var y: CGFloat {
        
        get { return self.frame.origin.y }
        
        set (newValue) {
            
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
            
        }
        
    }
    
    /// 宽
    var width: CGFloat {
        
        get { return self.frame.size.width }
        
        set (newValue) {
            
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
            
        }
        
    }
    
    /// 高
    var height: CGFloat {
        
        get { return self.frame.size.height }
        
        set (newValue)  {
            
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
            
        }
        
    }
    
    /// View大小
    var size: CGSize {
        
        get { return CGSize(width: width, height: height) }
        
        set (newValue) {
            
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
            
        }
        
    }
    
    
    /// View中心X坐标
    var centerX: CGFloat {
        
        get { return self.center.x }
        
        set (newValue) {
            
            var center = self.center
            center.x = newValue
            self.center = center
            
        }
        
    }
    
    
    /// View中心Y坐标
    var centerY: CGFloat {
        
        get { return self.center.y }
        
        set (newValue) {
            
            var center = self.center
            center.y = newValue
            self.center = center
            
        }
        
    }
    
    /// EZSwiftExtensions
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    /// EZSwiftExtensions
    public var right: CGFloat {
        get {
            return self.x + self.width
        } set(value) {
            self.x = value - self.width
        }
    }
    
    /// EZSwiftExtensions
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    /// EZSwiftExtensions
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        } set(value) {
            self.y = value - self.height
        }
    }
    
    /// 添加毛玻璃
    ///
    /// - Parameter stype: 毛玻璃样式
    public func addBlurEffect(_ stype:UIBlurEffectStyle) {
        
        let blurEffect = UIBlurEffect(style: stype)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
        
    }
    
}
// MARK: Layer Extensions
extension UIView {
    /// EZSwiftExtensions
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    
    /// EZSwiftExtensions
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    /// EZSwiftExtensions
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    
    //TODO: add to readme
    /// EZSwiftExtensions
    public func addBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: size, color: color)
    }
    
    /// EZSwiftExtensions
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    
    /// EZSwiftExtensions
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    
    /// EZSwiftExtensions
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    
    /// EZSwiftExtensions
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}
