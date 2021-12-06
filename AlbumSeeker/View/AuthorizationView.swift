//
//  AuthorizationView.swift
//  AlbumSeeker
//
//  Created by user on 30.11.2021.
//

import UIKit

class AuthorizationView: UIView {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let authorizeButton = UIButton(type: .system)
    let signUpButton = UIButton(type: .system)
    private let stackView = UIStackView()

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
        setupEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupSingUpButton()
    }
    
    private func setupMainView() {
        backgroundColor = .systemBackground
    }
    
    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 12
        addSubview(stackView)
        
        [emailTextField, passwordTextField, authorizeButton, signUpButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -50),
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            stackView.heightAnchor.constraint(equalToConstant: 196)
        ])
    }
    
    
    private func setupEmailTextField() {
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Enter your e-mail"
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.backgroundColor = .systemGray5
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.keyboardType = .emailAddress
    }
    
    private func setupPasswordTextField() {
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .systemGray5
        passwordTextField.clearButtonMode = .whileEditing
    }
    
    private func setupSignInButton() {
        authorizeButton.layer.cornerRadius = 5
        authorizeButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        authorizeButton.setTitleColor(.black, for: .normal)
        authorizeButton.setTitle("Sign In", for: .normal)
        authorizeButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    private func setupSingUpButton() {
        signUpButton.layer.cornerRadius = 5
        signUpButton.titleLabel?.font = .systemFont(ofSize: 18)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.setTitle("Create new account", for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
}
