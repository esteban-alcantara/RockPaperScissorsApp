//
//  OrderViewController.swift
//  CoffeAppProgramaticMain
//
//  Created by Daniel Esteban Alcantara on 10/10/26.
//

import UIKit

class InfoViewController : UIViewController {
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Game Info"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(resource: .gray1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roundModeLabel : UILabel = {
        let label = UILabel()
        label.text = "Rounds Mode"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(resource: .gray1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roundDescriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Win the selected number of rounds to claim victory."
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 5
        label.textColor = UIColor(resource: .gray1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pointModeLabel : UILabel = {
        let label = UILabel()
        label.text = "Points Mode"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(resource: .gray1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pointDescriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Earn points for winning rounds, lose points for defeats, and reach the target score to win the game."
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 5
        label.textColor = UIColor(resource: .gray1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .info)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialValues()
        setupHerarchy()
        setupConstraints()
    }
    
    private func setupInitialValues() {
        view.backgroundColor = UIColor(resource: .beige)
    }
    
    private func setupHerarchy() {
        
        view.addSubview(roundModeLabel)
        
        view.addSubview(roundDescriptionLabel)
        
        view.addSubview(pointModeLabel)
        
        view.addSubview(pointDescriptionLabel)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(infoImage)
        view.addSubview(titleStackView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            titleStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            titleStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleStackView.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -24),
            titleStackView.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 24),
            infoImage.widthAnchor.constraint(equalToConstant: 32),
            infoImage.heightAnchor.constraint(equalToConstant: 32),
            
            roundModeLabel.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 25),
            roundModeLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            roundModeLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            
            roundDescriptionLabel.topAnchor.constraint(equalTo: roundModeLabel.bottomAnchor, constant: 6),
            roundDescriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            roundDescriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            
            pointModeLabel.topAnchor.constraint(equalTo: roundDescriptionLabel.bottomAnchor, constant: 25),
            pointModeLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            pointModeLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            
            pointDescriptionLabel.topAnchor.constraint(equalTo: pointModeLabel.bottomAnchor, constant: 6),
            pointDescriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            pointDescriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24)
            
        ])
    }
}
