//
//  MetabolicRateView.swift
//  CalorieTracker
//
//  Created by Wesley Calazans on 18/05/23.
//

import UIKit

public open class ValidatorInputPicker: ValidatorInput {
    var rotateEnabled = true
    var paddingEnabled = true
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrowGreenDown")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let frame = CGRect(x: bounds.minX+16, y: bounds.minY+4,
                           width: bounds.maxX-56, height: bounds.maxY-8)
        return paddingEnabled ? frame : super.editingRect(forBounds: bounds)
    }

}

public extension ValidatorInputPicker {
    func setup() {
        self.autocorrectionType = .no
        self.rightViewMode = .always        
        
        let v = UIView()
        v.widthAnchor.constraint(equalToConstant: 56).isActive = true
        v.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        v.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        rightView = v
        
        tintColor = .clear
    }
}

public extension ValidatorInputPicker {
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        if self.rotateEnabled {
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            })
        }
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        if self.rotateEnabled {
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return false
        }

        return false
    }
}