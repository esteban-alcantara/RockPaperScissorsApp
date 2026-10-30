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
    
    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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

        historyTableView.reloadData()
    }

    private func setupInitialValues() {
        view.backgroundColor = UIColor(resource: .blue3)
        historyTableView.register(
            HistoryTableViewCell.self,
            forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier
        )
        historyTableView.dataSource = self
        historyTableView.rowHeight = UITableView.automaticDimension
        historyTableView.estimatedRowHeight = 60
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
        
        view.addSubview(historyTableView)
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

            historyTableView.topAnchor.constraint(equalTo: countMatchStackView.bottomAnchor, constant: 24),
            historyTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            historyTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            historyTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
        ])
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HistoryTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? HistoryTableViewCell else {
            return UITableViewCell()
        }

        let result = matchResults[indexPath.row]
        cell.configure(with: result)
        return cell
    }
}
