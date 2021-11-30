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
        
        mainView.authorizeButton.addTarget(self, action: #selector(authorize), for: .touchUpInside)
        mainView.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    @objc private func authorize(){
        
    }

    @objc private func signUp(){
        let signUpViewController = CreateAccountViewController()
        present(signUpViewController, animated: true, completion: nil)
    }
}
