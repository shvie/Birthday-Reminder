//
//  Extensions.swift
//  new app
//
//  Created by Vitaliy Shmelev on 22.05.2022.
//

import Foundation
import UIKit
extension UIViewController {
    
    func callAlert (title: String, message: String, style: UIAlertController.Style, viewController: UIViewController) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: style)
            let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true)
        }
}
extension UIImageView {

    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UITextField {
    func imageLeftViewForTxtField(image: String, color: UIColor) {
        let nameImage = image
        let colorForImage = color
        
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 20, height: 24))
        let image = UIImage(systemName: nameImage)
        imageView.image = image
        imageView.tintColor = colorForImage
        imageView.contentMode = .scaleAspectFit
        

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        self.leftViewMode = .always
        self.leftView = view
    }

    func addToolBar(newItem title: String, style: UIBarButtonItem.Style, target: Any?, actions: Selector?) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let newItem = UIBarButtonItem(title: title, style: style, target: target, action: actions)
        toolBar.setItems([flexible,newItem], animated: true)
        self.inputAccessoryView = toolBar
    }
    
    func addDatePickerToolbar(title: String, style: UIBarButtonItem.Style, target: Any?, action: Selector?) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let picker = UIDatePicker()
        var oneYear = TimeInterval()
        oneYear = 365 * 24 * 60 * 60
        let date = Date(timeIntervalSince1970: oneYear)
        //настройки для toolbar
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        //настройки для picker
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.contentMode = .scaleToFill
        picker.maximumDate = .now
        picker.minimumDate = date
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let newItem = UIBarButtonItem(title: title, style: style, target: target, action: action)
        toolBar.setItems([flexible, newItem], animated: true)
        //добавляем все в textField.view
        self.inputAccessoryView = toolBar
        self.inputView = picker
        picker.addTarget(self, action: #selector(action(_:)), for: .valueChanged)
    }
    @objc func action(_ sender: UIDatePicker) {
        self.text = "\(sender.date.formatted(.dateTime.day().month().year()))"
        
    }    
}
