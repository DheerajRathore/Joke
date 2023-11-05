//
//  JokeTableViewCell.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 02/11/23.
//

import UIKit

class JokeTableViewCell: UITableViewCell {

    // MARK: UI COMPONENT.
    private var dataView: UIView  = {
        let dataView = UIView()
        dataView.backgroundColor = UIColor(red: 191/255, green: 298/255, blue: 49/255, alpha: 1)
        dataView.translatesAutoresizingMaskIntoConstraints = false
        return dataView
    }()
    
    private var jokeDescriptionLbl: UILabel = {
       let jokeDescriptionLbl = UILabel()
        jokeDescriptionLbl.textAlignment = .left
        jokeDescriptionLbl.font = UIFont.systemFont(ofSize: 15)
        jokeDescriptionLbl.numberOfLines = 0
        jokeDescriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        return jokeDescriptionLbl
    }()
    
    private var dateLbl: UILabel = {
       let dateLbl = UILabel()
        dateLbl.textAlignment = .left
        dateLbl.font = UIFont.systemFont(ofSize: 10)
        dateLbl.textColor = UIColor.darkGray
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        return dateLbl
    }()

    //MARK: PROPERTIES.
    var joke: Joke? {
        didSet {
            if let data = joke {
                jokeDescriptionLbl.text = data.message
                dateLbl.text = Date().getFormatedDate(data.createdAt ?? Date())
            }
        }
    }

    //MARK: INIT METHODS.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: SET UP UI
    private func setUpUI() {
        dataView.addSubview(jokeDescriptionLbl)
        dataView.addSubview(dateLbl)
        self.contentView.addSubview(dataView)
        dataView.layer.cornerRadius = 10
        self.backgroundColor = UIColor.clear
       
        // set constrains
        NSLayoutConstraint.activate([
            // constraint for data view
            dataView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            dataView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            dataView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            dataView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            
            jokeDescriptionLbl.topAnchor.constraint(equalTo: self.dataView.layoutMarginsGuide.topAnchor),
            jokeDescriptionLbl.leadingAnchor.constraint(equalTo: self.dataView.layoutMarginsGuide.leadingAnchor),
            jokeDescriptionLbl.trailingAnchor.constraint(equalTo: self.dataView.layoutMarginsGuide.trailingAnchor),
            
            
            dateLbl.topAnchor.constraint(equalTo: self.jokeDescriptionLbl.bottomAnchor),
            dateLbl.leadingAnchor.constraint(equalTo: self.dataView.layoutMarginsGuide.leadingAnchor),
            dateLbl.bottomAnchor.constraint(equalTo: self.dataView.layoutMarginsGuide.bottomAnchor),
            dateLbl.trailingAnchor.constraint(equalTo: self.dataView.layoutMarginsGuide.trailingAnchor),
            
        ])
    }
}
