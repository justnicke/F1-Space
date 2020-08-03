//
//  NewsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 28.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var tableView: UITableView!
    private var articlesReset: Bool = false
    private var dateRequest = Date()
    private let refreshControl = UIRefreshControl()
    private let refreshView = RefreshView()
    private let activityIndicator = CustromActivityIndicator()
    private var newsViewModel: NewsViewModel?
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupTableView()
        setupActivityIndicator()
        setupRefreshControlAndView()
        
        newsViewModel = NewsViewModel()
    
        requestViewModel()
    }
        
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = #colorLiteral(red: 0.9815699458, green: 0.9517598748, blue: 0.9695971608, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 155
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseId)
        
        // refresh
        tableView.refreshControl = refreshControl
    }
    
    private func requestViewModel() {
        newsViewModel?.requestData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
        
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        activityIndicator.color = .red
        activityIndicator.startAnimating()
    }
    
    private func setupRefreshControlAndView() {
        // control
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        
        // view
        refreshControl.addSubview(refreshView)
        refreshView.centerInSuperview()
        refreshView.backgroundColor = .clear
    }
    
    @objc private func updateData() {
        requestViewModel()
        refreshView.activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.refreshView.activityIndicator.stopAnimating()
            self?.tableView.refreshControl?.endRefreshing()
            
        }
    }
}

// MARK: - Extension TableViewDataSource & TableViewDelegate

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as! NewsCell
        let newsCellViewModel = newsViewModel?.cellForItemAt(indexPath: indexPath)
        cell.configure(viewModel: newsCellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detailVM = self.newsViewModel?.didSelectRowAt(indexPath: indexPath)
            let vc = DetailNewsViewController(detailViewModel: detailVM)
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true, completion: nil)
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
}
