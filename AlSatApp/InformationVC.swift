//
//  InformationVC.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 15.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase

class InformationVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var genderText: UITextField!
    
    @IBOutlet weak var locationText: UITextField!
    
    var currentUser = ""
    var isReady = 0
    var userDurum = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        currentUser = Auth.auth().currentUser?.email as! String
        
        
        
        let firestoreDB = Firestore.firestore()
               let ref : DocumentReference?
        
        firestoreDB.collection("User").whereField("mail", isEqualTo: currentUser).getDocuments { (snapshot, err) in
            
            if err != nil {
                
                
            }else{
                
                for document in snapshot!.documents {
                    
                    let name = document.get("name")
                    print(name)
                    
                    self.performSegue(withIdentifier: "toMenu", sender: nil)
                }
                
            }
        }

        
        
    }
    

    @IBAction func addInfoClicled(_ sender: Any) {
        
        if nameText.text != "" && phoneText.text != "" && genderText.text != "" && locationText.text != "" {
            
            let firestoreDB = Firestore.firestore()
            let firestoreReference : DocumentReference?
            
            let firestoreUser = ["mail" : currentUser , "name" : nameText.text! , "adress" : locationText.text! , "status" : 0 , "phone" : phoneText.text! , "gender" : genderText.text! , ] as [String : Any]
            
            firestoreReference = firestoreDB.collection("User").addDocument(data: firestoreUser, completion: { (error) in
                
                if error != nil{
                    self.makeAlert(title: "Hata", message: "Internet Bağlantınızı Kontrol Ediniz. Eğer internete bağlıysanız daha sonra tekrar deneyiniz.", buttontitle: "Tamam")
                }else{
                    self.makeAlert(title: "Başarılı", message: "Bilgileriniz Başarıyla Kayıt Edildi.", buttontitle: "Tamam")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {   // Alert gösterdiği için navigationController.poptoRoot çalışmıyordu. 0.5 saniye gecikme koydum ve çalışıyor
                            self.performSegue(withIdentifier: "toMenu", sender: nil)
                        
                    }
                    
                }
            })
            
        }else{
            makeAlert(title: "Hata ! ", message: "Eksik Alan Bırakamazsınız!", buttontitle: "Anladım")
        }
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    @objc func makeAlert(title : String , message : String , buttontitle : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionBtn = UIAlertAction(title: buttontitle, style: .default, handler: nil)
        alert.addAction(actionBtn)
        self.present(alert,animated: true,completion: nil)
    }
    

}
