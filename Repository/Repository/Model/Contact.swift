//
//  contact.swift
//  iOSLiveCodingExam1
//
//  Created by @camapblue on 12/27/21.
//

import Foundation

public class Contact: Codable, Equatable {
    public private(set) var id: String
    
    public private(set) var firstName: String
    public private(set) var lastName: String
    
    public private(set) var street: String
    public private(set) var city: String
    public private(set) var state: String
    public private(set) var country: String
    
    public private(set) var birthday: Date?
    
    public private(set) var avatar: String
    public private(set) var nationality: String
    
    public static func fakeContact(id: String = "fake_id", birthday date: Date? = nil) -> Contact {
        let dic = [
            "name": [
                "first": "David",
                "last": "Beckham"
            ],
            "location": [
                "street": [
                    "number": 4616,
                    "name": "Rue du Bât-D'Argent",
                ],
                "city" : "Kaiseraugst",
                "state": "Zug",
                "country": "Switzerland"
            ],
            "phone": "079 923 76 11",
            "dob": [
                "date": "1984-11-12T01:33:26.996Z"
            ],
            "picture": [
                "medium": "https://randomuser.me/api/portraits/med/women/33.jpg"
            ],
            "nat": "CH"
        ] as [String: Any]
        
        let contact = Contact(dictionary: dic)
        if let birth = date {
            contact.birthday = birth
        }
        return contact
    }
    
    init(dictionary dic: Dictionary<String, Any>) {
        self.id = dic["phone"] as! String
        
        let nameDic = dic["name"] as! Dictionary<String, Any>
        self.firstName = nameDic["first"] as! String
        self.lastName = nameDic["last"] as! String
        
        let locationDic = dic["location"] as! Dictionary<String, Any>
        let streetDic = locationDic["street"] as! Dictionary<String, Any>
        self.street = "\(streetDic["number"] as! Int) \(streetDic["name"] as! String)"
        self.city = locationDic["city"] as! String
        self.state = locationDic["state"] as! String
        self.country = locationDic["country"] as! String
        
        let dobDic = dic["dob"] as! Dictionary<String, Any>
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.birthday = dateFormatter.date(from: dobDic["date"] as! String)
        
        let pictureDic = dic["picture"] as! Dictionary<String, Any>
        self.avatar = pictureDic["medium"] as! String
        
        self.nationality = dic["nat"] as! String
    }
    
    public static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id
    }
}
