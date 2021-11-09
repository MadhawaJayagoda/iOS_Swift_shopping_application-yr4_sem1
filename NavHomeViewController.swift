
//
//  NavHomeViewController.swift
//  Assignment 03
//
//  Created by Madhawa Jayagoda on 2021-05-18.
//

import UIKit

class NavHomeViewController: UIViewController {

    @IBOutlet weak var seperatorBar: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productsArray = [Products]()
    
    // Reference to the ManageObjectContext
    let context = ( UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: UIViewController Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        // createDBProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        seperatorBar.layer.masksToBounds = true
        seperatorBar.layer.borderColor = UIColor(red: 0.84, green: 0.85, blue: 0.86, alpha: 1.00).cgColor
        seperatorBar.layer.borderWidth = 5
        seperatorBar.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    }
}


// MARK: Configure
extension NavHomeViewController {
    private func configure() {
        
        // Create the Products required
        /*
        let face_scrub = CProduct(prodCode: "407752", prodImgIcon: "face_scrub", prodImgOrg: "face_scrub_org", prodName: "Fresh Skin Apricot Face Scrub 170g", prodPrice: 4300.00, prodDesc: "The icon. The cult classic. The beauty editor favorite. Our deep cleaning apricot scrub with 100% natural walnut shell powder works to give you soft, smooth, positively glowing skin" , utsAvailable: 243)
        
        let matt_lipstick = CProduct(prodCode: "407523", prodImgIcon: "matte_lipstick", prodImgOrg: "matte_lipstick_org",prodName: "Seren: Matte Lipstick", prodPrice: 1450.99, prodDesc: "An innovation in lipstick formulation that gives long wear, high matte/shine and intense moisture. Pure color. Rich hydrating formula, with shea butter and Vitamin E, feels light and comfortable all day long.", utsAvailable: 127)
        
        
        let fragnance_body_perfume = CProduct(prodCode: "407123", prodImgIcon: "fragnance_perfume", prodImgOrg: "fragnance_perfume_org", prodName: "Victoria Secret: Mint perfume", prodPrice: 5499.99, prodDesc: "Victoria's Secret Desert Lily brings together two timeless fragrance notes in a lightweight yet substantial fragrance mist spray. Included in the brand’s Wild Blooms Fragrance Mist collection, this scent features lily with its creamy, sweet, waxy and slightly clove-like floral note. To round out the fragrance and balance the lily note, iris imparts its distinctive powdery and starchy aroma. The Victoria’s Secret Wild Blooms Desert Lily body spray is a perfect complement to the fragrance from the same collection. It leaves the skin wonderfully scented, giving you a new burst of energy and self-confidence at any time during the day.", utsAvailable: 450)
        
        let smoothing_shampoo = CProduct(prodCode: "406521", prodImgIcon: "smoothing_shampoo", prodImgOrg: "smoothing_shampoo_org", prodName: "L'Oreal Smoothing Shampoo", prodPrice: 3450.00, prodDesc: "L’Oréal Paris Smooth Intense Smoothing Shampoo is a smoothing anti-frizz shampoo that instantly helps soften and tame rough textures, leaving hair soft and smooth. When used with the L’Oréal Paris Smooth Intense Smoothing Conditioner and Frizz Taming Serum. It controls frizz for up to 72 hours. Clinically Tested*. Ideal for frizzy hair types.", utsAvailable: 124)
        
         
         productsArray.append(face_scrub)
         productsArray.append(matt_lipstick)
         productsArray.append(fragnance_body_perfume)
         productsArray.append(smoothing_shampoo)
         
         */
        

        // Retrieve the Data from the Database
        
        do {
            let arrayOfProducts: [Products] = try context.fetch(Products.fetchRequest()) as? [Products] ?? [Products()]
            
            for product in arrayOfProducts {
                productsArray.append(product)
            }
        } catch {
            print("NavHomeVC: Could not fetch from the Database")
        }
        
        collectionView.reloadData()
    }
    
