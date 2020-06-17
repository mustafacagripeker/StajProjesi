//
//  RegisterVC.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 15.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var mailText: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    
    @IBOutlet weak var rePassText: UITextField!
    
    @IBOutlet weak var sozlesmeLabel: UILabel!
    
    @IBOutlet weak var controlSwitch: UISwitch!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        // Üyelik Oluşturuluyor
        
        if mailText.text != "" && passText.text != "" && rePassText.text != "" && passText.text == rePassText.text && controlSwitch.isOn == true {
            Auth.auth().createUser(withEmail: mailText.text!, password: passText.text!) { (authdata, error) in
                if error != nil{
                    self.errorAlert(title: "Hata", message: error?.localizedDescription ?? "Hata Oldu!.")
                }else{
                    self.showAlert(title: "Başarılı", message: "Üyelik Başarıyla Oluşturuldu")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {   // Alert gösterdiği için navigationController.poptoRoot çalışmıyordu. 0.5 saniye gecikme koydum ve çalışıyor
                        self.performSegue(withIdentifier: "toMain", sender: nil)
                        
                    }
                }
            }
        }else{
            errorAlert(title: "Hata!", message: "Lütfen İlgili Alanları Doğru Doldurunuz")
        }
    }
    
    
    
    
    
    func showAlert(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Devam", style: .default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert,animated: true, completion: nil)
    }
    func errorAlert(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: title, style: .cancel, handler: nil)
        alert.addAction(cancelBtn)
        self.present(alert,animated: true, completion: nil)
    }
    


}
