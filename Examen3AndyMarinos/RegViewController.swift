//
//  RegViewController.swift
//  Examen3AndyMarinos
//
//  Created by Andy on 27/06/21.
//

import UIKit
import FirebaseAuth

class RegViewController: UIViewController {
    
    @IBOutlet weak var emailReg: UITextField!
    @IBOutlet weak var passReg: UITextField!
    @IBOutlet weak var confirmReg: UITextField!
    @IBOutlet weak var regButton: UIButton!
    @IBOutlet weak var backReg: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func crearCuenta(_ sender: Any) {
        if let email = emailReg.text , let pass = passReg.text , let confirmpass = confirmReg.text {
            if pass != confirmpass {
                let alert = UIAlertController(title: "ERROR", message: "La confirmación no es igual a la contraseña o no lo ingresó", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else {
                Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
                    if error == nil {
                        let alert = UIAlertController(title: "Nuevo Usuario", message: "Se creó su nuevo usuario", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default,handler: { (action: UIAlertAction) in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true) {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }else{
                        let alert = UIAlertController(title: "ERROR", message: "Ocurrió un error al registrar, intentelo mas tarde", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        else{
            let alert = UIAlertController(title: "ERROR", message: "Todos los campos son obligatorios", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func regresaLogin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
