//
//  ViewController.swift
//  MTMsTask
//
//  Created by AbeerAbbasSaber on 23/04/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController{
    
    //Outlets
    
    @IBOutlet weak var userLocationTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var placesTableView: UITableView!
    
    //variables
    
    let sourceCollectionRef = Firestore.firestore().collection("Source")
    
    var locations = [Place]()
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }

    //Helper Fuctions
    
    func setUpView()
    {
        placesTableView.delegate = self
        placesTableView.dataSource = self

        userLocationTextField.addTarget(self, action: #selector(getData), for: .editingDidBegin)
        userLocationTextField.addTarget(self, action: #selector(hideData), for: .editingDidEnd)

        sourceCollectionRef.getDocuments{ (snapshot, error)
            in
            if let error = error
            {
                print("Error Feching Docs: \(error)")
            }else {
                for document in (snapshot?.documents)! {
                    print(document.data())
                    let data = document.data()
                    let name = data["name"] as? String ??  "name"
                    let lat = data["latitude"] as? String ?? "lat"
                    let lng = data["longtude"] as? String ?? "lng"
                    
                    let place = Place(name: name, latitude: lat, longtude: lng)
                    self.locations.append(place)
                }
                self.placesTableView.reloadData()
                
            }
        }
    }
    
    @objc func getData(){
        self.placesTableView.isHidden = false
        
    }
    @objc func hideData(){
        self.placesTableView.isHidden = true
    }
    //Actions
    
    

}

extension ViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = placesTableView.dequeueReusableCell(withIdentifier: COUNTRY_NAME_CELL) as! TableViewCell
        let place = locations[indexPath.row]
        cell.configueCell(name: place.name)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.userLocationTextField.text = locations[indexPath.row].name
        self.hideData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


