//
//  ViewController.swift
//  12. HIG & შესავალი iOS-ში
//
//  Created by gvantsa gvagvalia on 4/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usjLabel: UILabel!
    @IBOutlet weak var switchVar: UISwitch!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchVar.setOn(false, animated: true)
        firstTextField.delegate = self
        secondTextField.delegate = self
        calculateButton.tintColor = .systemCyan
        switchVar.thumbTintColor = calculateButton.tintColor
    }
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        if !sender.isOn {
            calculateButton.tintColor = .systemCyan
            sender.thumbTintColor = calculateButton.tintColor
            usjLabel.text = "უმცირესი საერთო ჯერადი"
            calculateButton.titleLabel?.text = "გამოთვალე - უმცირესი საერთო ჯერადი"
        } else {
            calculateButton.tintColor = .systemMint
            sender.onTintColor = calculateButton.tintColor
            sender.thumbTintColor = .systemBackground
            usjLabel.text = "უდიდესი საერთო გამყოფი"
            calculateButton.titleLabel?.text = "გამოთვალე - უდიდესი საერთო გამყოფი"
        }
        if sender.isEnabled {
            answerLabel.text = "პასუხი:"
            firstTextField.backgroundColor = .systemBackground
            secondTextField.backgroundColor = .systemBackground
            
        }
    }
    
    @IBAction func makeTextRed(_ sender: UITextField) {
        sender.backgroundColor = .systemBackground
        
        guard let text = sender.text, !text.isEmpty else {
            sender.backgroundColor = .systemBackground
            return
        }
        guard let text = Int(sender.text ?? "") else {
            sender.backgroundColor = .systemPink
            sender.text = ""
            sender.resignFirstResponder()
            return
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let firstNumber = Int(firstTextField.text ?? ""), let secondNumber = Int(secondTextField.text ?? "") else {
            answerLabel.text = "გთხოვთ სწორად შეავსოთ ორივე ველი"
            answerLabel.textColor = .red
            return
        }
        
        firstTextField.text = ""
        secondTextField.text = ""
        answerLabel.text = ""
        
        if switchVar.isOn {
            let result = gcd(number1: firstNumber, number2: secondNumber)
            answerLabel.text! += "\(firstNumber)-ს და \(secondNumber)-ს \(usjLabel.text ?? "-")ა: \(result)"
            answerLabel.textColor = .black
        } else {
            let result = lcm(number1: firstNumber, number2: secondNumber)
            answerLabel.text! += "\(firstNumber)-ს და \(secondNumber)-ს \(usjLabel.text ?? "-")ა: \(result)"
            answerLabel.textColor = .black
        }
    }
    
    func gcd(number1: Int, number2: Int) -> Int {
        let remainder = abs(number1) % abs(number2)
        if remainder != 0 {
            return gcd(number1: number2, number2: remainder)
        } else {
            return number2
        }
    }
    
    func lcm(number1: Int, number2: Int) -> Int {
        return (number1 / gcd(number1: number1, number2: number2)) * number2
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstTextField {
            secondTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

