//
//  DetailsViewController.swift
//  Examen3AndyMarinos
//
//  Created by Andy on 27/06/21.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class DetailsViewController: UIViewController {
    
    private var person: PersonModel
    
    init(person: PersonModel ) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nomperson: UILabel!
    @IBOutlet weak var emailPerson: UILabel!
    @IBOutlet weak var movilPerson: UILabel!
    @IBOutlet weak var genPerson: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
    }
    
    func getData(){
        
        nomperson.text?.append(person.name)
        emailPerson.text?.append(person.email)
        movilPerson.text?.append(person.mobile)
        
        AF.request(person.imagen).responseImage { (response) in
            
            self.image.image = try! response.result.get()
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
}
