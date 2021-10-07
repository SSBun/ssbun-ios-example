//
//  CoinPannel.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//

import UIKit
import RxSwift
import RxCocoa

class CoinPannel: NiblessView {
    // MARK: - Public Properties
    var data: Binder<[CoinPannel.Item]> {
        Binder(self, scheduler: MainScheduler.asyncInstance) { pannel, items in
            pannel.update(state: items)
        }
    }
    
    var select: ControlEvent<Int> {
        ControlEvent(events: selectRelay)
    }
    
    // MARK: - Private Properties
    private var items: [Item] = []
    private weak var lastSelectedCell: CoinCell?
    private let collectionView = SimpleCollectionView(configuration: .init(padding: .init(width: 8, height: 8),
                                                                           columnCount: 3,
                                                                           heightType: .scaled(68.0/106.0)))
    private let selectRelay = PublishRelay<Int>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // MARK: - Update UI
    
    private func update(state: [Item]) {
        items = state
        updateUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        backgroundColor = .blue
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateUI() {
        collectionView.removeAll()
        var itemViews = [CoinCell]()
        for (index, item) in items.enumerated() {
            let cell = CoinCell()
            cell.tag = index
            cell.titleLabel.text = item.title
            cell.subtitleLabel.text = item.subtitle
            cell.addTarget(self, action: #selector(itemDidClick(cell:)), for: .touchUpInside)
            
            itemViews.append(cell)
        }
        
        collectionView.append(arrangedViews: itemViews)
        
        itemViews.first?.isSelected = true
        lastSelectedCell = itemViews.first
    }
    
    @objc private func itemDidClick(cell: CoinCell) {
        lastSelectedCell?.isSelected = false
        cell.isSelected = true
        lastSelectedCell = cell
        selectRelay.accept(cell.tag)
    }
}

extension CoinPannel {
    struct Item {
        let title: String
        let subtitle: String
    }
}
