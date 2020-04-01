//
//  ViewController.swift
//  NumbersConverter
//
//  Created by Macbook Pro 15 on 3/31/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//MARK: Properties
    var bases: [Base] = []
//MARK: IBOutlets
    @IBOutlet weak var fromNumTextField: UnderlinedTextField!
    @IBOutlet weak var fromBaseTextField: UnderlinedTextField!
    @IBOutlet weak var toNumTextField: UnderlinedTextField!
    @IBOutlet weak var toBaseTextField: UnderlinedTextField!
    var fromPicker = UIPickerView()
    var toPicker = UIPickerView()
    var selectedIndex: (from: Int, to: Int) = (from: 0, to: 0)
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        setupKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObervers()
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        fromPicker.delegate = self
        toPicker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissTap(_:)))
        self.view.addGestureRecognizer(tap)
        fromNumTextField.keyboardType = .numberPad
        fromNumTextField.clearButtonMode = .always
        toNumTextField.keyboardType = .numberPad
        toNumTextField.clearButtonMode = .always
        setupBaseTextFields()
    }

    fileprivate func setupBaseTextFields() {
        createBases()
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.handleDismissTap(_:)))
        toolBar.setItems([flexibleBar, doneButton], animated: true)
        
        fromBaseTextField.inputAccessoryView = toolBar
        fromBaseTextField.inputView = fromPicker
        fromBaseTextField.clearButtonMode = .never
        let fromBase = String(bases[0].intValue)
        fromBaseTextField.text = fromBase
        
        toBaseTextField.inputAccessoryView = toolBar
        toBaseTextField.inputView = toPicker
        toBaseTextField.clearButtonMode = .never
        let toBase = bases[0].intValue
        toBaseTextField.text = String(toBase)
        print("selected index=", selectedIndex)
    }
    
    fileprivate func createBases() {
        bases = Base.allCases
        toPicker.reloadAllComponents()
        fromPicker.reloadAllComponents()
    }
    
//MARK: IBActions
    
//MARK: Helpers
    @objc func showOptions(controller: UIViewController) {
    }
    
    @objc func handleDismissTap(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

//MARK: Extensions
//MARK: PickerView DataSource and Delegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == fromPicker { //picker's title for each row
            selectedIndex.from = row //update title based on selectedIndex base on the row
            return String(bases[selectedIndex.from].intValue)
        } else if pickerView == toPicker {
            selectedIndex.to = row
            return String(bases[selectedIndex.to].intValue)
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromPicker {
            let answer = bases[selectedIndex.from]
            print("From Row: ", row)
            print("From: ", answer)
        } else if pickerView == toPicker {
            let answer = bases[selectedIndex.to] //assign the answer of the question in the array as the question's answer
            print("To Row: ", row)
            print("To: ", answer)
        }
    }
}

//MARK: TextField
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
//        tableView.reloadData() //reload only after editing, or clicking done
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
////        if textField == myTextField {
////            print("You edit myTextField")
////        }
//    }
}

//MARK: Keyboard Helpers
extension ViewController {
    fileprivate func setupKeyboardNotifications() { //setup notifications when keyboard shows or hide
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func removeKeyboardObervers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) { //makes the view go up by keyboard's height
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) { //put the view back to 0
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}