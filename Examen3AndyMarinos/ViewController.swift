//
//  ViewController.swift
//  Examen3AndyMarinos
//
//  Created by Andy on 27/06/21.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailLog: UITextField!
    @IBOutlet weak var passLog: UITextField!
    @IBOutlet weak var inButton: UIButton!
    @IBOutlet weak var regButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        let defaults = UserDefaults.standard
        if defaults.value(forKey: "email") != nil {
            navigationController?.pushViewController(HomeViewController(), animated: true)
        }
        emailLog.becomeFirstResponder()
        
        
    }
    
    @IBAction func inButtonAction(_ sender: Any) {
        
        if let email = emailLog.text, let password = passLog.text {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error == nil {
                    
                    self.emailLog.text = ""
                    self.passLog.text = ""
                    self.emailLog.becomeFirstResponder()
                    let defaults = UserDefaults.standard
                    defaults.setValue(email, forKey: "email")
                    defaults.synchronize()
                    self.navigationController?.pushViewController(HomeViewController(), animated: true)
                    
                }else {
                    
                    let alertController = UIAlertController(title: "Atención", message: "Verifique los datos ingresados", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                
            }
        }
    }
    
    @IBAction func regButtonAction(_ sender: Any) {
        navigationController?.pushViewController(RegViewController(), animated: true)
    }
}

