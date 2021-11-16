import UIKit

final class RegScreenViewController: UIViewController {
	private let output: RegScreenViewOutput

    let label: UILabel = UILabel(frame: CGRect(x: 67, y: 0, width: 166.00, height: 30.00))
    let loginInput: InputView = InputView(frame: CGRect(x: 0, y: 42, width: 300.00, height: 30.00));
    let emailInput: InputView = InputView(frame: CGRect(x: 0, y: 84, width: 300.00, height: 30.00));
    let passwordInput: InputView = InputView(frame: CGRect(x: 0, y: 126, width: 300.00, height: 30.00));
    let confirmPasswordInput: InputView = InputView(frame: CGRect(x: 0, y: 168, width: 300.00, height: 30.00));
    let submitButton: SubmitButtonView = SubmitButtonView(frame: CGRect(x: 0, y: 210, width: 300.00, height: 30.00));
    let containerView = UIView()
    var bottomConstraint: NSLayoutConstraint?

    init(output: RegScreenViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
 
//        modalPresentationStyle = .fullScreen

        label.textAlignment = .center
        label.text = "Регистрация"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 24)

        loginInput.placeholder = "Введите логин"
        emailInput.placeholder = "Введите e-mail"
        passwordInput.placeholder = "Введите пароль"
        passwordInput.isSecureTextEntry = true
        confirmPasswordInput.placeholder = "Повторите пароль"
        confirmPasswordInput.isSecureTextEntry = true

        //TODO: DEL THIS IN PROD
        passwordInput.autocorrectionType = .no
        confirmPasswordInput.autocorrectionType = .no
        //
        
        submitButton.setTitle("Создать аккаунт", for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        submitButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)

        submitButton.addTarget(self, action: #selector(tapSubmitButton), for: .touchUpInside)

        view.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);

        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(label)
        containerView.addSubview(loginInput)
        containerView.addSubview(emailInput)
        containerView.addSubview(passwordInput)
        containerView.addSubview(confirmPasswordInput)
        containerView.addSubview(submitButton)
        
        view.addSubview(containerView)
        containerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
	}
    
    @objc
    func tapSubmitButton() {
        //TODO: сделать валидацию
        var user: UserCreateRequest = UserCreateRequest.init(email: "", nickname: "", password: "")
        if let email = emailInput.text {
            user.email = email
        } else {
            print("NOT VALID")
        }
        if let nickname = loginInput.text {
            user.nickname = nickname
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
    
    @objc
    func keyboardWillShow(sender: NSNotification) {
        bottomConstraint?.isActive = false

        bottomConstraint = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
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
}

extension RegScreenViewController: RegScreenViewInput {
}
