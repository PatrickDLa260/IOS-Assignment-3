//
//  AdoptionViewController.swift
//  PawsitivelyPurrfect
//
//  Created by Patrick La on 17/5/2024.
//

import UIKit

class AdoptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var breedName: String?
    var dogs: [Dog] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register the custom cell NIB
        let nib = UINib(nibName: "DogCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DogCell")
        
        if let breedName = breedName {
            print("Fetching dogs for breed: \(breedName)")
            fetchDogs(for: breedName)
        } else {
            print("No breed name provided")
        }
    }

    func fetchDogs(for breedName: String) {
        print("Starting fetch for breed: \(breedName)")
        let name = breedName.replacingOccurrences(of: " ", with: "%20")
        let apiUrl = "https://api.api-ninjas.com/v1/dogs?name=\(name)"
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.setValue("9X45YrzoOtvqGZRv9cdN7w==EiClPYFEpILVQKfd", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error:", error ?? "Unknown error")
                return
            }
            do {
                let dogs = try JSONDecoder().decode([Dog].self, from: data)
                print("Fetched \(dogs.count) dogs")
                DispatchQueue.main.async {
                    self.dogs = dogs
                    self.tableView.reloadData()
                }
            } catch {
                print("Failed to decode JSON:", error)
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogCell
        let dog = dogs[indexPath.row]
        cell.nameLabel.text = dog.name
        cell.descriptionLabel.text = dog.description
        return cell
    }
}
