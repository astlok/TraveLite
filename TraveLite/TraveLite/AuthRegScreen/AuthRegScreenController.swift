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
        input.addTarget(self, action: #selector(checkLogin), for: .editingChanged)
        input.addTarget(self, action: #selector(checkLogin), for: .editingDidBegin)

        return input
    }()
    
    let loginInputSuggestMes: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Логин должен быть длиннее 4 символов"
        label.isHidden = true
        
        return label
    }()
    
    let emailInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите e-mail"
        input.translatesAutoresizingMaskIntoConstraints = false
        input.addTarget(self, action: #selector(checkValidEmail), for: .editingChanged)
        input.addTarget(self, action: #selector(checkValidEmail), for: .editingDidBegin)
        
        return input
    }()
    
    let emailInputSuggestMes: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Введите корректный email"
        label.isHidden = true

        return label
    }()
    
    let passwordInput: InputView = {
        let input = InputView()
        input.placeholder = "Введите пароль"
        input.isSecureTextEntry = true
        input.translatesAutoresizingMaskIntoConstraints = false
        
        input.addTarget(self, action: #selector(checkPassword), for: .editingChanged)
        input.addTarget(self, action: #selector(checkPassword), for: .editingDidBegin)
        
        return input
    }()
    
    let passwordInputSuggestMes: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Пароль должен быть длиннее 8 символов"
        label.isHidden = true

        return label
    }()
    
    let confirmPasswordInput: InputView = {
        let input = InputView()
        input.placeholder = "Повторите пароль"
        input.isSecureTextEntry = true
        input.translatesAutoresizingMaskIntoConstraints = false
        
        input.addTarget(self, action: #selector(confirmPassword), for: .editingChanged)
        input.addTarget(self, action: #selector(confirmPassword), for: .editingDidBegin)
        
        return input
    }()
    
    let confirmInputSuggestMes: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Пароли должны совпадать"
        label.isHidden = true

        return label
    }()
    
    let submitButton: SubmitButtonView = {
        let button = SubmitButtonView()
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
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
        loginInput.text = ""
        loginInput.layer.borderColor = UIColor.gray.cgColor
        loginInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loginInput.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 15).isActive = true
        loginInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        loginInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(loginInputSuggestMes)
        loginInputSuggestMes.isHidden = true
        loginInputSuggestMes.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loginInputSuggestMes.topAnchor.constraint(equalTo: loginInput.bottomAnchor, constant: 2).isActive = true
        loginInputSuggestMes.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(emailInput)
        emailInput.text = ""
        emailInput.layer.borderColor = UIColor.gray.cgColor
        emailInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        emailInput.topAnchor.constraint(equalTo: loginInputSuggestMes.bottomAnchor, constant: 7).isActive = true
        emailInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(emailInputSuggestMes)
        emailInputSuggestMes.isHidden = true
        emailInputSuggestMes.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        emailInputSuggestMes.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 2).isActive = true
        emailInputSuggestMes.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(passwordInput)
        passwordInput.text = ""
        passwordInput.layer.borderColor = UIColor.gray.cgColor
        passwordInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        passwordInput.topAnchor.constraint(equalTo: emailInputSuggestMes.bottomAnchor, constant: 7).isActive = true
        passwordInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        passwordInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(passwordInputSuggestMes)
        passwordInputSuggestMes.isHidden = true
        passwordInputSuggestMes.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        passwordInputSuggestMes.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 2).isActive = true
        passwordInputSuggestMes.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(confirmPasswordInput)
        confirmPasswordInput.text = ""
        confirmPasswordInput.layer.borderColor = UIColor.gray.cgColor
        confirmPasswordInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        confirmPasswordInput.topAnchor.constraint(equalTo: passwordInputSuggestMes.bottomAnchor, constant: 7).isActive = true
        confirmPasswordInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        confirmPasswordInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        contentView.addSubview(confirmInputSuggestMes)
        confirmInputSuggestMes.isHidden = true
        confirmInputSuggestMes.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        confirmInputSuggestMes.topAnchor.constraint(equalTo: confirmPasswordInput.bottomAnchor, constant: 2).isActive = true
        confirmInputSuggestMes.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(submitButton)
        submitButton.setTitle("Создать аккаунт", for: .normal)
        submitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: confirmInputSuggestMes.bottomAnchor, constant: 15).isActive = true
        submitButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        regAuthButton.setTitle("Авторизация", for: .normal)
        regAuthButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        regAuthButton.layer.cornerRadius = 10
        regAuthButton.backgroundColor = .systemGray4
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
        emailInput.text = ""
        emailInput.layer.borderColor = UIColor.gray.cgColor
        emailInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        emailInput.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 15).isActive = true
        emailInput.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        
        contentView.addSubview(passwordInput)
        passwordInput.text = ""
        passwordInput.layer.borderColor = UIColor.gray.cgColor
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
        regAuthButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        regAuthButton.layer.cornerRadius = 10
        regAuthButton.backgroundColor = .systemGray4
        contentView.addSubview(regAuthButton)
        regAuthButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        regAuthButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 15).isActive = true
        regAuthButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        regAuthButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        regAuthButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    @objc
    func checkLogin(_ sender: UITextField) {
        if isAuthScreen {
            return
        }
        if sender.text?.count ?? 0 < 4 {
            sender.layer.borderColor = UIColor.red.cgColor
            loginInputSuggestMes.isHidden = false
        } else {
            sender.layer.borderColor = UIColor.green.cgColor
            loginInputSuggestMes.isHidden = true
        }
    }
    
    @objc
    func checkPassword(_ sender: UITextField) {
        if isAuthScreen {
            return
        }
        if sender.text?.count ?? 0 > 8 {
            sender.layer.borderColor = UIColor.green.cgColor
            passwordInputSuggestMes.isHidden = true
        } else {
            sender.layer.borderColor = UIColor.red.cgColor
            passwordInputSuggestMes.isHidden = false
        }
    }
    
    
    @objc
    func checkValidEmail(_ sender: UITextField) {
        if isAuthScreen {
            return
        }
        if isValidEmail(sender.text ?? "") {
            sender.layer.borderColor = UIColor.green.cgColor
            emailInputSuggestMes.isHidden = true
        } else {
            sender.layer.borderColor = UIColor.red.cgColor
            emailInputSuggestMes.isHidden = false
        }
    }
    
    @objc
    func confirmPassword(_ sender: UITextField) {
        if isAuthScreen {
            sender.layer.borderColor = UIColor.gray.cgColor
            return
        }
        if sender.text == passwordInput.text && sender.text != "" {
            sender.layer.borderColor = UIColor.green.cgColor
            confirmInputSuggestMes.isHidden = true
        } else {
            sender.layer.borderColor = UIColor.red.cgColor
            confirmInputSuggestMes.isHidden = false
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension AuthRegScreenViewController: AuthRegScreenViewInput {
}
