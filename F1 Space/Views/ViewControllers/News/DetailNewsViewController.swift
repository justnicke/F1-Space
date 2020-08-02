//
//  DetailNewsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 29.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import WebKit

final class DetailNewsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var resourceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Formula1-Display-Bold", size: 22)
        label.textColor = .white
        return label
    }()
    var urlString: String
    
    // MARK: - Private Properties
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "chevron.down", withConfiguration: boldConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    private let activityIndicator = CustromActivityIndicator()
    lazy private var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - Constructors
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavView()
        setupWebView()
        
        backButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupActivityIndicator()
        requestWebView()
    }
    
    // MARK: - Private Methods
    
    private func setupNavView() {
        view.addSubview(navigationView)
        navigationView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: .init(width: view.frame.width, height: 56)
        )
        
        [resourceNameLabel, backButton].forEach {
            navigationView.addSubview($0)
        }
        
        resourceNameLabel.centerInSuperview(size: .init(width: 0, height: navigationView.frame.height))
        
        backButton.anchor(
            top: navigationView.topAnchor,
            leading: navigationView.leadingAnchor,
            bottom: navigationView.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 10, bottom: 0, right: 0),
            size: .init(width: 50, height: 0)
        )
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.anchor(
            top: navigationView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor
        )
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.color = .red
        activityIndicator.startAnimating()
    }
    
    private func requestWebView() {
        guard let url = URL(string: urlString) else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
    @objc private func dismissAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - WKNavigationDelegate

extension DetailNewsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}


