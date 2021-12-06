//
//  CreateAccountViewController+.swift
//  AlbumSeeker
//
//  Created by user on 06.12.2021.
//
//  TextField Extension to match phone mask


import UIKit

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
