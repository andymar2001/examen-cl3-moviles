//
//  HomeViewController.swift
//  Examen3AndyMarinos
//
//  Created by Andy on 27/06/21.
//

import UIKit
import FirebaseAuth
import Alamofire
import SwiftyJSON

var myIndex = 0

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var personData : [PersonModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.register(UINib(nibName: "PersonsTableViewCell", bundle: nil), forCellReuseIdentifier: "personCell")
        fetchUserData()
    }
    
    
    func fetchUserData(){
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        DispatchQueue.main.async {
            AF.request("https://private-aca2f1-andyalexismarinosrodriguez.apiary-mock.com/contacts").response { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value!)
                    let data = json["data"]
                    data["contacts"].array?.forEach({ (user) in
                        let user = PersonModel(
                            name: user["name"].stringValue,
                            email: user["email"].stringValue,
                            mobile: user["mobile"].stringValue,
                            genero: user["genero"].stringValue,
                            imagen: user["imagen"].stringValue)
                        self.personData.append(user)
                    })
                    print(json)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    @IBAction func closeSessionButtonAction(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "email")
            defaults.synchronize()
            navigationController?.popViewController(animated: true)
        } catch  {
            let alertController = UIAlertController(title: "Error", message: "Se ha producido un error al cerrar su sesión, vuelva a intentarlo en unos momentos", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonsTableViewCell
        
        cell.nombreTableCell.text = self.personData[indexPath.row].name
        cell.emailTableCell.text = self.personData[indexPath.row].email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(myIndex)")
        let person : PersonModel = PersonModel(
            name: self.personData[myIndex].name,
            email: self.personData[myIndex].email,
            mobile: self.personData[myIndex].mobile,
            genero: self.personData[myIndex].genero,
            imagen: self.personData[myIndex].imagen)
        navigationController?.pushViewController(DetailsViewController(person: person), animated: true)
        
    }
    
}
