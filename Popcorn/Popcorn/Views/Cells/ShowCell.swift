//
//  ShowCell.swift
//  Popcorn
//
//  Created by Anne on 10/12/22.
//

import UIKit

final class ShowCell: UITableViewCell {
    private lazy var showImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    struct ViewModel {
        let image: UIImage
        let name: String
        let summary: String
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGroupedBackground
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(showImage)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, summaryLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        
        showImage.translatesAutoresizingMaskIntoConstraints = false
        showImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        showImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        showImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        showImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: showImage.trailingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
    }
    
    func setup(with viewModel: ViewModel) {
        showImage.image = viewModel.image
        nameLabel.text = viewModel.name
        summaryLabel.text = viewModel.summary
    }
}
