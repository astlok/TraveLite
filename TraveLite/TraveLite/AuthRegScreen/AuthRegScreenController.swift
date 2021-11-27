import UIKit

final class AuthRegScreenViewController: UIViewController {
    private let output: AuthRegScreenViewOutput
    
    private var isAuthScreen = true

    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let loginInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите логин"
        input.translatesAutoresizingMaskIntoConstraints = false
        
        return input
    }()
    
    let emailInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите e-mail"
        input.translatesAutoresizingMaskIntoConstraints = false
        
        return input
    }()
    
    let passwordInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите пароль"
        input.isSecureTextEntry = true
        input.translatesAutoresizingMaskIntoConstraints = false
        
        return input
    }()
    
    let confirmPasswordInput: InputView = {
        let input = InputView()
        input.placeholder = "Повторите пароль"
        input.isSecureTextEntry = true
        input.translatesAutoresizingMaskIntoConstraints = false
        
        return input
    }()
    
    let submitButton: SubmitButtonView = {
        let button = SubmitButtonView()
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)
        button.addTarget(self, action: #selector(tapSubmitButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let regAuthButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)
        button.addTarget(self, action: #selector(tapRegAuthButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    let contentView = UIView()
    let scrollView = UIScrollView()
    var bottomConstraint: NSLayoutConstraint?
    var topLabelConstraint: NSLayoutConstraint?
    
    init(output: AuthRegScreenViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        
        modalPresentationStyle = .fullScreen
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        setupScrollView()
        
        setupAuthViews()
    }

    @objc
    func tapSubmitButton() {
        //TODO: сделать валидацию
        if !isAuthScreen {
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

            output.didTapRegSubmitButton(with: user)
        } else {
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
            
            output.didTapAuthSubmitButton(with: user)
        }
    }

    @objc
    func tapRegAuthButton() {
        if isAuthScreen {
            setupRegViews()
            isAuthScreen = false
        } else {
            setupAuthViews()
            isAuthScreen = true
        }
    }

    @objc
    func keyboardWillShow(sender: NSNotification) {
        bottomConstraint?.isActive = false
        
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardHeight)
            bottomConstraint?.isActive = true
//            
//            topLabelConstraint?.isActive = false
//            topLabelConstraint = textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
//            topLabelConstraint?.isActive = true
            
            self.view.layoutIfNeeded()
        }
    }

    @objc
    func keyboardWillHide(sender: NSNotification) {
        bottomConstraint?.isActive = false
        
        bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint?.isActive = true
        
//        let topConst:  CGFloat =  {
//            var const: CGFloat
//            if isAuthScreen {
//                const = 150
//            } else {
//                const = 200
//            }
//            return const
//        }()
//        
//        topLabelConstraint?.isActive = false
//        topLabelConstraint = textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topConst)
//        topLabelConstraint?.isActive = true

        self.view.layoutIfNeeded()
    }
    
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint?.isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    func setupRegViews(){
        contentView.subviews.forEach({ $0.removeFromSuperview()})
        
        textLabel.text = "Регистрация"
        contentView.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        topLabelConstraint?.isActive = false
        topLabelConstraint = textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.bounds.height / 2 - 200)
        topLabelConstraint?.isActive = true
        
        textLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(loginInput)
        loginInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loginInput.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 15).isActive = true
        loginInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        loginInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(emailInput)
        emailInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        emailInput.topAnchor.constraint(equalTo: loginInput.bottomAnchor, constant: 15).isActive = true
        emailInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(passwordInput)
        passwordInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 15).isActive = true
        passwordInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        passwordInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(confirmPasswordInput)
        confirmPasswordInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        confirmPasswordInput.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 15).isActive = true
        confirmPasswordInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        confirmPasswordInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(submitButton)
        submitButton.setTitle("Создать аккаунт", for: .normal)
        submitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: confirmPasswordInput.bottomAnchor, constant: 15).isActive = true
        submitButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        regAuthButton.setTitle("Авторизация", for: .normal)
        contentView.addSubview(regAuthButton)
        regAuthButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        regAuthButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 15).isActive = true
        regAuthButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        regAuthButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        regAuthButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    func setupAuthViews(){
        contentView.subviews.forEach({ $0.removeFromSuperview()})
        
        textLabel.text = "Авторизация"
        contentView.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        topLabelConstraint?.isActive = false
        topLabelConstraint = textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.bounds.height / 2 - 150)
        topLabelConstraint?.isActive = true
        
        textLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        
        contentView.addSubview(emailInput)
        emailInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        emailInput.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 15).isActive = true
        emailInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        
        contentView.addSubview(passwordInput)
        passwordInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 15).isActive = true
        passwordInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        passwordInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(submitButton)
        submitButton.setTitle("Войти", for: .normal)
        submitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 15).isActive = true
        submitButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        regAuthButton.setTitle("Регистрация", for: .normal)
        contentView.addSubview(regAuthButton)
        regAuthButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        regAuthButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 15).isActive = true
        regAuthButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        regAuthButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        regAuthButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
}

extension AuthRegScreenViewController: AuthRegScreenViewInput {
}
