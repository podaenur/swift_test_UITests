//
//  ViewControllers.swift
//  swift_test_UITests
//
//  Created by Evgeniy Akhmerov on 20/01/17.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

protocol Configurable {
    func configure(with model: AnyObject)
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    struct Constants {
        static let checkItSegueIdentifier = "checkItSegue"
        static let chars = CharacterSet(charactersIn: "0123456789")
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            
        }
    }
    @IBOutlet weak var checkItButton: UIButton!
    
    //MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        performUIAvailability()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        textField.resignFirstResponder()
    }
    
    //MARK: - UIViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? Configurable else { return }
        
        controller.configure(with: textField.text as AnyObject)
    }
    
    //MARK: - Private
    
    private func performUIAvailability() {
        checkItButton.isEnabled = textField.hasText
    }
    
    //MARK: - Actions
    
    @IBAction func onTextChanged(_ sender: UITextField) {
        print(sender.text ?? "")
        checkItButton.isEnabled = sender.hasText
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        performUIAvailability()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (string.rangeOfCharacter(from: Constants.chars.inverted)) == nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: Constants.checkItSegueIdentifier, sender: textField)
        return true
    }
}

class PreviewViewController: UIViewController, Configurable {
    
    //MARK: - Properties
    
    private var message: String?
    
    //MARK: - Outlets
    
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.text = message
        }
    }
    
    //MARK: - Configurable
    
    func configure(with model: AnyObject) {
        message = model as? String
    }
}
