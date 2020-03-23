//
//  ViewController.swift
//  Movie Searcher
//
//  Created by user163072 on 3/23/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import UIKit

//UI

//Network Request to get movie list

//Tap a cell to see info about the movie

//Custom Cell to show the movie


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    //We'll need two outlets for a user interface a field and table
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
        
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
    //This function will search for the movies
    func searchMovies() {
        
    }
    //create a function to search for the movies, and capture the eevnt when user hits the return key

}

