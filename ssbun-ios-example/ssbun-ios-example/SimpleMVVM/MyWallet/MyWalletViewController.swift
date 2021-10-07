//
//  MyWalletViewController.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa

class MyWalletViewController: NiblessViewController {
    private let viewModel: MyWalletViewModel
    private let bag = DisposeBag()
    
    private let coinPannel = CoinPannel()
    
    init(viewModelFactory: MyWalletViewModelFactory) {
        self.viewModel = viewModelFactory.makeMyWalletViewModel()
        super.init()
        view.backgroundColor = .green
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let coinBtn = UIButton(type: .custom)
        view.addSubview(coinBtn)
        coinBtn.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.center.equalToSuperview()
        }
        viewModel.coinNumberObservable
            .asDriver(onErrorJustReturn: 0)
            .map({ "\($0)" })
            .drive(coinBtn.rx.title(for: .normal))
            .disposed(by: bag)
        coinBtn.rx.tap.bind(onNext: viewModel.updateCoinData).disposed(by: bag)
        
        view.addSubview(coinPannel)
        coinPannel.backgroundColor = .red
        coinPannel.snp.makeConstraints {
            $0.leading.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.top.equalTo(coinBtn.snp.bottom).offset(20)
        }
        
        viewModel.coinViewModelsObservable
            .map({ items in items.map({ CoinPannel.Item(title: "\($0.count) 币", subtitle: "￥ \($0.count).00") })})
            .bind(to: coinPannel.data).disposed(by: bag)
        coinPannel.select.bind(to: viewModel.selectedCoinObserver).disposed(by: bag)
        
    }
    
    deinit {
        print("my wallet view controller did deinit")
    }
}
