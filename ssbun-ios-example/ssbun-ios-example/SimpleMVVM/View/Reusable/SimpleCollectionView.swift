//
//  SimpleCollectionView.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//

import UIKit
import SnapKit

class SimpleCollectionView: NiblessView {
    let configuration: Configuration
    private var currentArrangedViews: [UIView] = []
    
    init(configuration: Configuration, frame: CGRect = .zero) {
        self.configuration = configuration
        super.init(frame: frame)
    }
    
    func append(arrangedViews: [UIView]) {
        currentArrangedViews.append(contentsOf: arrangedViews)
        arrangedViews.forEach(addSubview)
        updateLayout()
    }
    
    func remove(arrangedView: UIView) {
        guard let index = currentArrangedViews.firstIndex(of: arrangedView) else { return }
        currentArrangedViews.remove(at: index)
        arrangedView.removeFromSuperview()
        updateLayout()
    }
    
    func removeAll() {
        currentArrangedViews.forEach { $0.removeFromSuperview() }
        currentArrangedViews.removeAll()
        updateLayout()
    }
    
    private func updateLayout() {
        setNeedsLayout()
        layoutIfNeeded()
        let cellW = (frame.width - configuration.padding.width * CGFloat(configuration.columnCount - 1)) / CGFloat(configuration.columnCount)
        var cellH: CGFloat = 0
        switch configuration.heightType {
        case .fixed(let h):
            cellH = h
        case .scaled(let ratio):
            cellH = cellW * ratio
        }
        var row: Int = 0
        var col: Int = 0
        for (index, cell) in currentArrangedViews.enumerated() {
            row = index / configuration.columnCount
            col = index % configuration.columnCount
            cell.frame = .init(x: CGFloat(col) * (cellW + configuration.padding.width),
                               y: CGFloat(row) * (cellH + configuration.padding.height),
                               width: cellW,
                               height: cellH)
            if index == currentArrangedViews.count - 1 {
                cell.snp.remakeConstraints {
                    $0.size.equalTo(CGSize(width: cellW, height: cellH))
                    $0.edges.equalTo(UIEdgeInsets(top: cell.frame.minY, left: cell.frame.minX, bottom: 0, right: frame.width - cell.frame.maxX))
                }
            }
        }
    }
}

extension SimpleCollectionView {
    struct Configuration {
        enum HeightType {
            case fixed(CGFloat)
            /// The ratio is  `height / width`.
            case scaled(CGFloat)
        }
        
        let padding: CGSize
        let columnCount: Int
        let heightType: HeightType
    }
}
