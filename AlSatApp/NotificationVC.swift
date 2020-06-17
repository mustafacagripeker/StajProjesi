//
//  NotificationVC.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 16.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase

class NotificationVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    

    @IBOutlet weak var logOut: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var customerAdress = String()
    var customerMail = String()
    var price = String()
    var productName = String()
    var customerAdressArray = [String]()
    var customerMailArray = [String]()
    var priceArray = [String]()
    var productNameArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logOut.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logOutFunc))
        logOut.addGestureRecognizer(gestureRecognizer)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    @objc func logOutFunc(){
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginScreen", sender: nil)
        }catch{
            
        }
        
    }
    
    func getData(){
        customerAdressArray.removeAll(keepingCapacity: false)
        customerMailArray.removeAll(keepingCapacity: false)
        priceArray.removeAll(keepingCapacity: false)
        productNameArray.removeAll(keepingCapacity: false)
        
        
        let db = Firestore.firestore()
        
        db.collection("Notification").whereField("sellerMail", isEqualTo: Auth.auth().currentUser?.email).getDocuments { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                for document in snapshot!.documents {
                    self.customerAdress = document.get("customerAdress") as! String
                    self.customerAdressArray.append(self.customerAdress)
                    
                    self.customerMail = document.get("customerMail") as! String
                    self.customerMailArray.append(self.customerMail)
                    
                    self.price = document.get("price") as! String + " ₺"
                    self.priceArray.append(self.price)
                    
                    self.productName = document.get("productName") as! String
                    self.productNameArray.append(self.productName)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerMailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath) as! ThirdScreenCell
        cell.customerAdress.text = "Alıcı Adresi :" + customerAdressArray[indexPath.row]
        cell.customerMail.text = "Alıcı Mail : " + customerMailArray[indexPath.row]
        cell.priceLabel.text = "Fiyat : " + priceArray[indexPath.row]
        cell.nameLabel.text = "Ürün Adı : " + productNameArray[indexPath.row]
        cell.bellImage.image = UIImage(named: "alarma")
        
        return cell
        
    }
    

    

}
