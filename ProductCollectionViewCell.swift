
//
//  ProductCollectionViewCell.swift
//  Assignment 03
//
//  Created by Madhawa Jayagoda on 2021-05-20.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImgSrc: UIImageView!
    
    var prodName: String? {
        didSet {
            productName.text = prodName
        }
    }
    
    @IBOutlet weak var addToCartBtn: UIButton!
    
    var productCallback: ((String) -> Void)?
    
    class func cellIdentifier() -> String {
        return "ProductCollectionViewCell"
    }
    
    @IBAction func addToCartCellBtnClicked(_ sender:UIButton) {
        if productCallback != nil {
            productCallback!(prodName!)
        }
    }
    
}
