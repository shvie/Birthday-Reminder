//
//  GeneralCardViewController.swift
//  new app
//
//  Created by Vitaliy Shmelev on 25.05.2022.
//

import UIKit

class GeneralCardViewController: UIViewController, DataUpdateProtocol{
    //MARK: - Элементы на сцене
    @IBOutlet weak var viewBirthday: UIView!
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var viewInsta: UIView!
    @IBOutlet weak var dateBirthday: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var instagram: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var age: UILabel!
    
    //Временное хранилище для передачи данных на сцену
    var account: AtributesPersonProtocol!
    //MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profilePhoto.makeRounded()
        profilePhoto.contentMode = .scaleAspectFill
        settingsForView()
    }
    
    //MARK: - Методы
    func viewCard() {
        profilePhoto.image = account.image
        dateBirthday.text = account.dateBirthday
        gender.text = account.gender
        instagram.text = account.insta
        nameLabel.text = "\(account.name) \(account.surname)"
        age.text = "\(account.age) лет"
    }
    func settingsForView () {
        viewBirthday.layer.cornerRadius = 10
        viewGender.layer.cornerRadius = 10
        viewInsta.layer.cornerRadius = 10
    }
    func onDataUpdate(data: [AtributesPersonProtocol]) {
        data.forEach{ elements in
            account = elements 
        }
    }
}

