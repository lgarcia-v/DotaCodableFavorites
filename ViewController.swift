//
//  ViewController.swift
//  DotaCodable
//
//  Created by Admin on 12/1/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var heroes = [Hero]()
    
    
    override func viewDidLoad() {
        setupTableView()
        super.viewDidLoad()
    }

    func setupTableView() {
        fetchJson {
            self.tableview.reloadData()
        }
        tableview.delegate = self
        tableview.dataSource = self
    }
    /*
     A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. Escaping closures outlive the function it was passed into.
     https://www.appypie.com/escaping-closures-swift
     https://betterprogramming.pub/escaping-and-non-escaping-closures-in-swift-fe2866309599
     */

    func fetchJson(completed: @escaping ()->()) {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else { return }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "Something happened here")")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("server error!")
                return
            }
            
            guard data != nil else {
                print("Error: We have no data bub")
                return
            }
            
            do {
                // instead of first serializing the json with JSONSerialization class or associated functions we can instead let the instance of our array of heroes hold the decoded data directly.
                self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                
                DispatchQueue.main.async {
                    // here we call the closure to indicate this is where the results of the fetch should be used
                    completed()
                }
                
            } catch {
                print("Error: \(error.localizedDescription)")
            }

        }
        task.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heroes[indexPath.row].name.capitalized
        return cell
    }
    //function to change the color of selected cell a sfavorite/ or image
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.hero = heroes[(tableview.indexPathForSelectedRow?.row)!]
            
        }
    }
}
