//
//  MyWalletDataRepository.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//

import Foundation

/// Used to get wallet data from server or local stroage.
protocol MyWalletDataRepository {
    mutating func requestWalletData() -> MyWalletInfo
}
