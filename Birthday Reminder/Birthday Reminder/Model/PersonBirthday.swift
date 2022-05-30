//
//  personBirthday.swift
//  new app
//
//  Created by Vitaliy Shmelev on 22.05.2022.
//

import Foundation
import UIKit

protocol AtributesPersonProtocol {
    var image: UIImage { get set }
    var name: String { get set }
    var surname: String { get set }
    var gender: String { get set }
    var dateBirthday: String { get set }
    var insta: String { get set }
    var dateBeforeBirthday : Int { get }
    var age: Int { get }
    
}

struct Person: AtributesPersonProtocol {
    
    var image: UIImage
    var name: String
    var surname: String
    var gender: String
    var dateBirthday: String
    var insta: String
    var dateBeforeBirthday: Int {
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM. yyyy г."
        
        guard let birthday = dateFormatter.date(from: self.dateBirthday) else { return 0}
        
        let calendar = Calendar.current
        let nextBirthday = calendar.nextDate(after: currentDate, matching: calendar.dateComponents([.month, .day], from: birthday), matchingPolicy: .nextTime)!
        let daysToBirthday = calendar.dateComponents([.day], from: currentDate, to: nextBirthday)
        return (daysToBirthday.day ?? 0) + 1
        
    }
    var age: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM. yyyy г."
        guard let dateBirthday = dateFormatter.date(from: dateBirthday) else { return 0 }
        
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.year], from: dateBirthday, to: Date())
        return dateComponent.year ?? 0
    }
}
