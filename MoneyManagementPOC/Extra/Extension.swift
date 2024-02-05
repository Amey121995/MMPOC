//
//  Extension.swift
//  MoneyManagementPOC
//
//  Created by Amey Dalvi on 04/02/24.
//

import Foundation
import UIKit

var isReachability = true
private var kAssociationKeyMaxLength: Int = 0
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        let chars = Array(hex)
        self.init(red:   CGFloat(strtoul(String(chars[1...2]),nil,16))/255,
                  green: CGFloat(strtoul(String(chars[3...4]),nil,16))/255,
                  blue:  CGFloat(strtoul(String(chars[5...6]),nil,16))/255,
                  alpha: alpha)}
}

extension UIView {
    private static let dottedLineLayerKey = "dottedLineLayer"

    func addDottedLine(color: UIColor = .black, lineWidth: CGFloat = 1.0, dotSpacing: CGFloat = 2.0) {
        // Check if the layer already exists
        if layer.sublayers?.contains(where: { $0.name == UIView.dottedLineLayerKey }) != nil {
            // Dotted line already added
            return
        }

        // Create a patterned layer
        let patternLayer = CAShapeLayer()
        patternLayer.strokeColor = color.cgColor
        patternLayer.lineWidth = lineWidth
        patternLayer.lineJoin = .round
        let num1 = NSNumber(floatLiteral: Double(lineWidth))
        let num2 = NSNumber(floatLiteral: Double(dotSpacing))
        patternLayer.lineDashPattern = [num1, num2]
        patternLayer.name = UIView.dottedLineLayerKey

        // Create a path for the line
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 2))
        patternLayer.path = path.cgPath

        // Add the pattern layer as the dotted line
        self.layer.addSublayer(patternLayer)
    }

    func removeDottedLine() {
        // Remove the dotted line layer if it exists
        layer.sublayers?.removeAll { $0.name == UIView.dottedLineLayerKey }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addShadow(){
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
    
    func documentViewStyle(){
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "AMEY"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    func TapLisner(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    func setShadow(cornerRadius:Float){
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
    
    func setShadow1(cornerRadius:Float){
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize.zero
        
    }
}



extension Double {
    var kmFormatted: String {
        
        if self >= 999, self <= 99999 {
            return String(format: "%.2f K", locale: Locale.current,Float(self/1000))
        }
        
        if self >= 99999, self <= 9999999 {
            return String(format: "%.2f L", locale: Locale.current,Float(self/100000))
        }
        
        if self > 9999999 {
            return String(format: "%.2f Cr", locale: Locale.current,Float(self/10000000))
        }
        
        if self < 0{
            if self <= -999, self >= -99999 {
                return String(format: "%.2f K", locale: Locale.current,Float(self/1000))
            }
            
            if self <= -99999, self >= -9999999 {
                return String(format: "%.2f L", locale: Locale.current,Float(self/100000))
            }
            
            if self < -9999999 {
                return String(format: "%.2f Cr", locale: Locale.current,Float(self/10000000))
            }
        }
        
        return String(format: "%.2f", locale: Locale.current,self)
    }
}


extension UIViewController {
    func showToast(message: String, fontSize : CGFloat? = 18, color : UIColor? = .blue, animationTime : TimeInterval? = 4.0) {
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        guard let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        
        let toastLbl = UILabel()
        toastLbl.text = message
        toastLbl.textAlignment = .center
        toastLbl.font = UIFont(name: "RedHatText-Medium", size: fontSize ?? 18)//UIFont.systemFont(ofSize: fontSize ?? 18)
        toastLbl.textColor = UIColor.white
        //toastLbl.backgroundColor = UIColor(hex: "#8BC53F")
        toastLbl.backgroundColor = color
        toastLbl.numberOfLines = 0
        
        let textSize = toastLbl.intrinsicContentSize
        let labelHeight = ( textSize.width / window.frame.width ) * 60
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let adjustedHeight = max(labelHeight, textSize.height + 20)
        
        toastLbl.frame = CGRect(x: 20, y: (window.frame.height - 90 ) - adjustedHeight, width: labelWidth + 20, height: adjustedHeight)
        toastLbl.center.x = window.center.x
        toastLbl.layer.cornerRadius = 10
        toastLbl.layer.masksToBounds = true
        
        window.addSubview(toastLbl)
        
        UIView.animate(withDuration: animationTime ?? 4.0, animations: {
            toastLbl.alpha = 0
        }) { (_) in
            toastLbl.removeFromSuperview()
        }
        
    }
}

@IBDesignable
class LeftAlignedIconButton: UIButton {
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: round(availableWidth / 2), dy: 0)
    }
}


extension UIButton{
    
    func setDefaultBtn(fontSize: CGFloat? = nil, isRounded: Bool? = true, bgColor: UIColor? = nil,  fontColor: UIColor? = nil ,borderColor: UIColor? = nil)
    {
        if isRounded ?? true{
            self.layer.cornerRadius = self.bounds.size.height / 2.1
        }
        else
        {
            self.layer.cornerRadius = 0
        }
        self.titleLabel?.font = UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(16.0))
        self.titleLabel?.textColor = fontColor ?? .white
        self.tintColor = fontColor ?? .white
        self.layer.backgroundColor = bgColor?.cgColor ?? UIColor.blue.cgColor
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor ?? UIColor.clear.cgColor
    }
    
    func setDefaultBorderBlueBtn(fontSize: CGFloat? = nil, isRounded: Bool? = true, bgColor: UIColor? = nil,  fontColor: UIColor? = nil, borderWidth : CGFloat? = 2 )
    {
        if isRounded ?? true{
            self.layer.cornerRadius = self.bounds.size.height / 2.1
        }
        else
        {
            self.layer.cornerRadius = 0
        }
        self.titleLabel?.font = UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(16.0))
        self.titleLabel?.textColor =  .blue
        self.tintColor =  .blue
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = borderWidth ?? 2
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
    func setDefaultBlueBtn(fontSize: CGFloat? = nil, isRounded: Bool? = true)
    {
        if isRounded ?? true{
            self.layer.cornerRadius = self.bounds.size.height / 2.1
        }
        else
        {
            self.layer.cornerRadius  = 0
        }
        self.titleLabel?.font = UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(16.0))
        self.titleLabel?.textColor = UIColor.white
        self.tintColor = UIColor.white
        self.backgroundColor = .blue
    }
    
    func setDefaultBlueBtn(fontSize: CGFloat? = nil, isRounded: Bool? = true, background: UIColor? = nil)
    {
        if isRounded ?? true{
            self.layer.cornerRadius  = self.bounds.size.height / 2.1
        }
        else
        {
            self.layer.cornerRadius  = 0
        }
        self.titleLabel?.font = UIFont(name: "RedHatText-Medium", size: fontSize ?? CGFloat(16.0))
        self.titleLabel?.textColor = UIColor(hex: "#9199AF", alpha: 1)
        self.tintColor = UIColor(hex: "#9199AF", alpha: 1)
        self.backgroundColor = background ?? UIColor.blue
    }
    
    func setDefaultNormalBlueBtn(fontSize: CGFloat? = nil, isRounded: Bool? = true)
    {
        if isRounded ?? true{
            self.layer.cornerRadius  = self.bounds.size.height / 2.1
        }
        else
        {
            self.layer.cornerRadius  = 0
        }
        self.titleLabel?.font = UIFont(name: "RedHatText-Regular", size: fontSize ?? CGFloat(16.0))
        self.titleLabel?.textColor = UIColor.white
        self.tintColor = UIColor.white
        self.backgroundColor = UIColor.blue
    }
    
    func setClearBtnWithLeftImge(fontSize: CGFloat? = nil,image: UIImage? = nil, tint: UIColor)
    {
        self.backgroundColor = .clear
        self.titleLabel?.font = UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(16.0))
        self.titleLabel?.textColor = tint
        self.tintColor = tint
        if image == nil
        {
            
        }
        else
        {
            self.setImage(image, for: .normal)
        }
        
        
    }
    
    func setClearBtnWithRightImge(fontSize: CGFloat? = nil,image: UIImage? = nil, tint: UIColor)
    {
        self.layer.cornerRadius  = self.bounds.size.height / 2.1
        self.titleLabel?.font = UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(16.0))
        self.titleLabel?.textColor = UIColor.white
        self.tintColor = UIColor.white
        self.backgroundColor = UIColor.blue
