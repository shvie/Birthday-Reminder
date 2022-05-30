//
//  BirhtdayTableViewController.swift
//  new app
//
//  Created by Vitaliy Shmelev on 22.05.2022.
//

import UIKit

class ListBirthday: UITableViewController, DataUpdateProtocol  {
    
    //Временное хранилище данных
    var arrayPersonData: [[AtributesPersonProtocol]] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    //Делегат для отправки данных
    var delegate: DataUpdateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.nib(), forCellReuseIdentifier: Cell.indentifire)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushRegister))
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Table view data source
    func onDataUpdate(data: [AtributesPersonProtocol]) {
        arrayPersonData.append(data)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayPersonData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: Cell.indentifire, for: indexPath) as! Cell
        
        var newAccount: AtributesPersonProtocol!
        
        arrayPersonData[indexPath.row].forEach{ elements in
            newAccount = elements
        }
        customCell.configureCell(nameLB: newAccount.name, image: newAccount.image, birthday: newAccount.dateBirthday, days: newAccount.dateBeforeBirthday )
        return customCell
    }
    // Высота ячейки
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    //показываем полную карточку контакта 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scene = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! GeneralCardViewController
        self.delegate = scene
        let selectCell = arrayPersonData[indexPath.row]
        delegate?.onDataUpdate(data: selectCell)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(scene, animated: true)
    }
    //удаление контакта
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
              self.tableView.beginUpdates()
            arrayPersonData.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
              self.tableView.endUpdates()
            }
        tableView.reloadData()
    }

    
    // MARK: - Navigation
     
    @objc func pushRegister() {
        let scene = UIStoryboard(name: "Main", bundle: nil)
        let nextscene = scene.instantiateViewController(withIdentifier: "Registration") as! RegisterPersonBirthday
        nextscene.delegate = self
        self.navigationController?.present(nextscene, animated: true)
    }

}
