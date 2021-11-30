//
//  CreateAccountView.swift
//  AlbumSeeker
//
//  Created by user on 30.11.2021.
//

import UIKit

class CreateAccountView: UIView {
    
    let titleLabel = UILabel()
    let nameTextField = UITextField()
    let surnameTextField = UITextField()
    let ageTextField = UITextField()
    let phoneNumberTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let registerButton = UIButton(type: .system)
    let cancelButton = UIButton(type: .system)
    private let stackView = UIStackView()
    let stackViewItemHeight: CGFloat = 40
    let numberOfItemsInStackView: CGFloat = 9
    let stackViewSpacing: CGFloat = 12
    var stackViewHeight: CGFloat {
        (stackViewItemHeight * numberOfItemsInStackView) + (stackViewSpacing * (numberOfItemsInStackView - 1))
    }

    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupMainView()
        setupStackView()
        setupTitleLabel()
        setupTextFields()
        setupRegisterButton()
        setupCancelButton()
    }
    
    private func setupMainView() {
        backgroundColor = .systemBackground
    }
    
    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = stackViewSpacing
        addSubview(stackView)
        
        let allViewsInStack = [nameTextField, surnameTextField, ageTextField, phoneNumberTextField, emailTextField, passwordTextField, registerButton, cancelButton]
        
        for view in allViewsInStack {
            stackView.addArrangedSubview(view)
        }
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            stackView.heightAnchor.constraint(equalToConstant: stackViewHeight)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.text = "Create new account"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .secondaryLabel
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.topAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
    }
    
    private func setupTextFields() {
        let allTextFields = [nameTextField, surnameTextField, ageTextField, phoneNumberTextField, emailTextField, passwordTextField]
        
        basicSetupFor(textFields: allTextFields)
        setupNameTextField()
        setupSurnameTextField()
        setupAgeTextField()
        setupPhoneNumberTextField()
        setupEmailTextField()
        setupPasswordTextField()
    }
    
    private func basicSetupFor(textFields: [UITextField]) {
        
        for textField in textFields {
            textField.borderStyle = .roundedRect
            textField.adjustsFontSizeToFitWidth = true
            textField.backgroundColor = .systemGray5
            textField.clearButtonMode = .whileEditing
        }
    }
    
    private func setupNameTextField(){
        nameTextField.placeholder = "Name"
    }
    
    private func setupSurnameTextField(){
        surnameTextField.placeholder = "Surname"
    }
    
    private func setupAgeTextField(){
        ageTextField.placeholder = "Age"
    }
    
    private func setupPhoneNumberTextField(){
        phoneNumberTextField.placeholder = "Phone number"
    }
    
    private func setupEmailTextField(){
        emailTextField.placeholder = "E-mail"
    }
    
    private func setupPasswordTextField() {
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setupRegisterButton() {
        registerButton.layer.cornerRadius = 5
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    private func setupCancelButton() {
        cancelButton.layer.cornerRadius = 5
        cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }

}