    /*
     
     // Create the Products table in the Database and insert data
     
    private func createDBProducts() {
        let product_1 = Products(context: context)
        
        product_1.productCode = "407752"
        product_1.productImgIcon = "face_scrub"
        product_1.productImgOriginal = "face_scrub_org"
        product_1.productName = "Fresh Skin Apricot Face Scrub 170g"
        product_1.productPrice = 4300.00
        product_1.productDescription = "The icon. The cult classic. The beauty editor favorite. Our deep cleaning apricot scrub with 100% natural walnut shell powder works to give you soft, smooth, positively glowing skin"
        product_1.unitsAvailable = 243
        
    
        let product_2 = Products(context: context)
        
        product_2.productCode = "407523"
        product_2.productImgIcon = "matte_lipstick"
        product_2.productImgOriginal = "matte_lipstick_org"
        product_2.productName = "Seren: Matte Lipstick"
        product_2.productPrice = 1450.99
        product_2.productDescription = "An innovation in lipstick formulation that gives long wear, high matte/shine and intense moisture. Pure color. Rich hydrating formula, with shea butter and Vitamin E, feels light and comfortable all day long"
        product_2.unitsAvailable = 127
        
        
        let product_3 = Products(context: context)
        
        product_3.productCode = "407123"
        product_3.productImgIcon = "fragnance_perfume"
        product_3.productImgOriginal = "matte_lipstick_org"
        product_3.productName = "Victoria Secret: Mint perfume"
        product_3.productPrice = 5499.99
        product_3.productDescription = "Victoria's Secret Desert Lily brings together two timeless fragrance notes in a lightweight yet substantial fragrance mist spray. Included in the brand’s Wild Blooms Fragrance Mist collection, this scent features lily with its creamy, sweet, waxy and slightly clove-like floral note. To round out the fragrance and balance the lily note, iris imparts its distinctive powdery and starchy aroma. The Victoria’s Secret Wild Blooms Desert Lily body spray is a perfect complement to the fragrance from the same collection. It leaves the skin wonderfully scented, giving you a new burst of energy and self-confidence at any time during the day"
        product_3.unitsAvailable = 450
        
        
        let product_4 = Products(context: context)
        
        product_4.productCode = "406521"
        product_4.productImgIcon = "smoothing_shampoo"
        product_4.productImgOriginal = "smoothing_shampoo_org"
        product_4.productName = "L'Oreal Smoothing Shampoo"
        product_4.productPrice = 3450.00
        product_4.productDescription = "L’Oréal Paris Smooth Intense Smoothing Shampoo is a smoothing anti-frizz shampoo that instantly helps soften and tame rough textures, leaving hair soft and smooth. When used with the L’Oréal Paris Smooth Intense Smoothing Conditioner and Frizz Taming Serum. It controls frizz for up to 72 hours. Clinically Tested*. Ideal for frizzy hair types."
        product_4.unitsAvailable = 124
        
        do {
            try context.save()
        } catch {
            print("NavHomeVC: Error occured while saving data in the database")
        }
    }
     
    */
    
}





// MARK: UICollectionView Delegate and DataSource methods
extension NavHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellIdentifier(), for: indexPath) as! ProductCollectionViewCell
        cell.productName.text = productsArray[indexPath.row].productName
        cell.productPrice.text = "Rs. \(productsArray[indexPath.row].productPrice)"
        cell.addToCartBtn.layer.cornerRadius = 5
        cell.productImgSrc.image = UIImage(named: productsArray[indexPath.row].productImgIcon!)
        cell.prodName = productsArray[indexPath.row].productName
        cell.productCallback = {(product) in
            self.navigateToDetailViewController(productName: product)
        }
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 266)
    }
}



// Custom Methods
extension NavHomeViewController {
    func navigateToDetailViewController(productName: String) {
        for product in productsArray {
            if(product.productName == productName) {
                let selectedProduct = product
                
                let detailViewController = self.storyboard?.instantiateViewController(identifier: "ProductDetailViewController") as! ProductDetailViewController
                
                detailViewController.productCode = Int32(selectedProduct.productCode!)
                detailViewController.productName = String(selectedProduct.productName!)
                detailViewController.productPrice = Double(selectedProduct.productPrice)
                detailViewController.productDescription = String(selectedProduct.productDescription!)
                detailViewController.unitsAvailable = Int32(selectedProduct.unitsAvailable)
                detailViewController.productImgResource = String(selectedProduct.productImgOriginal!)
                
                navigationController?.pushViewController(detailViewController, animated: true)
                
            }
        }
    }
}

