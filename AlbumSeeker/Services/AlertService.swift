//
//  AlertService.swift
//  AlbumSeeker
//
//  Created by user on 03.12.2021.
//

import UIKit

class AlertService {
    static let shared = AlertService()
    
    private init(){}
    
    func showAlertWith(messeage: String, inViewController vc: UIViewController, completion: (() -> ())? = nil){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Attention please!", message: messeage, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            vc.present(alert, animated: true, completion: completion)
        }
    }
}
