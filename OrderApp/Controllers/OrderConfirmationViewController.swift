//
//  OrderConfirmationViewController.swift
//  OrderApp
//
//  Created by ifts 25 on 19/03/23.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    let minutesToPrepare: Int
    
    @IBOutlet weak var confirmationLabell: UILabel!
    
    init?(coder: NSCoder, minutesToPrepare: Int) {
        self.minutesToPrepare = minutesToPrepare
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmationLabell.text = "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes."
    }

}
