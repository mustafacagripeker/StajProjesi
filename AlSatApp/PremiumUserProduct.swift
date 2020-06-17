//
//  PremiumUserProduct.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 15.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class PremiumUserProduct: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PremiumProductCell
        cell.priceLabel.text = String(self.priceArray[indexPath.row])
        cell.productImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let fireStoreDatabase = Firestore.firestore()
        
        print(fireStoreDatabase.collection("Product").whereField("imageurl", isEqualTo: imageArray[indexPath.row]))
        print("********")
        
    }
    
    
    

    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    
    var imageArray = [String]()
    var priceArray = [String]()
    var idArray = [String]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromFirestore()
    }
    
    func getDataFromFirestore(){
        
        
        
        let fireStoreDatabase = Firestore.firestore()
        
        
        fireStoreDatabase.collection("Product").whereField("productstatus", isEqualTo: 1).getDocuments { (snapshot, err) in
            
            if err != nil {
                
                
            }else{
                
                self.imageArray.removeAll(keepingCapacity: false)
                self.priceArray.removeAll(keepingCapacity: false)
                self.idArray.removeAll(keepingCapacity: false)
                
                for document in snapshot!.documents {
                    let documentID = document.documentID
                    self.idArray.append(documentID)
                    if let docImage = document.get("imageurl"){
                        self.imageArray.append(docImage as! String)
                    }
                    
                    if let docPrice = document.get("price"){
                        self.priceArray.append(docPrice as! String)
                    }
    }
                
                self.tableView.reloadData()
                

                
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return self.imageArray.count
                }
                
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PremiumProductCell
                    cell.priceLabel.text = String(self.priceArray[indexPath.row])
                    cell.productImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
                    return cell
                }
                
                
                print(self.imageArray.count)
                
                
    
    
    
    
    
    
    
    
    
    }
    
}
}
}


