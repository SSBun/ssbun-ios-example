//
//  MyWalletDependencyContainer.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//

import Foundation

class MyWalletDependencyContainer: MyWalletViewModelFactory {
    func makeMyWalletViewController() -> MyWalletViewController {
        MyWalletViewController(viewModelFactory: self)
    }
    
    func makeMyWalletViewModel() -> MyWalletViewModel {
        MyWalletViewModel(ExampleMyWalletDataRepository())
    }
}
