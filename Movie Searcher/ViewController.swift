//
//  ViewController.swift
//  Movie Searcher
//
//  Created by GdavisIV on 3/23/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//
//API Key : http://www.omdbapi.com/

import UIKit

//UI

//Network Request to get movie list

//Tap a cell to see info about the movie

//Custom Cell to show the movie


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    //We'll need two outlets for a user interface a field and table
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    //Create an Array to store the info needed for our functions below
    //An array of movie objects
    var movies = [Movie]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
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
        URLSession.shared.dataTask(with: URL(string: "http://www.omdbapi.com/?apikey=955921a1=fast%20and&type=movie")!,
                                   completionHandler: {data, reponse, error in
                                    guard let data = data, error = nil else {
                                        return
                                    }
                                    
                                    //Convert Data
                                    
                                    //Update the Movie Array
                                    
                                    //Refresh the table
            //This is how you start the REQUST, the naming conventions makes no sense though!! BE AWARE!!
            }).resume()
        
    }
    
    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    //Number of rows in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //cell for Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Show movie details
    }
    
    //and did select a row
}

struct Movie {
    
}
