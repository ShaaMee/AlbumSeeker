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
        
        mainView.phoneNumberTextField.delegate = self
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
            AlertService.shared.showAlertWith(messeage: "New user is created! Now you can log in with your email", inViewController: self) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        catch let error {
            AlertService.shared.showAlertWith(messeage: error.localizedDescription, inViewController: self)
        }
    }
    
    private func validateTextFields() -> Bool {
        guard let englishLettersRegEx = try? NSRegularExpression(pattern: "[a-z]+", options: .caseInsensitive),
              let phoneNumberRegEx = try? NSRegularExpression(pattern: "[+7][(][0-9]{3}[)][0-9]{3}[-][0-9]{2}[-][0-9]{2}"),
              let emailRegEx = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
                                                        options: .caseInsensitive),
              let passwordRegEx = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%]{6,}") else { return false}
        
        guard englishLettersRegEx.matches(mainView.nameTextField.text!),
              englishLettersRegEx.matches(mainView.surnameTextField.text!) else {
            AlertService.shared.showAlertWith(messeage: "Name and surname should contain english letters only.", inViewController: self)
            return false
        }
        
        guard let text = mainView.ageTextField.text,
              let age = Int32(text) else {
            AlertService.shared.showAlertWith(messeage: "Age should be a positive number", inViewController: self)
            return false}
        guard age >= 18 else {
            AlertService.shared.showAlertWith(messeage: "You should be at least 18 years old", inViewController: self)
            return false
        }
        
        guard phoneNumberRegEx.matches(mainView.phoneNumberTextField.text!) else {
            AlertService.shared.showAlertWith(messeage: "Phone number isn't correct", inViewController: self)
            return false
        }
        guard emailRegEx.matches(mainView.emailTextField.text!) else {
            AlertService.shared.showAlertWith(messeage: "Email is incorrect", inViewController: self)
            return false
        }
        
        guard passwordRegEx.matches(mainView.passwordTextField.text!) else {
            AlertService.shared.showAlertWith(messeage: "Password should contain at least 6 symbols", inViewController: self)
            return false
        }
        return true
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TextField Extension to match phone mask

extension CreateAccountViewController: UITextFieldDelegate {
    
    private func formatPhoneNumber(with mask: String, phoneNumber: String) -> String {
        let numbers = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
                
        for symbol in mask where index < numbers.endIndex {
            if symbol == "X" && result.contains("+7") && result.count > 2 {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else if symbol == "7" && numbers[index] == "7"{
                result.append(symbol)
                index = numbers.index(after: index)
            }
            else {
                result.append(symbol)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formatPhoneNumber(with: "+7(XXX)XXX-XX-XX", phoneNumber: newString)
        return false
    }
}
