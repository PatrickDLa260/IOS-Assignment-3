//
//  AdoptionView.swift
//  PawsitivelyPurrfect
//
//  Created by Patrick La on 17/5/2024.
//

import UIKit

class AdoptionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dogs: [String] = [] // This will hold the list of dog names

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Fetch the list of dogs available for adoption
        fetchDogs()
    }

    func fetchDogs() {
        // This is where you would make a network request to get the list of adoptable dogs
        // For simplicity, let's just use some dummy data
        dogs = ["Bulldog", "Labrador", "Beagle", "Poodle", "Chihuahua"]
        tableView.reloadData()
    }
}

extension AdoptionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath)
        cell.textLabel?.text = dogs[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedDog = dogs[indexPath.row]
        // Perform any action you want with the selected dog
        print("Selected dog: \(selectedDog)")
    }
}

