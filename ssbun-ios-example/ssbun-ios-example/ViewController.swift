//
//  ViewController.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(jumpToMyWalletPage))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func jumpToMyWalletPage() {
        present(MyWalletDependencyContainer().makeMyWalletViewController(), animated: true, completion: nil)
    }
}

