//
//  NewsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 28.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private var tableView: UITableView!
    private var items: [Article] = []
    private var itemsReset: Bool = false
    private var dateRequest = Date()
    private var activityIndicator: UIActivityIndicatorView?
    private let refreshControl = UIRefreshControl()

    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupTableView()
        setupActivityIndicator()
        requestNews()
        
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 155
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reusId)
        
        // refresh
        tableView.refreshControl = refreshControl
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.center = view.center
        activityIndicator?.startAnimating()
        if let activityIndicatorView = activityIndicator {
            view.addSubview(activityIndicatorView)
        }
    }
    
    private func stopAnimateActivity() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
            self?.activityIndicator?.stopAnimating()
        }
    }
    
    private func requestNews() {
        guard items.isEmpty || DateInterval(start: dateRequest, end: Date()).duration > TimeInterval(floatLiteral: 10) else {
            stopAnimateActivity()
            return
        }
        
        itemsReset  = true
        
        DispatchQueue.main.async {
            for feed in RSS.feeds {
                let rss = RSS()
                rss.requestNews(feed: feed,
                                success: { [weak self] articles in
                                    DispatchQueue.main.async {
                                        guard let newsVC = self else { return }
                                        
                                        if newsVC.itemsReset {
                                            newsVC.items = []
                                            newsVC.dateRequest = Date()
                                        }
                                        
                                        newsVC.itemsReset = false
                                        newsVC.items = (newsVC.items + articles).sorted { ($0.published ?? Date()) > ($1.published ?? Date()) }
                                        newsVC.tableView.reloadData()
                                        newsVC.stopAnimateActivity()
                                    }
                    },
                                failure: { [weak self] error in
                                    self?.stopAnimateActivity()
                                    print(error.localizedDescription)
                })
            }
        }
    }
    
    @objc private func updateData() {
        requestNews()
    }
}

// MARK: - TableViewDataSource & TableViewDelegate

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reusId, for: indexPath) as! NewsCell
        cell.configure(article: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailNewsViewController(urlString: items[indexPath.row].url)
        let navController = UINavigationController(rootViewController: vc)
        
        navController.modalTransitionStyle = .coverVertical
        present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
}
