//
//  ViewController.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 15.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var mailText: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginClicked(_ sender: Any) {
        
        if mailText.text != "" && passText.text != ""{
            Auth.auth().signIn(withEmail: mailText.text!, password: passText.text!) { (authdata, error) in
                if error != nil{
                    self.errorAlert(title: "Giriş Başarısız.", message: error?.localizedDescription ?? "Error")
                }else{
                    self.showAlert(title: "Giriş Başarılı", message: "Devam Butonuna Tıklarsanız Girişe Yönlendirileceksiniz")
                }
            }
        }
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
    func errorAlert(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: "Tekrar Dene", style: .cancel, handler: nil)
        alert.addAction(cancelBtn)
        self.present(alert,animated: true, completion: nil)
    }
    func showAlert(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Devam", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "toInformation", sender: nil)
        }
        alert.addAction(okBtn)
        self.present(alert,animated: true, completion: nil)
    }
    
}

