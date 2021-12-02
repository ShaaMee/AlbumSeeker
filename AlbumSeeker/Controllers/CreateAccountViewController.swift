//
//  CreateAccountViewController.swift
//  AlbumSeeker
//
//  Created by user on 30.11.2021.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    private var mainView: CreateAccountView {
        guard let view = view as? CreateAccountView else { return CreateAccountView() }
        return view
    }
    
    override func loadView() {
        view = CreateAccountView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    private func setupViewController() {
        
        mainView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardShiftY = keyboardSize.height - (mainView.stackViewItemHeight * 4)
            
            if view.frame.origin.y == 0 && keyboardShiftY > 0 {
                view.frame.origin.y -= keyboardShiftY
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc private func registerButtonTapped() {
        
        guard validateTextFields() else { return }
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        guard let ageText = mainView.ageTextField.text,
              let ageInt32 = Int32(ageText) else { return }
        
        let newUser = UserInfo(context: context)
        newUser.name = mainView.nameTextField.text
        newUser.surname = mainView.surnameTextField.text
        newUser.age = ageInt32
        newUser.phoneNumber = mainView.phoneNumberTextField.text
        newUser.email = mainView.emailTextField.text
        newUser.password = mainView.passwordTextField.text
        
        do {
            try context.save()
            AlertService.shared.showAlertWith(messeage: "New user is created!", inViewController: self) {
                self.dismiss(animated: true)
            }
        }
        catch let error {
            AlertService.shared.showAlertWith(messeage: error.localizedDescription, inViewController: self)
        }
    }
    
    private func validateTextFields() -> Bool {
        
        // TODO: Validation logic here
        return true
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
