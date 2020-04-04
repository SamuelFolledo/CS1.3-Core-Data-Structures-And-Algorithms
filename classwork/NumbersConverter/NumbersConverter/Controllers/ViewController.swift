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
    /// Decode given digits and given base to number in base 10.
    /// - Parameters:
    ///   - digits: string representation of number (in given base)
    ///   - base: base of given number
    /// - Returns: integer representation of number (in base 10)
    func decodeNumbers(digits: String, base: Int) -> Int {
        if base < 2 || base > 36 { print("base error"); return -1 }
        var digitsAsBase10: Int = 0
        let digitsArray = Array(digits).reversed() //turn digits to array of characters
        guard let digitsBase = Base(rawValue: base) else { return -1 } //convert base to Base model
        var powerCounter = 0 //power
        for char in digitsArray { //loop through each character
            let charAsBase10 = digitsBase.getAsBase10(ofChar: char) //convert character to base 10
            digitsAsBase10 += charAsBase10 * Int(pow(Double(base), Double(powerCounter))) //multiply charAsBase10 and (base to the power of powerCounter)
            powerCounter += 1 //increment powerCounter
        }
        return digitsAsBase10
    }

    
    /// Encode given number in base 10 to digits in given base
    /// - Parameters:
    ///   - number: integer representation of number (in base 10)
    ///   - base: base to convert to
    /// - Returns: string representation of number (in given base)
    func encodeNumbers(number: Int, base: Int) -> String {
        if base < 2 || base > 36 { print("base error"); return "" }
        var encodedNumber: String = ""
        var currentQuotient: Int = number
        repeat {
            let quotientAndRemainder: (quotient: Int, remainder: Int) = currentQuotient.quotientAndRemainder(dividingBy: base) //get quotient and remainder
            let decodedRemainder: String = String(kPOSSIBLECHARACTERS[quotientAndRemainder.remainder]) //converts remainder to character
            encodedNumber = decodedRemainder + encodedNumber //add decodedRemainder at the beginning of result
            currentQuotient = quotientAndRemainder.quotient
        } while currentQuotient > 0 //while quotient > 0, keep dividing
        return encodedNumber
    }
    
    /// Convert given digits in base1 to digits in base2.
    /// - Parameters:
    ///   - digits: string representation of number (in base1)
    ///   - base1: base of given number
    ///   - base2: base to convert to
    /// - Returns: string representation of number (in base2)
    func convertNumbers(digits: String, base1: Int, base2: Int) -> String {
        var result: String = ""
        if base1 < 2 || base1 > 36 || base2 < 2 || base2 > 36  { print("base error"); return result }
        let decodedDigits = decodeNumbers(digits: digits, base: base1) //decode digits to base1
        result = encodeNumbers(number: decodedDigits, base: base2) //encode decodedDigits to base2
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
        let toBaseText = String(bases[selectedIndex.to].rawValue)
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
        if !isValidNumber(text: tf.text!, base: base) { //if input is invalid, turn it red, maybe show error as well
            tf.setUnderlineColor(color: .red)
        } else { //if no errors on input, return back to default color
            tf.setDefaultUnderlineColor()
            if tf == fromNumTextField {
                let convertedDigits: String = convertNumbers(digits: tf.text!, base1: Int(fromBaseTextField.text!)!, base2: Int(toBaseTextField.text!)!)
                toNumTextField.text = convertedDigits
            } else if tf == toNumTextField {
                let convertedDigits: String = convertNumbers(digits: tf.text!, base1: Int(toBaseTextField.text!)!, base2: Int(fromBaseTextField.text!)!)
                fromNumTextField.text = convertedDigits
            }
        }
    }
    
/// Checks if from/to NumTextField text input is valid
/// - Parameters:
///   - text: from/to NumTextField.text
///   - base: from/to baseTextField's base
/// - Returns: true if valid, and should encode or decode
    fileprivate func isValidNumber(text: String, base: Base) -> Bool {
        let impossibleCharacters: [Character] = base.getImpossibleCharacters()
        let isFrom: Bool = text == fromNumTextField.text ? true : false
        for char in impossibleCharacters where text.contains(char) { //if text contains one of he impossible characters, then it is not valid
            if isFrom {
                fromLabel.text = "\(char) is not valid for base \(base.rawValue)"
                fromLabel.textColor = .red
            } else {
                toLabel.text = "\(char) is not valid for base \(base.rawValue)"
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
            return getPickerTitle(row: row)
        } else if pickerView == toPicker {
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
        tf.text = textField.text?.lowercased() //forces all inputs to be capitalized
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
