//
//  ContactViewController.swift
//  CloudKitChallenge
//
//  Created by Michael Castillo on 3/3/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func phoneNumberFieldTapped(_ sender: Any) {
        phoneNumberTextField.keyboardType = UIKeyboardType.decimalPad
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text,
            let name = nameTextField.text,
            let phoneNumber = phoneNumberTextField.text
            else { return }
        
        ContactController.saveContact(name: name, email: email, phoneNumber: phoneNumber)
        _ = navigationController?.popViewController(animated: true)
        
    }

}
