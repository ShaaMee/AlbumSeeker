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
        
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
