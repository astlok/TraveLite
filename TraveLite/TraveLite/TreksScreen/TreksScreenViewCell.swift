//
//  TreksScreenCell.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 4/12/21.
//

import Foundation
import UIKit

final class TreksScreenViewCell: UITableViewCell {
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let difficult: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let days: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let region: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let rating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    
    private let containerView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setup()
        
    }
    
    
    func setup() {
        [name, difficult, days, region, rating].forEach {
            containerView.addSubview($0)
        }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        name.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        name.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        
        difficult.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        difficult.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        difficult.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        
        days.topAnchor.constraint(equalTo: difficult.bottomAnchor, constant: 5).isActive = true
        days.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        days.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        
        region.topAnchor.constraint(equalTo: days.bottomAnchor, constant: 5).isActive = true
        region.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        region.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        rating.topAnchor.constraint(equalTo: region.bottomAnchor, constant: 5).isActive = true
        rating.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        rating.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        contentView.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configure(with trekModel: TrekCellModell) {
        name.text = trekModel.name
        difficult.text = "Cложность: " + String(trekModel.difficult)
        days.text = "Дней похода: " + String(trekModel.days)
        region.text = "Регион: " + trekModel.region
        rating.text = "Рейтинг: " + String(trekModel.rating)
    }

}
