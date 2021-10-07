//
//  ExampleMyWalletDataRepository.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//

import Foundation

class ExampleMyWalletDataRepository: MyWalletDataRepository {
    func requestWalletData() -> MyWalletInfo {
        MyWalletInfo(coin: (0...100).randomElement() ?? 0)
    }
}
