//
//  ViewController.swift
//  Movie Searcher
//
//  Created by GdavisIV on 3/23/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//
//API Key : http://www.omdbapi.com/

import UIKit
import SafariServices

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    //We'll need two outlets for a user interface a field and table
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    //Create an Array to store the info needed for our functions below
    //An array of movie objects
    var movies = [Movie]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        table.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        //Assign the delegate and dataSource
        table.delegate = self
        table.dataSource = self
        field.delegate = self
        // Do any additional setup after loading the view.
    }
    //Field
    //This will capture the event when the user hits the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    //create a function to search for the movies, and capture the eevnt when user hits the return key
    //We create a network request
    func searchMovies() {
        //Want to have the keyboard for the field to go away after pressing Enter
        field.resignFirstResponder()
        
        //Make sure there is text in the field else return
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        //All spaces between text need to be removed
        let query = text.replacingOccurrences(of: " ", with: "%20")
        
        movies.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=955921a1&s=\(query)&type=movie")!,
               completionHandler: {data, reponse, error in
                guard let data = data, error == nil else {
                    return
                }
                
                //Convert Data using Swifts Codable
                var result: MovieResult?
                do {
                    result = try JSONDecoder().decode(MovieResult.self, from: data)
                }
                catch {
                    print("error")
                }
                
                guard let finalResult = result else {
                    return
                }
                
                //Update the Movies Array
                let newMovies = finalResult.Search
                self.movies.append(contentsOf: newMovies)
                
                //Refresh the table
                //This is how the user interface is updated
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                    
                //This is how you start the REQUST, the naming conventions makes no sense though!! BE AWARE!!
        }).resume()
        
    }
    
    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    //Number of rows in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    //cell for Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Show movie details
        let url = "https://www.imdb.com/title/\(movies[indexPath.row].imdbID)/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
    }
    
    //and did select a row
}

struct MovieResult: Codable {
    let Search: [Movie]
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    //Typpe is reserved for Json
    let _Type: String
    let Poster: String
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}