//        self.contentHorizontalAlignment = .trailing
        self.semanticContentAttribute = .forceRightToLeft
//        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
//        self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
//        self.imageView?.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        self.imageEdgeInsets = UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 4)
        if image == nil
        {
            
        }
        else
        {
            self.setImage(image, for: .normal)
        }
        
        
//        self.adjust()
    }
    func imageToRight() {
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        let height = self.bounds.size.height - 6
        imageView?.frame.size = CGSize(width: height, height: height)
        imageView?.contentMode = .scaleAspectFit
    }
    
    func adjust() {
        guard let imageView = self.imageView else { return }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        let height = self.bounds.size.height - 6
        imageView.frame.size = CGSize(width: height, height: height)
        imageView.contentMode = .scaleAspectFit
        
        guard let titleLabel = self.titleLabel else { return }
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
    }
    
    func setClearBtn(fontSize: CGFloat? = nil, tint: UIColor)
    {
        self.backgroundColor = .clear
        self.titleLabel?.font = UIFont(name:"RedHatText-Medium", size: fontSize ?? CGFloat(16.0))
        self.titleLabel?.textColor = tint
        self.tintColor = tint
    }
}
extension UITextView
{
    func setDefaultStyle(cornerRadius: CGFloat? = nil,fontSize: CGFloat? = nil)
    {
      
        self.layer.cornerRadius  = cornerRadius ?? CGFloat(5.0)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.font = UIFont(name: "RedHatText-Medium", size: fontSize ?? CGFloat(18.0))
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
       }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        self.autocorrectionType = .no
        self.smartInsertDeleteType = .no
        self.spellCheckingType = .no
        switch self.keyboardType {
        case .default:
            self.keyboardType = .asciiCapable
            break
        case .numberPad:
            self.keyboardType = .asciiCapableNumberPad
            break
        case .alphabet:
            self.keyboardType = .asciiCapable
            break
        default:
            self.keyboardType = .asciiCapable
        }
    }
    
}
extension UITextField
{
    func setLeftIcon(_ image: UIImage, tint: UIColor) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = tint
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setRightIcon(_ image: UIImage, tint: UIColor) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = tint
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        leftViewMode = .always
    }
    
    func setDefaultStyle(cornerRadius: CGFloat? = nil,fontSize: CGFloat? = nil)
    {
       
        self.setLeftPaddingPoints(10)
        self.layer.cornerRadius  = cornerRadius ?? CGFloat(10.0)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.font = UIFont(name: "RedHatText-Medium", size: fontSize ?? CGFloat(18.0))
       
        
    }

    func setDefaultStyle(cornerRadius: CGFloat? = nil,fontSize: CGFloat? = nil, borderColor: UIColor? = nil, textColor: UIColor? = nil)
    {
       
        self.setLeftPaddingPoints(10)
        self.layer.cornerRadius  = cornerRadius ?? CGFloat(10.0)
        self.layer.borderColor = borderColor?.cgColor ?? UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.textColor = textColor ?? UIColor.lightGray
        self.font = UIFont(name: "RedHatText-Medium", size: fontSize ?? CGFloat(18.0))
       
        
    }

    
    func serDefaultStyleWithRightBtn(cornerRadius: CGFloat? = nil,fontSize: CGFloat? = nil, btn: UIButton)
    {
        self.setLeftPaddingPoints(10)
        self.layer.cornerRadius  = cornerRadius ?? CGFloat(10.0)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.font = UIFont(name: "RedHatText-Medium", size: fontSize ?? CGFloat(18.0))
        let size = self.bounds.size.height - 10
        btn.frame.size = CGSize(width: size, height: size)
        self.rightView?.addSubview(btn)
        self.rightViewMode = .always
    }
    func setStyleBottomBorder(color:UIColor? = .clear)
    {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.size.height - 1, width: self.bounds.size.width - 20, height: 1.0)
        bottomLine.backgroundColor = color?.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        
        switch self.keyboardType {
        case .default:
            self.keyboardType = .asciiCapable
            break
        case .numberPad:
            self.keyboardType = .asciiCapableNumberPad
            break
        case .alphabet:
            self.keyboardType = .asciiCapable
            break
        default:
            break
        }
        
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        self.autocorrectionType = .no
        self.smartInsertDeleteType = .no
        self.spellCheckingType = .no
        editingChanged(self)
    }
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
       }
    
    @objc func editingChanged(_ textField: UITextField) {
        guard let text = textField.text?.englishLetters else { return }
        textField.text = text
    }
}

