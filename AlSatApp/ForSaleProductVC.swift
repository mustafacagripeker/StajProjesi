//
//  ForSaleProductVC.swift
//  AlSatApp
//
//  Created by Mustafa Çağrı Peker on 16.06.2020.
//  Copyright © 2020 Mustafa Cagri Peker. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage


class ForSaleProductVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var productNameArray = [String]()
    var priceArray = [String]()
    var imageArray = [String]()
    var idArray = [String]()
    var choosenDocument = ""
    var productName = ""
    var priceLabel = ""
    
    

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
        idArray.removeAll(keepingCapacity: false)
        
        let db = Firestore.firestore()
        
        db.collection("Product").whereField("status", isEqualTo: 0).getDocuments { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                for document in snapshot!.documents {
                    let documentID = document.documentID
                    self.idArray.append(documentID)
                    print("******\(documentID)")
                    print(self.idArray.count)
                    
                    self.productName =  document.get("name") as! String
                    self.productNameArray.append(self.productName)
                    print(self.productName)
                    
                    self.priceLabel = document.get("price") as! String + " ₺"
                    self.priceArray.append(self.priceLabel)
                    print(self.priceLabel)
                    
                    if let imageUrl = document.get("image") as? String{
                        self.imageArray.append(imageUrl)
                        print("image arr : \(self.imageArray.count)")
                        
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FirstScreenCell
        cell.priceLabel.text = priceArray[indexPath.row]
        cell.nameLabel.text = productNameArray[indexPath.row]
        cell.productImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        cell.idLabel.text = idArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        choosenDocument = idArray[indexPath.row]
        
        performSegue(withIdentifier: "toDetail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let destinationVC = segue.destination as! DetailVC
            destinationVC.selectedDocument = choosenDocument
        }
    }

}
