//
//  ViewController.swift
//  new app
//
//  Created by Vitaliy Shmelev on 19.05.2022.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - Элементы на сцене
    @IBOutlet weak var logo: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    //MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.delegate = self
        emailTF.delegate = self
        emailTF.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //рамка для лого
        borderForLabel(label: logo)
        //кнопка для textfield
        buttonForTextField(txtField: passwordTF)
        //иконки для textfield'ов
        self.passwordTF.imageLeftViewForTxtField(image: "lock", color: .gray)
        self.emailTF.imageLeftViewForTxtField(image: "envelope", color: .gray)
        //скрытые символы для пароля
        passwordTF.isSecureTextEntry = true
        //toolbar для textfield'ов
        self.passwordTF.addToolBar(newItem: "Done", style: .done, target: self, actions: #selector(doneButtonAction))
        self.emailTF.addToolBar(newItem: "Done", style: .done, target: self, actions: #selector(doneButtonAction))
        hideKeyboardWhenTappedAround()
    }
    //MARK: - Методы
    //MARK: Действие для кнопки в toolBar в textField
    @objc func doneButtonAction() {
        self.emailTF.resignFirstResponder()
        self.passwordTF.resignFirstResponder()
    }
    //MARK: Рамка для logo
    func borderForLabel(label: UILabel){
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.gray.cgColor
    }
    //MARK: Действие для кнопки войти
    @IBAction func enterButton(_ sender: Any) {
        guard emailTF.text != "",
              passwordTF.text != "" else {
            self.callAlert(title: "Ошибка", message: "Данные не должны быть пустыми", style: .alert, viewController: self)
            return
        }
    }
    
    //MARK: Кнопка для просмотра скрытых символов
    func buttonForTextField(txtField: UITextField) {
        let button = UIButton(type: .custom)
        button.setImage(.init(systemName: "eye"), for: .normal)
        button.setImage(.init(systemName: "eye.fill"), for: .selected)
        button.addTarget(self, action: #selector(toggleButtonPass), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        button.tintColor = .gray
        txtField.rightView = button
        txtField.rightViewMode = .always
    }
    
    //MARK: Действие для кнопки внутри textField
    @objc func toggleButtonPass(_ sender: UIButton) {
        passwordTF.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
}
//MARK: - Расширения
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTF.becomeFirstResponder()
        return true
    }

}
