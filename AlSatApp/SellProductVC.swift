//
//  SellProductVC.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 16.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase

class SellProductVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var sizeText: UITextField!
    @IBOutlet weak var forWhoText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    let size = ["XS","S","M","L","XL"]
    let forWho = ["Erkek","Kadın","Çocuk"]
    var phoneArray = [String]()
    
    
    var pickerView1 =  UIPickerView()
    var pickerView2 = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        sizeText.inputView = pickerView1
        forWhoText.inputView = pickerView2
        
        imageView.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageGesture)
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    @objc func selectImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1{
            return size.count
        }else{
            return forWho.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1{
            return size[row]
        }else{
            return forWho[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1{
            sizeText.text = size[row]
            sizeText.resignFirstResponder()
        }else{
            forWhoText.text = forWho[row]
            forWhoText.resignFirstResponder()
        }
    }
    
    func getData(){
        let db = Firestore.firestore()
        db.collection("User").whereField("mail", isEqualTo: Auth.auth().currentUser?.email).getDocuments { (snapshot, error) in
        if error != nil {
            print(error?.localizedDescription)
        }else{
            for document in snapshot!.documents {
                let phone = document.get("phone")
                self.phoneArray.append(phone as! String)
        }
    }
        }
    }
    
    
    
    @IBAction func sellClicked(_ sender: Any) {
        
        // Resmi Depolamak
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uid).jpeg")
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    print("Error")
                }else{
                    imageRef.downloadURL { (url, error) in
                        if error != nil{
                            print("Error Line 103")
                        }else{
                            let imageUrl = url?.absoluteString
                            if self.sizeText.text != "" && self.forWhoText.text != "" && self.nameText.text != "" && self.priceText.text != "" {
                                
                                let firestoreDB = Firestore.firestore()
                                let firestoreReference : DocumentReference?
                                
                                let firestoreUser = ["image" : imageUrl, "sellermail" : Auth.auth().currentUser?.email , "name" : self.nameText.text! , "adress" : "alacak kişinin adresi" , "status" : 0 , "phone" : self.phoneArray[0], "size" : self.sizeText.text!,"gender" : self.forWhoText.text!, "price" : self.priceText.text ] as [String : Any]
                                
                                firestoreReference = firestoreDB.collection("Product").addDocument(data: firestoreUser, completion: { (error) in
                                    
                                    if error != nil{
                                        self.makeAlert(title: "Hata", message: "Internet Bağlantınızı Kontrol Ediniz. Eğer internete bağlıysanız daha sonra tekrar deneyiniz.", buttontitle: "Tamam")
                                    }else{
                                        self.makeAlert(title: "Başarılı", message: "Ürün Satışa Çıktı", buttontitle: "Tamam")
                                        self.imageView.image = UIImage(named: "addimage")
                                        self.sizeText.text = ""
                                        self.priceText.text = ""
                                        self.forWhoText.text = ""
                                        self.nameText.text = ""
                                        
                                    }
                                })
                                
                            }else{
                                self.makeAlert(title: "Hata ! ", message: "Eksik Alan Bırakamazsınız!", buttontitle: "Anladım")
                            }
                        }
                    }
                }
            }
            
        }
        
        
        
        
    }
    
    @objc func makeAlert(title : String , message : String , buttontitle : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionBtn = UIAlertAction(title: buttontitle, style: .default, handler: nil)
        alert.addAction(actionBtn)
        self.present(alert,animated: true,completion: nil)
    }
    
   

}
