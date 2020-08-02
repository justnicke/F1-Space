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
    private var articles: [Article] = []
    private var articlesReset: Bool = false
    private var dateRequest = Date()
    private let refreshControl = UIRefreshControl()
    private let refreshView = RefreshView()
    private let activityIndicator = CustromActivityIndicator()
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupTableView()
        requestNews()
        setupActivityIndicator()
        setupRefreshControlAndView()
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
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reusId)
        
        // refresh
        tableView.refreshControl = refreshControl
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
        refreshView.activityIndicator.startAnimating()
    }
    
    private func stopAnimateActivity() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
            self?.activityIndicator.stopAnimating()
        }
    }
        
    private func requestNews() {
        guard articles.isEmpty || DateInterval(start: dateRequest, end: Date()).duration > TimeInterval(floatLiteral: 1) else {
            stopAnimateActivity()
            return
        }
        
        articlesReset  = true
        
        DispatchQueue.main.async {
            for feed in RSS.feeds {
                let rss = RSS()
                rss.requestNews(feed: feed,
                                success: { [weak self] articles in
                                    DispatchQueue.main.async {
                                        guard let newsVC = self else { return }
                                        
                                        if newsVC.articlesReset {
                                            newsVC.articles = []
                                            newsVC.dateRequest = Date()
                                        }
                                        
                                        newsVC.articlesReset = false
                                        newsVC.articles = (newsVC.articles + articles).sorted { ($0.published ?? Date()) > ($1.published ?? Date()) }
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
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reusId, for: indexPath) as! NewsCell
        cell.configure(article: articles[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let article = self.articles[indexPath.row]
            let vc = DetailNewsViewController(urlString: article.url)
            
            if article.url.contains("motorsport.com") {
                vc.resourceNameLabel.text = "motorsport"
            } else {
                vc.resourceNameLabel.text = "F1NEWS"
            }
            
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true, completion: nil)
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
}
