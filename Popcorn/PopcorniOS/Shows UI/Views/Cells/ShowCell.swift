//
//  ShowCell.swift
//  Popcorn
//
//  Created by Anne on 10/12/22.
//

import UIKit

final class ShowCell: UITableViewCell {
    lazy var showImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .systemPurple
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(showImageView)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, summaryLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        
        showImageView.translatesAutoresizingMaskIntoConstraints = false
        showImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        showImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        showImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        showImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: showImageView.trailingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
