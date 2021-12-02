//
//  AuthorizationViewController.swift
//  AlbumSeeker
//
//  Created by user on 30.11.2021.
//

import UIKit
import CoreData

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
    
    private func setupViewController() {
        
        mainView.authorizeButton.addTarget(self, action: #selector(authorize), for: .touchUpInside)
        mainView.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        hideKeyboardWhenTappedAround()
    }
    
    @objc private func authorize(){
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        guard let emailText = mainView.emailTextField.text else { return }
        
        do {
            let request = UserInfo.fetchRequest() as NSFetchRequest<UserInfo>
            let predicate = NSPredicate(format: "email == %@", emailText)
            request.predicate = predicate
            
            let allUsersData = try context.fetch(request)
            guard !allUsersData.isEmpty else {
                AlertService.shared.showAlertWith(messeage: "No such user is registered", inViewController: self)
                return
            }
            for userData in allUsersData {
                guard userData.password == mainView.passwordTextField.text else {
                    AlertService.shared.showAlertWith(messeage: "Wrong password! Please try again.", inViewController: self)
                    return
                }
                print("User email is: emailText")
                login()
            }
            
        }
        catch {
            AlertService.shared.showAlertWith(messeage: "No such user is registered", inViewController: self)
        }
    }
    
    private func login(){
        
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
}
