//
//  HistoryTableViewCell.swift
//  RockPapersCissors
//
//  Created by Daniel Esteban Alcantara on 24/10/26.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "HistoryCell"

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(resource: .gray1)
        label.numberOfLines = 0
        return label
    }()

    private let resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none

        let stack = UIStackView(arrangedSubviews: [resultLabel, resultImageView])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            resultImageView.widthAnchor.constraint(equalToConstant: 25),
            resultImageView.heightAnchor.constraint(equalToConstant: 25),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(with result: Int) {
        switch result {
        case 0:
            resultLabel.text = "Lose!"
            resultImageView.image = UIImage(resource: .lose)
        case 1:
            resultLabel.text = "Draw!"
            resultImageView.image = UIImage(resource: .draw)
        case 2:
            resultLabel.text = "Win!"
            resultImageView.image = UIImage(resource: .win)
        default:
            resultLabel.text = "Unknown result"
            resultImageView.image = nil
        }
    }
}