extension String
{
    var englishLetters: String {
        return components(separatedBy: CharacterSet.englishLetters.inverted).joined()
    }
}


extension CharacterSet {
        // create your own set with the allowed characters to filter your string
    static let englishLetters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz 1234567890 - / : ;()&@.,?!'\"[]{}#%^*+=_\\|~<>$£€>")
}

extension UILabel
{
    func setDefaulTitle(fontSize: CGFloat? = nil,color: UIColor? = nil)
    {
        self.textColor = color ?? UIColor.black
        self.font = UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(20.0))
    }
    
    func setDefaulSubTitle(fontSize: CGFloat? = nil,color: UIColor? = nil)
    {
        self.textColor = color ?? UIColor.lightGray
        self.font = UIFont(name: "RedHatText-Medium", size: fontSize ?? CGFloat(14.0))
    }
    func setDefaulNormalSubTitle(fontSize: CGFloat? = nil,color: UIColor? = nil)
    {
        self.textColor = color ?? UIColor.lightGray
        self.font = UIFont(name: "RedHatText-Regular", size: fontSize ?? CGFloat(14.0))
    }
    
    func setDefaulSubTitleBold(fontSize: CGFloat? = nil,color: UIColor? = nil)
    {
        self.textColor = color ?? UIColor.lightGray
        self.font = UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(16.0))
    }
}

