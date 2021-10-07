//
//  MyWalletViewModel.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//

import Foundation
import RxSwift
import RxRelay



class MyWalletViewModel {
    // MARK: - Public Observables
    /// Total coin number
    var coinNumberObservable: Observable<Int> { coinNumberRelay.asObservable() }
    var coinViewModelsObservable: Observable<[CoinViewModel]> { coinViewModelsRelay.asObservable() }
    var selectedCoinObserver: AnyObserver<Int> { AnyObserver(selectedCoinSubject) }
    
    // MARK: - Private States
    private let coinNumberRelay = BehaviorRelay(value: 0)
    private let coinViewModelsRelay = BehaviorRelay(value: [CoinViewModel]())
    private let selectedCoinSubject = BehaviorSubject(value: 0)

    private var walletDataRepository: MyWalletDataRepository
    private let bag = DisposeBag()
    
    init(_ walletDataRepository: MyWalletDataRepository) {
        self.walletDataRepository = walletDataRepository
        selectedCoinSubject.bind(to: coinNumberRelay).disposed(by: bag)
    }
}


extension MyWalletViewModel {
    func updateCoinData() {
        
//        coinNumberRelay.accept(walletDataRepository.requestWalletData().coin)
        coinViewModelsRelay.accept([6, 68, 198, 298, 348, 698].map(CoinViewModel.init(count:)))
    }
}

extension MyWalletViewModel {
    struct CoinViewModel {
        let count: Int
    }
}
