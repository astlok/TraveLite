import UIKit

final class AuthScreenViewController: UIViewController {
	private let output: AuthScreenViewOutput
    
    let label: UILabel = UILabel(frame: CGRect(x: 67, y: 0, width: 166.00, height: 30.00))
    let emailInput: InputView = InputView(frame: CGRect(x: 0, y: 42, width: 300.00, height: 55.00));
    let passwordInput: InputView = InputView(frame: CGRect(x: 0, y: 105, width: 300.00, height: 55.00));
    let submitButton: SubmitButtonView = SubmitButtonView(frame: CGRect(x: 0, y: 168, width: 300.00, height: 55.00));
    let regButton: UIButton = UIButton(frame: CGRect(x: 68, y: 236, width: 164.00, height: 17.00))
    var containerView = UIView()
    var bottomConstraint: NSLayoutConstraint?

    init(output: AuthScreenViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)

        label.textAlignment = .center
        label.text = "Авторизация"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 24)

        emailInput.placeholder = "Введите ваш e-mail"
        passwordInput.placeholder = "Введите пароль"
        passwordInput.isSecureTextEntry = true

        regButton.backgroundColor = .none
        regButton.setTitle("Создать аккаунт", for: .normal)
        regButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        regButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)
        
        submitButton.addTarget(self, action: #selector(tapSubmitButton), for: .touchUpInside)
        regButton.addTarget(self, action: #selector(tapRegButton), for: .touchUpInside)

        view.backgroundColor = .white
    }
   

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);

        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(label)
        containerView.addSubview(emailInput)
        containerView.addSubview(passwordInput)
        containerView.addSubview(submitButton)
        containerView.addSubview(regButton)
        
        view.addSubview(containerView)
        containerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 290).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint?.isActive = true
	}


    @objc
    func keyboardWillShow(sender: NSNotification) {
        let keyboardSize = (sender.userInfo?  [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue

        guard let keyboardHeight = keyboardSize?.height else {
            return
        }

        bottomConstraint?.isActive = false

        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardHeight)
        bottomConstraint?.isActive = true

        self.view.layoutIfNeeded()
    }
    
    @objc
    func keyboardWillHide(sender: NSNotification) {
        bottomConstraint?.isActive = false

        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint?.isActive = true

        self.view.layoutIfNeeded()
    }
    
    @objc
    func tapRegButton() {
        output.didTapRegButton()
    }
    
    @objc
    func tapSubmitButton() {
        var user: UserAuth = UserAuth.init(email: "", password: "")
        
        if let email = emailInput.text {
            user.email = email
        } else {
            print("NOT VALID")
        }
        
        if let password = passwordInput.text {
            user.password = password
        } else {
            print("NOT VALID")
        }
        
        output.didTapSubmitButton(with: user)
    }
}

extension AuthScreenViewController: AuthScreenViewInput {
}
