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
    lazy var keyboardToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.handleDismissTap(_:)))
        toolBar.setItems([flexibleBar, doneButton], animated: true)
        return toolBar
    }()
    var fromPicker = UIPickerView()
    var toPicker = UIPickerView()
    var selectedIndex: (from: Int, to: Int) = (from: 8, to: 0)
    
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
    
//MARK: Private Methods
    fileprivate func setupViews() {
        fromPicker.delegate = self
        toPicker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissTap(_:)))
        self.view.addGestureRecognizer(tap)
        setupNumTextFields()
        setupBaseTextFields()
    }
    
    fileprivate func setupNumTextFields() {
        //fromNum
        fromNumTextField.delegate = self
        fromNumTextField.keyboardType = .numberPad
        fromNumTextField.clearButtonMode = .always
        fromNumTextField.text = String(0)
        fromNumTextField.inputAccessoryView = keyboardToolBar //add toolBar
        //toNum
        toNumTextField.delegate = self
        toNumTextField.keyboardType = .numberPad
        toNumTextField.clearButtonMode = .always
        toNumTextField.text = String(0)
        toNumTextField.inputAccessoryView = keyboardToolBar //add toolBar
    }

    fileprivate func setupBaseTextFields() {
        createBases()
        //fromBase
        fromBaseTextField.inputAccessoryView = keyboardToolBar
        fromBaseTextField.inputView = fromPicker //make pickerView the input
        fromBaseTextField.clearButtonMode = .never
        let fromBaseText = String(bases[selectedIndex.from].rawValue)
        fromBaseTextField.text = fromBaseText
        fromPicker.selectRow(selectedIndex.from, inComponent: 0, animated: true)
        //toBase
        toBaseTextField.inputAccessoryView = keyboardToolBar
        toBaseTextField.inputView = toPicker //make pickerView the input
        toBaseTextField.clearButtonMode = .never
        let toBaseText = bases[selectedIndex.to].rawValue
        toBaseTextField.text = String(toBaseText)
        toPicker.selectRow(selectedIndex.to, inComponent: 0, animated: true)
    }
    
    fileprivate func createBases() {
        bases = Base.allCases
        toPicker.reloadAllComponents()
        fromPicker.reloadAllComponents()
    }
    
///adds a binary, octal, decimal, or hex on picker title depending on row
    fileprivate func getPickerTitle(row: Int) -> String {
        var title: String = String(bases[row].rawValue)
        switch row {
        case 0:
            title += " (binary)"
        case 6:
            title += " (octal)"
        case 8:
            title += " (decimal)"
        case 14:
            title += " (hex)"
        default:
            break
        }
        return title
    }
    
//MARK: IBActions
    
//MARK: Helpers
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
            return getPickerTitle(row: row)
        } else if pickerView == toPicker {
            selectedIndex.to = row
            return getPickerTitle(row: row)
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromPicker {
            selectedIndex.from = row
            let base = bases[selectedIndex.from]
            fromBaseTextField.text = String(base.rawValue)
        } else if pickerView == toPicker {
            selectedIndex.to = row
            let base = bases[selectedIndex.to] //assign the answer of the question in
            toBaseTextField.text = String(base.rawValue)
        }
    }
}

//MARK: TextField
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case fromNumTextField:
            switch textField.text?.trimmedString() { //if textfield was empty, add 0
            case "":
                textField.text = "0"
            default:
                break
            }
        case toNumTextField:
            switch textField.text?.trimmedString() {
            case "":
                textField.text = "0"
            default:
                break
            }
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case fromNumTextField:
            switch textField.text?.trimmedString() {
            case "0": //if text field was 0 at the beginning, remove the 0
                textField.text = ""
            default:
                break
            }
        case toNumTextField:
            switch textField.text?.trimmedString() {
            case "0":
                textField.text = ""
            default:
                break
            }
        default:
            break
        }
    }
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
