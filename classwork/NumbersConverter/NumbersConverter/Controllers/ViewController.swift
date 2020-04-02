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
    var selectedIndex: (from: Int, to: Int) = (from: 8, to: 0)
//MARK: IBOutlets and Views properties
    @IBOutlet weak var fromNumTextField: UnderlinedTextField!
    @IBOutlet weak var fromBaseTextField: UnderlinedTextField!
    @IBOutlet weak var toNumTextField: UnderlinedTextField!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toBaseTextField: UnderlinedTextField!
    @IBOutlet weak var toLabel: UILabel!
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
    
//MARK: To Do
    /// Decode given digits in given base to number in base 10.
    /// - Parameters:
    ///   - digits: string representation of number (in given base)
    ///   - base: base of given number
    /// - Returns: integer representation of number (in base 10)
    func decodeNumbers(digits: String, base: Int) -> Int {
        var result: Int = -1
        // TODO: Decode digits from binary (base 2)
        // ...
        // TODO: Decode digits from hexadecimal (base 16)
        // ...
        // TODO: Decode digits from any base (2 up to 36)
        // ...
        return result
    }

    
    /// Encode given number in base 10 to digits in given base
    /// - Parameters:
    ///   - number: integer representation of number (in base 10)
    ///   - base: base to convert to
    /// - Returns: string representation of number (in given base)
    func encodeNumbers(number: Int, base: Int) -> String {
        var result: String = ""
        // Handle unsigned numbers only for now
//        assert number >= 0, 'number is negative: {}'.format(number)
        // TODO: Encode number in binary (base 2)
        // ...
        // TODO: Encode number in hexadecimal (base 16)
        // ...
        // TODO: Encode number in any base (2 up to 36)
        // ...
        return result
    }
    
    /// Convert given digits in base1 to digits in base2.
    /// - Parameters:
    ///   - digits: string representation of number (in base1)
    ///   - base1: base of given number
    ///   - base2: base to convert to
    /// - Returns: string representation of number (in base2)
    func convertNumbers(digits: String, base1: Int, base2: Int) -> String {
        var result: String = ""
        // Handle up to base 36 [0-9a-z]
//        assert 2 <= base1 <= 36, 'base1 is out of range: {}'.format(base1)
//        assert 2 <= base2 <= 36, 'base2 is out of range: {}'.format(base2)
        // TODO: Convert digits from base 2 to base 16 (and vice versa)
        // ...
        // TODO: Convert digits from base 2 to base 10 (and vice versa)
        // ...
        // TODO: Convert digits from base 10 to base 16 (and vice versa)
        // ...
        // TODO: Convert digits from any base to any base (2 up to 36)
        // ...
        return result
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
        fromNumTextField.keyboardType = .default
        fromNumTextField.clearButtonMode = .always
        fromNumTextField.text = String(0)
        fromNumTextField.inputAccessoryView = keyboardToolBar //add toolBar
        //toNum
        toNumTextField.delegate = self
        toNumTextField.keyboardType = .default
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
    
///checks if textField.text is a valid input
    fileprivate func checkNumberInput(tf: UnderlinedTextField, base: Base) {
        if !isValidNumber(text: tf.text!, base: bases[selectedIndex.from]) { //if input is invalid, turn it red, maybe show error as well
            tf.setUnderlineColor(color: .red)
        } else { //if no errors on input, return back to default color
            tf.setDefaultUnderlineColor()
        }
    }
    
/// Checks if from/to NumTextField text input is valid
/// - Parameters:
///   - text: from/to NumTextField.text
///   - base: from/to baseTextField's base
/// - Returns: true if valid, and should encode or decode
    fileprivate func isValidNumber(text: String, base: Base) -> Bool {
        let impossibleCharacters: [String] = base.getImpossibleCharacters()
        print("Base \(base.rawValue)'s impossile chars \(impossibleCharacters)")
        let isFrom: Bool = text == fromNumTextField.text ? true : false
        for char in impossibleCharacters where text.contains(char) { //if text contains one of he impossible characters, then it is not valid
//            print(char, " in ", text, " is not a valid for base ", base.rawValue)
            if isFrom {
                fromLabel.text = "\(char) is not a valid for base \(base.rawValue)"
                fromLabel.textColor = .red
            } else {
                toLabel.text = "\(char) is not a valid for base \(base.rawValue)"
                toLabel.textColor = .red
            }
            return false
        }
        if isFrom {
            fromLabel.text = "From:"
            fromLabel.textColor = .black
        } else {
            toLabel.text = "To: "
            toLabel.textColor = .black
        }
        return true
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
            checkNumberInput(tf: fromNumTextField, base: base) //check if input is valid
        } else if pickerView == toPicker {
            selectedIndex.to = row
            let base = bases[selectedIndex.to] //assign the answer of the question in
            toBaseTextField.text = String(base.rawValue)
            checkNumberInput(tf: toNumTextField, base: base) //check if input is valid
        }
    }
}

//MARK: TextField
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let tf = textField as? UnderlinedTextField else { return } //make sure it's an underlined tf
        switch tf {
        case fromNumTextField:
            switch tf.text?.trimmedString() { //if textfield was empty, add 0
            case "":
                tf.text = "0"
            default:
                break
            }
        case toNumTextField:
            switch tf.text?.trimmedString() { //if textfield was empty, add 0
            case "":
                tf.text = "0"
            default:
                break
            }
        default:
            break
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let tf = textField as? UnderlinedTextField else { return } //make sure it's an underlined tf
        tf.text = textField.text?.uppercased() //forces all inputs to be capitalized
        switch tf {
        case fromNumTextField:
            checkNumberInput(tf: tf, base: bases[selectedIndex.from]) //check if input is valid
        case toNumTextField:
            checkNumberInput(tf: tf, base: bases[selectedIndex.to]) //check if input is valid
        default:
            break
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let tf = textField as? UnderlinedTextField else { return } //make sure it's an underlined tf
        switch tf {
        case fromNumTextField:
            switch tf.text?.trimmedString() {
            case "0": //if text field was 0 at the beginning, remove the 0
                tf.text = ""
            default:
                break
            }
        case toNumTextField:
            switch tf.text?.trimmedString() {
            case "0":
                tf.text = ""
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
///setups the keyboard observers in order to be able to hide or not hide
    fileprivate func setupKeyboardNotifications() { //setup notifications when keyboard shows or hide
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
///remove keyboard observers, must call when view disappears
    fileprivate func removeKeyboardObervers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
///moves view up when keyboard appears
    @objc func keyboardWillShow(notification: NSNotification) { //makes the view go up by keyboard's height
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height / 1.7
            }
        }
    }
///moves view back down to original y when keyboard disappears
    @objc func keyboardWillHide(notification: NSNotification) { //put the view back to 0
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}
