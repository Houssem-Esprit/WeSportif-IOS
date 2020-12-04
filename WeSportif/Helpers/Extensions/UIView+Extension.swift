
import Foundation


import UIKit

extension UIView {
    func alphaFromPoint(point: CGPoint) -> CGFloat {
        var pixel: [UInt8] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let alphaInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: alphaInfo.rawValue)
        context?.translateBy(x: -point.x, y: -point.y)
        
        self.layer.render(in: context!)
        
        let floatAlpha = CGFloat(pixel[3])
        return floatAlpha
    }
}

@IBDesignable
class ShapedTapButton: UIButton {
    
    @IBInspectable var treshold: CGFloat = 1.0 {
        didSet {
            if treshold > 1.0 {
                treshold = 1.0
            }
            if treshold < 0.0 {
                treshold = 0.0
            }
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.alphaFromPoint(point: point) > treshold
    }
    
    
    
    
    
    
}


extension UIView {
    
    //corner Radius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    //border Width
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    //border Color
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    // shadow color
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set {
            if let color = newValue {
                self.clipsToBounds = false
                self.layer.shadowColor = color.cgColor
                self.layer.shadowOffset = CGSize(width: 0, height: 3)
                self.layer.shadowOpacity = 0.1
                self.layer.shadowRadius = 5.0
            }
        }
    }
    
    //Add animation fade in
    func fadeIn() {
        self.alpha -= 10
        self.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.alpha += 10
        }
    }
    
    //Add animation fade out
    func fadeOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha -= 10
        }, completion: { _ in
            self.isHidden = true
            self.alpha += 10
        })
    }
    
    func slideDown() {
        if !isHidden {
            return
        }
        self.center.y -= self.bounds.height + 8
        self.isHidden = false
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.center.y += self.bounds.height + 8
        }, completion: nil)
    }
    
    func showAnimated() {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha -= 3
        self.isHidden = false
        
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform.identity
            self.alpha += 3
        }
    }
    
}
extension UIView {
    
    func subviewsRecursive() -> [UIView] {
        
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
        
    }
    
}

