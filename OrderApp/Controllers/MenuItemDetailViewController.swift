//
//  MenuItemDetailViewController.swift
//  OrderApp
//
//  Created by ifts 25 on 16/03/23.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var addBtnOutlet: UIButton!
    
    let menuItem: MenuItem
    
    init?(coder: NSCoder,menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBtnOutlet.layer.cornerRadius = 5.0
        updateUI()
    }
    
    func updateUI() {
        nameLabel.text = menuItem.name
        priceLabel.text = MenuItem.priceFormatter.string(from: NSNumber(value: menuItem.price))
        detailsLabel.text = menuItem.detailText
        MenuController.shared.fetchImage(url: menuItem.imageURL)
               { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
    }
    
    
    
    @IBAction func addBottonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
                self.addBtnOutlet.transform =
                   CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.addBtnOutlet.transform =
                   CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        
        MenuController.shared.order.menuItems.append(menuItem)

    }
    
}
