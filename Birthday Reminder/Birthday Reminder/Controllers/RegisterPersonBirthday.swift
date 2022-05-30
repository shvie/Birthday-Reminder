//
//  RegisterPersonBirthday.swift
//  new app
//
//  Created by Vitaliy Shmelev on 22.05.2022.
//

import UIKit
import PhotosUI

class RegisterPersonBirthday: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, PHPickerViewControllerDelegate {
    //MARK: - Элементы
    var pickerGender: UIPickerView = UIPickerView()
    //данные для pickerView
    let storageGender = ["Муж", "Жен"]
    //передача данных с помощью делегата
    var delegate: DataUpdateProtocol?
    //MARK: - Элементы на сцене
    @IBOutlet weak var addPhoto: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var dateBirthdayTF: UITextField!
    @IBOutlet weak var instaTF: UITextField!

    //MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.delegate = self
        surnameTF.delegate = self
        genderTF.delegate = self
        dateBirthdayTF.delegate = self
        instaTF.delegate = self
        pickerGender.dataSource = self
        pickerGender.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addToolBarForView()
        settingsForTextField()
        addPhoto.makeRounded()
        addPhoto.tintColor = .gray
        
    }

    
    //MARK: - Методы
    
    //MARK: settings viewPhoto
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        if let assetId = results.first?.assetIdentifier,
           let asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil).firstObject
        {
            //print("asset is \(asset)")
            //print("asset location is \(asset.location)")
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 250, height: 250), contentMode: .aspectFill, options: nil, resultHandler: { (image, info) in
                //print("requested image is \(image)")
                self.addPhoto.image = image
            })
        }
    }
    //MARK: Settings pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return storageGender.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return storageGender[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderTF.text = storageGender[row]
    }
    
    //MARK: UISettings For TextFields
    func settingsForTextField() {
        self.genderTF.inputView = pickerGender
        genderTF.imageLeftViewForTxtField(image: "person", color: .gray)
        dateBirthdayTF.imageLeftViewForTxtField(image: "calendar.badge.plus", color: .gray)
        instaTF.imageLeftViewForTxtField(image: "camera.aperture", color: .gray)
        genderTF.addToolBar(newItem: "Done", style: .done, target: self, actions: #selector(doneButtonAction))
        nameTF.addToolBar(newItem: "Done", style: .done, target: self, actions: #selector(doneButtonAction))
        surnameTF.addToolBar(newItem: "Done", style: .done, target: self, actions: #selector(doneButtonAction))
        instaTF.addToolBar(newItem: "Done", style: .done, target: self, actions: #selector(doneButtonAction))
        dateBirthdayTF.addDatePickerToolbar(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
    }
    //Действия для кнопок внутри toolBars
    @objc func doneButtonAction() {
        self.nameTF.resignFirstResponder()
        self.surnameTF.resignFirstResponder()
        self.genderTF.resignFirstResponder()
        self.dateBirthdayTF.resignFirstResponder()
        self.instaTF.resignFirstResponder()
    }


    //MARK: Загрузка фото
    @IBAction func loadPhoto(_ sender: Any) {
        //сслыка на viewController с галеей пользователя
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        //задаем какое кол-во обьектов может выбрать пользователь
        configuration.selectionLimit = 1
        //какого типа обьекты может выбрать пользователь
        configuration.filter = .images
        //инициализация со всеми конфигурациями
        let vc1 = PHPickerViewController(configuration: configuration)
        vc1.delegate = self
        self.present(vc1, animated: true)
        
    }
    
    //MARK: ToolBar for ViewController
    func addToolBarForView() {
        //Создаем toolBar
        let doneToolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        doneToolBar.barStyle = UIBarStyle.default
        //Создаем item для toolbar
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancel: UIBarButtonItem = UIBarButtonItem(title: "Отмена", style: .done, target: self, action: #selector(cancelButtonAction))
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonActionForView))
        //Добавляем items в массив
        var items = [UIBarButtonItem]()
        items.append(cancel)
        items.append(flexSpace)
        items.append(done)
        //Добавляем items в toolbar
        doneToolBar.items = items
        doneToolBar.sizeToFit()
        self.view.addSubview(doneToolBar)
    }
    //Действия для кнопки "Готово" в toolbar для ViewController
    @objc func doneButtonActionForView() {
        guard nameTF.text != "",
              surnameTF.text != "",
              genderTF.text != "",
              dateBirthdayTF.text != "",
              instaTF.text != "" else {
            callAlert(title: "Ошибка", message: "Введенные данные неверные", style: .alert, viewController: self)
            return
        }
              
        let name = nameTF.text!.capitalized
        let surname = surnameTF.text!.capitalized
        let genders = genderTF.text!
        let dateBirthday = dateBirthdayTF.text!
        let instag = instaTF.text!
        let photo = addPhoto.image!
        
        let newItem = Person(image: photo,
                             name: name,
                             surname: surname,
                             gender: genders,
                             dateBirthday: dateBirthday,
                             insta: instag)
        delegate?.onDataUpdate(data: [newItem])
        
        self.dismiss(animated: true)
    }
    
    // действие для кнопки "Отмена" в toolbar для viewController
    @objc func cancelButtonAction() {
        //закрываем viewController
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    

}

