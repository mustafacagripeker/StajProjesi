//
//  SellVC.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 15.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase

class SellVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var productName: UITextField!
    
    @IBOutlet weak var size: UITextField!
    
    @IBOutlet weak var clothesType: UITextField!
    
    @IBOutlet weak var forWho: UITextField!
    
    @IBOutlet weak var price: UITextField!
    
    let bedenler = ["XS","S","M","L","XL"]
    
    let turler = ["Ceket","T shirt","Kazak","Etek","Pantalon","Gömlek" ]
    
    let forWhoo = ["Kadın","Erkek","Çocuk"]
    
    let pickerView1 = UIPickerView()
    
    let pickerView2 = UIPickerView()
    
    let pickerView3 = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        size.inputView = pickerView1
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        clothesType.inputView = pickerView2
        
        pickerView3.delegate = self
        pickerView3.dataSource = self
        forWho.inputView = pickerView3
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    @IBAction func sellBtn(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageFolder = storageRef.child("Image")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let mediaRef = imageFolder.child("\(uuid).jpeg")
            mediaRef.putData(data, metadata: nil) { (data, error) in
                
                if error != nil{
                    
                }else{
                    
                    mediaRef.downloadURL { (url, error) in
                        
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            
                            // Kullanıcı Bilgisi Çekilecek
                            
                            let firestoreDB = Firestore.firestore()
                                   let ref : DocumentReference?
                            
                            firestoreDB.collection("User").whereField("mail", isEqualTo: Auth.auth().currentUser?.email).getDocuments { (snapshot, err) in
                                
                                if err != nil {
                                    
                                    
                                }else{
                                    
                                    for document in snapshot!.documents {
                                        
                                        
                                        let status = document.get("status")
                                        
                                        // Database Kayıt
                                        
                                        if self.imageView.image != UIImage(named: "addimage") && self.productName.text != "" && self.size.text != "" && self.clothesType.text != "" && self.forWho.text != "" && self.price.text !=  "" {
                                            
                                            let firestoreDB = Firestore.firestore()
                                            let firestoreReference : DocumentReference?
                                            
                                            let firestoreProduct = ["imageurl" : imageUrl , "name" : self.productName.text , "size" : self.size.text! , "forWho" : self.forWho.text! , "price" : self.price.text , "type" : self.clothesType.text! , "adress" : "alananın adresi" , "sellerMail" : Auth.auth().currentUser?.email! ,"productstatus" : 0 , "satisdurumu" : 0 ] as [String : Any]
                                            
                                            firestoreReference = firestoreDB.collection("Product").addDocument(data: firestoreProduct, completion: { (error) in
                                                
                                                if error != nil{
                                                    self.errorAlert(title: "Hata", message: "Internet Bağlantınızı Kontrol Ediniz. Eğer internete bağlıysanız daha sonra tekrar deneyiniz.")
                                                }else{
                                                    self.gotoMainMenuAlert()
                                                    
                                                    
                                                    
                                                    
                                                }
                                            })
                                            
                                        }else{
                                            self.showAlert(title: "Hata ! ", message: "Eksik Alan Bırakamazsınız!")
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                    }
                }
            }
        }
        
        
        
        
        
        
    }
    
    @IBAction func sellPremium(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageFolder = storageRef.child("Image")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let mediaRef = imageFolder.child("\(uuid).jpeg")
            mediaRef.putData(data, metadata: nil) { (data, error) in
                
                if error != nil{
                    
                }else{
                    
                    mediaRef.downloadURL { (url, error) in
                        
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            
                            // Kullanıcı Bilgisi Çekilecek
                            
                            let firestoreDB = Firestore.firestore()
                                   let ref : DocumentReference?
                            
                            firestoreDB.collection("User").whereField("mail", isEqualTo: Auth.auth().currentUser?.email).getDocuments { (snapshot, err) in
                                
                                if err != nil {
                                    
                                    
                                }else{
                                    
                                    for document in snapshot!.documents {
                                        
                                        
                                        let status = document.get("status")
                                        
                                        // Database Kayıt
                                        
                                        if self.imageView.image != UIImage(named: "addimage") && self.productName.text != "" && self.size.text != "" && self.clothesType.text != "" && self.forWho.text != "" && self.price.text !=  "" {
                                            
                                            let firestoreDB = Firestore.firestore()
                                            let firestoreReference : DocumentReference?
                                            
                                            let firestoreProduct = ["imageurl" : imageUrl , "name" : self.productName.text , "size" : self.size.text! , "forWho" : self.forWho.text! , "price" : self.price.text , "type" : self.clothesType.text! , "adress" : "alananın adresi" , "sellerMail" : Auth.auth().currentUser?.email! ,"productstatus" : 1 , "satisdurumu" : 0 , "id" : document.documentID ] as [String : Any]
                                            
                                            firestoreReference = firestoreDB.collection("Product").addDocument(data: firestoreProduct, completion: { (error) in
                                                
                                                if error != nil{
                                                    self.errorAlert(title: "Hata", message: "Internet Bağlantınızı Kontrol Ediniz. Eğer internete bağlıysanız daha sonra tekrar deneyiniz.")
                                                }else{
                                                    self.gotoMainMenuAlert()
                                                    
                                                    
                                                    
                                                    
                                                }
                                            })
                                            
                                        }else{
                                            self.showAlert(title: "Hata ! ", message: "Eksik Alan Bırakamazsınız!")
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                    }
                }
            }
        }
        
    }
    
    
    @objc func pickImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1{
            return bedenler.count
        }
        else if pickerView == pickerView2{
            return turler.count
        }
        else{
            return forWhoo.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1{
            return bedenler[row]
        }
        else if pickerView == pickerView2{
            return turler[row]
        }
        else{
            return forWhoo[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1{
            size.text = bedenler[row]
            size.resignFirstResponder()
        }else if pickerView == pickerView2{
            clothesType.text = turler[row]
            clothesType.resignFirstResponder()
        }
        else{
            forWho.text = forWhoo[row]
            forWho.resignFirstResponder()
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
        let cancelBtn = UIAlertAction(title: "Devam", style: .cancel, handler: nil)
        alert.addAction(cancelBtn)
        self.present(alert,animated: true, completion: nil)
    }
    
    func gotoMainMenuAlert(){
        imageView.image = UIImage(named: "addimage")
        productName.text = ""
        size.text = ""
        clothesType.text = ""
        forWho.text = ""
        price.text = ""
        let alert = UIAlertController(title: "İşlem Başarılı", message: "Ürün Başarıyla Satışa Çıkarıldı.", preferredStyle: .alert)
        let devamBtn = UIAlertAction(title: "Devam", style: .default) { (UIAlertAction) in
            self.tabBarController?.selectedIndex = 0
        }
        alert.addAction(devamBtn)
        self.present(alert,animated: true,completion: nil)
    }
    
    

}