extension UISegmentedControl{
    
    func setDefaultStyle(fontSize: CGFloat? = nil)
    {
        self.setOldLayout(tintColor: UIColor.blue)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius  = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.setNeedsLayout()
        self.contentMode = .scaleAspectFit
        self.setTitleTextAttributes([.foregroundColor: UIColor.white,.font: UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(14.0))!], for: .selected)
        self.setTitleTextAttributes([.foregroundColor: UIColor.lightGray,.font: UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(14.0))!], for: .normal)
        if #available(iOS 13.0, *) {
            self.selectedSegmentTintColor = UIColor.blue
        } else {
            
            self.tintColor = UIColor.blue
        }
        
    }
    func setDefaultStyleNotRounded(fontSize: CGFloat? = nil, color: UIColor? = nil)
    {
        let tint = color ?? UIColor.blue
        self.setOldLayout(tintColor: tint)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius  = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = tint.cgColor
        self.setNeedsLayout()
        self.contentMode = .scaleAspectFit
        self.setTitleTextAttributes([.foregroundColor: UIColor.white,.font: UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(14.0))!], for: .selected)
        self.setTitleTextAttributes([.foregroundColor: UIColor.lightGray,.font: UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(14.0))!], for: .normal)
        if #available(iOS 13.0, *) {
            self.selectedSegmentTintColor = tint
        } else {
            
            self.tintColor = tint
        }
        
    }
    
    func setOldLayout(tintColor: UIColor)
       {
           if #available(iOS 13, *)
           {
               let bg = UIImage(color: .clear, size: CGSize(width: 1, height: 32))
                let devider = UIImage(color: tintColor, size: CGSize(width: 1, height: 32))

                //set background images
                self.setBackgroundImage(bg, for: .normal, barMetrics: .default)
                self.setBackgroundImage(devider, for: .selected, barMetrics: .default)

                //set divider color
                self.setDividerImage(devider, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

                //set border
                self.layer.borderWidth = 1
                self.layer.borderColor = tintColor.cgColor

                //set label color
                self.setTitleTextAttributes([.foregroundColor: tintColor], for: .normal)
                self.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
           }
           else
           {
               self.tintColor = tintColor
           }
       }
    
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.init(data: image.pngData()!)!
    }
}

class IntrinsicTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
extension UIImage {
    func imageWithInsets(insetDimen: CGFloat) -> UIImage {
        return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
    }
    
    func imageWithInset(insets: UIEdgeInsets) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
        UIGraphicsEndImageContext()
        return imageWithInsets!
    }
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
               let maxRadius = min(size.width, size.height) / 2
               let cornerRadius: CGFloat
               if let radius = radius, radius > 0 && radius <= maxRadius {
                   cornerRadius = radius
               } else {
                   cornerRadius = maxRadius
               }
               UIGraphicsBeginImageContextWithOptions(size, false, scale)
               let rect = CGRect(origin: .zero, size: size)
               UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
               draw(in: rect)
               let image = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
               return image
           }
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image.withRoundedCorners(radius: size.height / 4) ?? image
    }
}

