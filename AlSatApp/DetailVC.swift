//
//  DetailVC.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 16.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase

class DetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var sellerPhone: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var name = String()
    var price = String()
    var phoneNumber = String()
    var mail = String()
    var image = String()
    var genderValue = String()
    var size = String()
    var selectedDocument = ""
    var customerAdress = ""

    override func viewDidLoad() {
        super.viewDidLoad()

       print(selectedDocument)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        getAdress()
    }
    
    func getAdress(){
        let db = Firestore.firestore()
            db.collection("User").whereField("mail", isEqualTo: Auth.auth().currentUser?.email).getDocuments { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                for document in snapshot!.documents {
                    self.customerAdress = document.get("adress") as! String
            }
        }
            }
    }
    
    func getData(){
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("Product").document(selectedDocument)
        
        docRef.getDocument { (document, error) in
            if error != nil{
                print("Error")
            }else{
                self.name = document?.get("name") as! String
                self.price = document?.get("price") as! String
                self.phoneNumber = document?.get("phone") as! String
                self.mail = document?.get("sellermail") as! String
                self.image = document?.get("image") as! String
                self.genderValue = document?.get("gender") as! String
                self.size = document?.get("size") as! String
                
                
                
                self.productName.text = self.name
                self.gender.text = "Cinsiyet : " + self.genderValue
                self.priceLabel.text = "Fiyat : " + self.price + " ₺"
                self.sizeLabel.text = "Beden : " + self.size
                self.mailLabel.text = "Satıcı Mail : " + self.mail
                self.sellerPhone.text = "Tel :" + self.phoneNumber
                self.imageView.sd_setImage(with: URL(string: self.image))
                
                
                
                
                
            }
        }
        
        
       
    }
    
    func createNotification(){
        let db = Firestore.firestore()
        let firestoreRef : DocumentReference?
        
        
       let notification = ["sellerMail" : mail , "productName" : self.name , "customerMail" : Auth.auth().currentUser?.email , "price" : price , "customerAdress" : customerAdress] as [String : Any]
        
        firestoreRef = db.collection("Notification").addDocument(data: notification, completion: { (error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                
            }
        })
        
        
        
    }
    
    @IBAction func buyClicked(_ sender: Any) {
        
        let db = Firestore.firestore()
        let dbRef = db.collection("Product").document(selectedDocument)
        
        dbRef.updateData(["status" : 1 ]) { (error) in
            
        }
        dbRef.updateData(["adress" : customerAdress ]) { (error) in
            
        }
        
        
        createNotification()
        
        self.makeAlert(title: "Başarılı", message: "Satın Alma Başarılı", buttontitle: "Tamam")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {   // Alert gösterdiği için navigationController.poptoRoot çalışmıyordu. 0.5 saniye gecikme koydum ve çalışıyor
            self.performSegue(withIdentifier: "toBack", sender: nil)
        
        }
    
        
        
    }
    
    @objc func makeAlert(title : String , message : String , buttontitle : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionBtn = UIAlertAction(title: buttontitle, style: .default, handler: nil)
        alert.addAction(actionBtn)
        self.present(alert,animated: true,completion: nil)
    }
    
    

}

