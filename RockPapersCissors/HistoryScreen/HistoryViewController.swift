//
//  OrderViewController.swift
//  CoffeAppProgramaticMain
//
//  Created by Daniel Esteban Alcantara on 10/10/26.
//

import UIKit

class HistoryViewController : UIViewController {
    
    var matchResults : [Int] = []
    private var countWin : Int = 0
    private var countDraw : Int = 0
    private var countLose : Int = 0
    
    
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Game History"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(resource: .gray1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let winImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .win)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let drawImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .draw)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loseImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .lose)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let winCountLabel : UILabel = {
        let label = UILabel()
        label.text = "8"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(resource: .gray1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let drawCountLabel : UILabel = {
        let label = UILabel()
        label.text = "3"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(resource: .gray1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loseCountLabel : UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(resource: .gray1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countWinStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let countDrawStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let countLoseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let countMatchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let matchesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchResults.reverse()
        
        setupInitialValues()
        setupHerarchy()
        setupConstraints()
        showHistory()
    }
    
    private func showHistory() {
        winCountLabel.text = "\(matchResults.filter { $0 == 2 }.count)"
        drawCountLabel.text = "\(matchResults.filter { $0 == 1 }.count)"
        loseCountLabel.text = "\(matchResults.filter { $0 == 0 }.count)"

        for row in matchesStackView.arrangedSubviews {
            matchesStackView.removeArrangedSubview(row)
            row.removeFromSuperview()
        }

        for result in matchResults {
            let text: String
            let image: UIImage

            switch result {
            case 0:
                text = "Lose!"
                image = UIImage(resource: .lose)
            case 1:
                text = "Draw!"
                image = UIImage(resource: .draw)
            case 2:
                text = "Win!"
                image = UIImage(resource: .win)
            default:
                continue
            }

            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 17, weight: .bold)
            label.textColor = UIColor(resource: .gray1)

            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 25),
                imageView.heightAnchor.constraint(equalToConstant: 25)
            ])

            let row = UIStackView(arrangedSubviews: [label, imageView])
            row.axis = .horizontal
            row.spacing = 8
            row.alignment = .center

            matchesStackView.addArrangedSubview(row)
        }
    }

    private func setupInitialValues() {
        view.backgroundColor = UIColor(resource: .blue3)
    }
    
    private func setupHerarchy() {
        
        view.addSubview(titleLabel)
        
        countWinStackView.addArrangedSubview(winImage)
        countWinStackView.addArrangedSubview(winCountLabel)
        
        countDrawStackView.addArrangedSubview(drawImage)
        countDrawStackView.addArrangedSubview(drawCountLabel)
        
        countLoseStackView.addArrangedSubview(loseImage)
        countLoseStackView.addArrangedSubview(loseCountLabel)
        
        countMatchStackView.addArrangedSubview(countWinStackView)
        countMatchStackView.addArrangedSubview(countDrawStackView)
        countMatchStackView.addArrangedSubview(countLoseStackView)
        view.addSubview(countMatchStackView)
        
        view.addSubview(matchesStackView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -24),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 24),
            
            winImage.widthAnchor.constraint(equalToConstant: 32),
            winImage.heightAnchor.constraint(equalToConstant: 32),
            drawImage.widthAnchor.constraint(equalToConstant: 32),
            drawImage.heightAnchor.constraint(equalToConstant: 32),
            loseImage.widthAnchor.constraint(equalToConstant: 32),
            loseImage.heightAnchor.constraint(equalToConstant: 32),
            
            countMatchStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            countMatchStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            countMatchStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),

            matchesStackView.topAnchor.constraint(equalTo: countMatchStackView.bottomAnchor, constant: 24),
            matchesStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            matchesStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            
        ])
    }
}
