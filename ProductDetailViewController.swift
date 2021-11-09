
//
//  ProductDetailViewController.swift
//  Assignment 03
//
//  Created by Madhawa Jayagoda on 2021-05-20.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var seperatorBar: UITextField!
    
    @IBOutlet weak var addToCartBtn: UIButton!
    
    @IBOutlet weak var prod_imageViw: UIImageView!
    
    @IBOutlet weak var prod_code_label: UILabel!
    @IBOutlet weak var prod_name_label: UILabel!
    @IBOutlet weak var prod_price_label: UILabel!
    @IBOutlet weak var prod_description_textView: UITextView!
    @IBOutlet weak var unitsAvailable_label: UILabel!
    @IBOutlet weak var quantity_label: UILabel!
    
    
    var _productCode: String?
    var _productName: String?
    var _productPrice: String?
    var _productDescription: String?
    var _unitsAvailable: String?
    var _productImgResource: String?
    
    
    var productCode: Int32? {
        didSet {
            _productCode = String(productCode!)
        }
    }
    
    var productName: String? {
        didSet {
            _productName = String(productName!)
        }
    }


    var productPrice: Double? {
        didSet {
            _productPrice = "Rs. \(productPrice ?? 0.00)"
        }
    }


    var productDescription: String? {
        didSet {
            _productDescription = String(productDescription!)
        }
    }


    var unitsAvailable: Int32? {
        didSet {
            _unitsAvailable = String(unitsAvailable!)
        }
    }


    var productImgResource: String? {
        didSet {
            _productImgResource = String(productImgResource!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        seperatorBar.layer.masksToBounds = true
        seperatorBar.layer.borderColor = UIColor(red: 0.84, green: 0.85, blue: 0.86, alpha: 1.00).cgColor
        seperatorBar.layer.borderWidth = 5
        seperatorBar.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        addToCartBtn.layer.cornerRadius = 5
        
        prod_code_label.text = _productCode
        prod_name_label.text = _productName
        prod_price_label.text = _productPrice
        prod_description_textView.text = _productDescription
        unitsAvailable_label.text = _unitsAvailable
        prod_imageViw.image = UIImage(named: _productImgResource!)
        
        
    }

}

// MARK: Button Actions
extension ProductDetailViewController {
    @IBAction func backBtnClcicked(_ sender: UIButton) {
        let navHomeViewController = self.storyboard?.instantiateViewController(identifier: "NavHomeViewController") as! NavHomeViewController
        self.navigationController?.pushViewController(navHomeViewController, animated: true)
    }
}