extension UIImage {
    // MARK: - UIImage+Resize
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
            let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
            let format = imageRendererFormat
            format.opaque = isOpaque
            return UIGraphicsImageRenderer(size: canvas, format: format).image {
                _ in draw(in: CGRect(origin: .zero, size: canvas))
            }
        }

    func compress(to mb: Float, allowedMargin: CGFloat = 0) -> UIImage {
            let bytes = (mb*950*950)
            var compression: CGFloat = 1.0
            let step: CGFloat = 0.05
            var holderImage = self
            var complete = false
            while(!complete) {
                if let data = holderImage.jpegData(compressionQuality: 0.7) {
                    let ratio = Float(data.count) / bytes
                    print("Original Bytes = \(data.count)")
                    print("Expected Bytes = \(bytes)")
                    if (Float(data.count) <= bytes) {
                        complete = true
                        let img = UIImage(data: data)
                        if img != nil
                        {
                            return img!
                        }
                        else{
                            return holderImage
                        }
                    } else {
                        let multiplier:CGFloat = CGFloat((ratio / 10) + 1)
                        compression -= (step * multiplier)
                    }
                }
                
                guard let newImage = holderImage.resized(withPercentage: compression) else { break }
                holderImage = newImage
            }
            return holderImage
        }
}
extension UIView{
    static let loadingViewTag = 11111111111
    func showCLoader(style: UIActivityIndicatorView.Style = .medium) {
        let image = UIImageView()
//        image.loadGif(name: "animationBlue")
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }

        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
        loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func stopCLoader() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}

extension UIScrollView {
    func scrollToView(view:UIView, animated: Bool) {
        if let superview = view.superview {
            let child = superview.convert(view.frame, to: self)
            let visible = CGRect(origin: contentOffset, size: visibleSize)
            let newOffsetX = child.minX < visible.minX ? child.minX : child.maxX > visible.maxX ? child.maxX - visible.width : nil
            if let x = newOffsetX {
                setContentOffset(CGPoint(x:x, y: 0), animated: animated)
            }
        }
    }
}

extension UIImage {
    func addPadding(_ padding: CGFloat) -> UIImage {
        let alignmentInset = UIEdgeInsets(top: -padding, left: -padding,
                                          bottom: -padding, right: -padding)
        return withAlignmentRectInsets(alignmentInset)
    }
}


public extension UIImageView {

    func removeInitials(){
//        self.subviews.forEach{ view in
//            if view.tag == 10001{
//                view.removeFromSuperview()
//            }
//            else{}
//        }
//        self.layer.cornerRadius = self.bounds.size.height / 2.1
//        self.backgroundColor = .clear
//        self.clipsToBounds = true
    }
    
    func addInitials(initialsText: String, fontSize: CGFloat? = 16.0) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        self.image = UIImage()
        let initials = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        initials.tag = 10001
        initials.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        initials.textAlignment = .center
        initials.text = initialsText.uppercased()
        initials.textColor = UIColor.blue
        initials.font = UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(16.0))
        self.backgroundColor = UIColor.blue
        self.layer.cornerRadius = self.bounds.size.height / 2.1
        self.clipsToBounds = true
        self.addSubview(initials)
    }
}

extension UIButton{
    func removeInitials(){
        self.subviews.forEach{ view in
            if view.tag == 10002{
                view.removeFromSuperview()
            }
            else{}
        }
        self.layer.cornerRadius = self.bounds.size.height / 2.1
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.setImage(UIImage(), for: .normal)
    }
    func addInitials(initialsText: String, fontSize: CGFloat? = 12.0) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        let initials = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width * 0.67, height: self.bounds.height * 0.67))
        initials.tag = 10002
        initials.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        initials.textAlignment = .center
        initials.text = initialsText.uppercased()
        initials.textColor = UIColor.blue
        initials.font = UIFont(name: "RedHatText-Bold", size: fontSize ?? CGFloat(12.0))
        initials.backgroundColor = UIColor.blue
        initials.layer.cornerRadius = initials.bounds.size.height / 2.1
        initials.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.size.height / 2.1
        self.clipsToBounds = true
        self.addSubview(initials)
    }
}


extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
  
}

extension UILabel{
    
    func setBlueBackWithWhiteText(){
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor.blue
        self.textColor = .white
    }
    
    func setClearBackWithBlueText(){
        self.layer.backgroundColor = UIColor.init(hex: "#F3FBFE", alpha: 1).cgColor
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
        self.textColor = UIColor.blue
    }
    
}


extension UILabel{
    func justifyContent(){
        let sampleText = self.text ?? ""
        self.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified

        let attributedString = NSAttributedString(string: sampleText,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.baselineOffset: NSNumber(value: 0)
            ])
        
        self.attributedText = attributedString
    }
}
