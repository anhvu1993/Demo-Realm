//
//  ViewController.swift
//  Demo-Realm
//
//  Created by Anh vũ on 6/30/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
import RealmSwift

class People: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}

class ViewController: UIViewController {
     let person = People()
    
    @IBOutlet weak var nameString: UITextField!
    @IBOutlet weak var ageString: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       showData()
    }
    func showData (){
        guard let realm = try? Realm() else {return}
        let persons = realm.objects(People.self)
        persons.forEach { (data) in
            name.text = data.name
            age.text = String(data.age)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        if let names = nameString.text, let ages = Int(ageString.text!)  {
            person.name = names
            person.age = ages
        }
        guard let realm = try? Realm() else {return}
            try! realm.write {
                realm.add(person)
            }
        showData()
        
    }
    
    @IBAction func xoa(_ sender: Any) {
        if let realm = try? Realm() {
            try! realm.write {
                realm.deleteAll()
                name.text = ""
                age.text = ""
            }
            
        }
    }
    
    
}

