//
//  VendorProfileVC.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 16.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class VendorProfileVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! MyProductCell
        cell.priceLabel.text = String(self.priceArray[indexPath.row])
        cell.myProductImage.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let db = Firestore.firestore()
            db.collection("Product").document("Erkek").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
        
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageArray = [String]()
    var priceArray = [String]()
    var idArray = [String]()
    var mailArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData(){
        let fireStoreDatabase = Firestore.firestore()
                
                
        fireStoreDatabase.collection("Product").whereField("sellerMail", isEqualTo: Auth.auth().currentUser?.email).getDocuments { (snapshot, err) in
                    
                    if err != nil {
                        
                        
                    }else{
                        
                        self.imageArray.removeAll(keepingCapacity: false)
                        self.priceArray.removeAll(keepingCapacity: false)
                        self.idArray.removeAll(keepingCapacity: false)
                        
                        for document in snapshot!.documents {
                            
                            let documentId = document.documentID
                            self.idArray.append(documentId)
                            print("\(documentId) **********************")
                            if let docImage = document.get("imageurl"){
                                self.imageArray.append(docImage as! String)
                            }
                            
                            if let docPrice = document.get("price"){
                                self.priceArray.append(docPrice as! String)
                            }
                            
                            if let sellerMail = document.get("sellerMail"){
                                self.mailArray.append(sellerMail as! String)
                            }
                            
            }
                        
                        self.tableView.reloadData()
                        

                        
                        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                            return self.imageArray.count
                        }
                        
                        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! MyProductCell
                            cell.priceLabel.text = String(self.priceArray[indexPath.row])
                            cell.myProductImage.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
                            cell.idLabel.text = self.idArray[indexPath.row]
                            return cell
                        }
                        
                        print(self.imageArray.count)
                        
                        
                        
            
            
            
            
            
            
            
            
            }
            
            
            
        }
    }
    

    

}
