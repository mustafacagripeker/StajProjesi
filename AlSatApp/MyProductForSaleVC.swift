//
//  MyProductForSaleVC.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 17.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class MyProductForSaleVC: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    var productNameArray = [String]()
    var priceArray = [String]()
    var imageArray = [String]()
    var productName = ""
    var priceLabel = ""
    var imgUrl = ""
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData(){
        productNameArray.removeAll(keepingCapacity: false)
        priceArray.removeAll(keepingCapacity: false)
        imageArray.removeAll(keepingCapacity: false)
        
        
        let db = Firestore.firestore()
        
        let firstRef = db.collection("Product").whereField("status", isEqualTo: 0)
        
        firstRef.whereField("sellermail", isEqualTo: Auth.auth().currentUser?.email).getDocuments { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                for document in snapshot!.documents {
                    let documentID = document.documentID
                    self.productName = document.get("name") as! String
                    self.productNameArray.append(self.productName)
                    
                    self.priceLabel = document.get("price") as! String
                    self.priceArray.append(self.priceLabel)
                    
                    self.imgUrl = document.get("image") as! String
                        self.imageArray.append(self.imgUrl)
                    
                }
            }
            
            self.tableView.reloadData()
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! SecondScreenCell
        cell.priceLabel.text = priceArray[indexPath.row]
        cell.productNameLabel.text = productNameArray[indexPath.row]
        cell.productImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        return cell
    }

    

}
