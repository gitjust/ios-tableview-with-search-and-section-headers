//
//  ViewController.swift
//  MyTable
//
//  Created by Justinus Andjarwirawan on 17/06/20.
//  Copyright © 2020 Justinus Andjarwirawan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let data = ["Apples", "Oranges", "Pears", "Bananas", "Plums", "Mango", "Pineapple", "Watermelon", "Peach", "Avocado", "Strawberry", "Blackberry", "Durian", "Jackfruit", "Dragonfruit", "Salak"]
    
    var filteredData: [String]!
    var dataDict = [String: [String]]()
    var dataSectTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filteredData = data
        makeSections()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSectTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = dataSectTitles[section]
        if let fData = dataDict[key] {
            return fData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        //cell.textLabel?.text = filteredData[indexPath.row]+"\(indexPath.section)"
        let key = dataSectTitles[indexPath.section]
        if let fData = dataDict[key] {
            cell.textLabel?.text = fData[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSectTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataSectTitles
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        dataDict = [String: [String]]()
        dataSectTitles = [String]()
        if searchText == "" {
            filteredData = data
        }
        for fruit in data {
            if fruit.lowercased().contains(searchText.lowercased()) {
                filteredData.append(fruit)
            }
        }
        makeSections()
        self.tableView.reloadData()
    }
    
    func makeSections() {
        for fData in filteredData {
            let key = String(fData.prefix(1))
            if var d = dataDict[key] {
                d.append(fData)
                dataDict[key] = d
            } else {
                dataDict[key] = [fData]
            }
        }
        dataSectTitles = [String](dataDict.keys)
        dataSectTitles = dataSectTitles.sorted(by: { $0 < $1 })
    }
}

