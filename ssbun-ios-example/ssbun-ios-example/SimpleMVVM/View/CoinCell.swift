//
//  CoinCell.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//

import UIKit

class CoinCell: NiblessControl {
    
    // MARK: - UI Properties
    let titleLabel = UILabel() >> {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    let subtitleLabel = UILabel() >> {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Setup UI Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        updateUI()
    }
    
    private func updateUI() {
        layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.gray.cgColor
        backgroundColor = isSelected ? .blue.withAlphaComponent(0.08) : .lightGray
        titleLabel.textColor = isSelected ? .blue : .black
        subtitleLabel.textColor = isSelected ? .blue : .gray
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        
        let centerView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        centerView.isUserInteractionEnabled = false
        centerView.axis = .vertical
        centerView.spacing = 8
        centerView.alignment = .center
        addSubview(centerView)
        centerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

func >><Value>(_ value: Value, _ handle: (inout Value) -> Void) -> Value {
    var value = value
    handle(&value)
    return value
}
