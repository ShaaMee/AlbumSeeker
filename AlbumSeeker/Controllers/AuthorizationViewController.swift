//
//  AuthorizationViewController.swift
//  AlbumSeeker
//
//  Created by user on 30.11.2021.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    private var mainView: AuthorizationView {
        guard let view = view as? AuthorizationView else { return AuthorizationView() }
        return view
    }
    
    override func loadView() {
        view = AuthorizationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    @objc private func authorize(){
        
        // TODO: - Authorization logic here
        
        let navigationVC = UINavigationController(rootViewController: SearchViewController())
        navigationVC.modalPresentationStyle = .fullScreen
        navigationVC.modalTransitionStyle = .crossDissolve
        present(navigationVC, animated: true, completion: nil)
    }
    
    @objc private func signUp(){
        
        // TODO: - Signing up logic here
        
        let signUpViewController = CreateAccountViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    private func setupViewController() {
        
        mainView.authorizeButton.addTarget(self, action: #selector(authorize), for: .touchUpInside)
        mainView.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        hideKeyboardWhenTappedAround()
    }
}
