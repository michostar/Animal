//
//  ViewController.swift
//  AnimalTable
//
//  Created by Michael Shoukry on 9/17/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet var tableView: UITableView!
    
    var animals:[Animale] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadingData{
            self.tableView.reloadData()
            
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableName: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableName.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        
        

        
        cell.textLabel?.text = animals[indexPath.row].name.capitalized
        
        cell.buttonTapCallbackGroup = {
            
            cell.label.text = self.animals[indexPath.row].name
            print("you pressed of \(self.animals[indexPath.row].name)")
                
        }
         
        return cell
    }
    
    
    
    func downloadingData( completed: @escaping () -> ()){
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                animals = try JSONDecoder().decode([Animale].self, from: data)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    class MyCell: UITableViewCell {
        
        var buttonTapCallbackGroup: () -> ()  = { }
        var buttonTapCallbackSolo: () -> () = { }
        
        
        let button: UIButton = {
            let btn = UIButton()
            btn.setTitle("Group", for: .normal)
            btn.backgroundColor = .systemPink
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.frame(forAlignmentRect: .zero)
           
            return btn
        }()
        
        let buttonSolo: UIButton = {
            let btn = UIButton()
            btn.setTitle("Solo", for: .normal)
            btn.backgroundColor = .gray
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.frame(forAlignmentRect: .zero)
            return btn
        }()
        
        
        let label: UILabel = {
           let lbl = UILabel()
            lbl.font = UIFont.systemFont(ofSize: 16)
            lbl.textColor = .systemPink
            
           return lbl
        }()
        
        @objc func didTapButton() {
            buttonTapCallbackGroup()
            buttonTapCallbackSolo()
            
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            //Add button
            contentView.addSubview(button)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            
            //Set constraints as per your requirements
            button.translatesAutoresizingMaskIntoConstraints = false
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 250).isActive = true
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

            contentView.addSubview(buttonSolo)
            buttonSolo.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            
            //Set constraints as per your requirements
            buttonSolo.translatesAutoresizingMaskIntoConstraints = false
            buttonSolo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100).isActive = true
            buttonSolo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
            buttonSolo.widthAnchor.constraint(equalToConstant: 100).isActive = true
            buttonSolo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
            
            //Add label
            contentView.addSubview(label)
            //Set constraints as per your requirements
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: -250).isActive = true
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }
    
}


