import UIKit

public protocol ValidatorInputDelegate: AnyObject {
    func didBeginEditing(_ input: ValidatorInput)
    func didChage(_ input: ValidatorInput)
    func didEndEditing(_ input: ValidatorInput, _ valid: Bool)
    func didReturn(_ input: ValidatorInput)
}

public class ValidatorInput: UITextField {
    public weak var validatorDelegate: ValidatorInputDelegate?
    public var inputEnable: Bool = true
    public var kind: ValidateType = .none
    public var padding = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    
    public var highlightedColor: UIColor = UIColor.clear
    public var disableColor: UIColor = UIColor.clear
    public var errorColor: UIColor = UIColor.red
    public var tempColor: UIColor = UIColor.clear
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    public lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        return view
    }()
    
    public lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .red
        label.text = ""
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    public convenience init (kind: ValidateType) {
        self.init()
        self.kind = kind
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViewCode()
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc public func textFieldDidChange() {
        
    }
    
}

extension ValidatorInput: ViewCode {
    
    public func configureSubViews() {
        addSubview(bgView)
        addSubview(titleLabel)
        addSubview(errorLabel)
    }
    
    public func configureAdditionalBehaviors() {
        delegate = self
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    public func configureConstraints() {
        pin(to: bgView)
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bgView.topAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 5),
            errorLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
        ])
        
        
    }
    
    public func configureAccessibility() { }
    
}

extension ValidatorInput: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        validatorDelegate?.didBeginEditing(self)
        
        UIView.animate(withDuration: 0.3) {
            if self.textColor == self.errorColor { self.textColor = self.tempColor }
            else { self.tempColor = self.textColor ?? .black }
            self.bgView.layer.borderColor = self.highlightedColor.cgColor
            self.bgView.layer.borderWidth = 2
            self.errorLabel.alpha = 0
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let t = self.text ?? ""
        let v = Validate.text(t, type: kind.self)
        
        if (v) {
            UIView.animate(withDuration: 0.3) {
                self.bgView.layer.borderColor = self.disableColor.cgColor
                self.bgView.layer.borderWidth = 1
                self.errorLabel.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.textColor = self.errorColor
                self.bgView.layer.borderColor = self.errorColor.cgColor
                self.bgView.layer.borderWidth = 2
                self.errorLabel.alpha = 1
            }
        }
        
        validatorDelegate?.didEndEditing(self, v)
        
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        validatorDelegate?.didReturn(self)
        return true
    }
    
}
