



import UIKit
import Firebase
import SDWebImage

class PremiumUserProduct: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    
    
        
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    
    var imageArray = [String]()
    var priceArray = [Int]()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        
        
    }
    
    func getDataFromFirestore(){
        
        let fireStoreDatabase = Firestore.firestore()
        
        
        fireStoreDatabase.collection("Product").whereField("productStatus", isEqualTo: 1).getDocuments { (snapshot, err) in
            
            if err != nil {
                
                
            }else{
                
                self.imageArray.removeAll(keepingCapacity: false)
                self.priceArray.removeAll(keepingCapacity: false)
                
                for document in snapshot!.documents {
                    
                    let documentId = document.documentID
                    
                    if let docImage = document.get("imageurl"){
                        self.imageArray.append(docImage as! String)
                    }
                    
                    if let docPrice = document.get("price"){
                        self.priceArray.append(docPrice as! Int)
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
                
                
                
    
    
    
    
    
    
    
    
    
    }
    
}
}
}
