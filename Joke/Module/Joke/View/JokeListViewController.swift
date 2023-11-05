//
//  ViewController.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 31/10/23.
//

import UIKit

class JokeListViewController: UIViewController {
    
    //MARK: PROPERTIES.
    private(set) var presenter: JokesListPresenter!
    weak var timer: Timer?
    
    func inject(presenter: JokesListPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - UI Component
    private var pageTitle: UILabel = {
        let pageTitle = UILabel()
        pageTitle.textColor = UIColor(red: 191/255, green: 298/255, blue: 49/255, alpha: 1)
        pageTitle.text = StringConstant.headerTitle
        pageTitle.textAlignment = .center
        pageTitle.font = UIFont.systemFont(ofSize: 15)
        pageTitle.translatesAutoresizingMaskIntoConstraints = false
        return pageTitle
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.register(JokeTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: View Life Cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        // call presenter viewDidLoad for initial setup.
        presenter.viewDidLoad()
        // adding timer to call method in every 60 seconds
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(getJokes), userInfo: nil, repeats: true)
    }
    
    
    deinit {
        // invalidate the timer
        timer?.invalidate()
    }
    
    // MARK: Methods
    private func setupUI() {
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(pageTitle)
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            
            pageTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pageTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.pageTitle.bottomAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5)
        ])
    }
    
    @objc func getJokes(){
        presenter.fetchJoke()
    }
}

//Extension for handling JokesListPresenterProtocol protocol.
extension JokeListViewController:  JokesListPresenterProtocol {
   
    func refreshList() {
        tableView.reloadData()
    }
    
    /// showAPIError method is used for displaying error gots from network call
    /// - Parameter withErrorMessage: string parameter for displaying the error.
    func showAPIError(withErrorMessage: String) {
        // display alert.
        let alert = UIAlertController(title: StringConstant.errorAlertTitle, message: withErrorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: StringConstant.okButtonTitle, style: .cancel, handler: { (_) in
             }))
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - UITableView Data Source
extension JokeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.jokeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? JokeTableViewCell else {
            // if cell is not created/dequed with custom cell than terminate the app.
            fatalError("Error while creating the cell")
        }
        // set the values.
        cell.joke = presenter.jokeList[indexPath.row]
        return cell
    }
}

