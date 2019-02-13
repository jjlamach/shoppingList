//
//  ViewController.swift
//  ShoppingList
//
//  Created by Julio on 2/12/19.
//  Copyright © 2019 Julio Lama. All rights reserved.
//

import UIKit
/*
 A component that has a TableView must conform to the
 UITableViewDataSource protocol.
 */
class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet var textFields: [UITextField]!
    
    
    var shoppingCart: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.dissmissKeyBoardWhenNotTouchingTextFields()
    }
    
    // Returns the number of rows of the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // call the reusable row.
        let reusableCell = self.tableView.dequeueReusableCell(withIdentifier: "MyReusableRow")!

        // Dale informacion a la fila.
        // La informacion proviene de las filas que creas mediante el objeto IndexPath.
        // IndexPath contiene rows que son las filas que tu creas.
        reusableCell.textLabel?.text = self.shoppingCart[indexPath.row]
        return reusableCell
        
    }
    
    /*
        Dismisses the keyboard when you hit return.
        Does not dismisses the keyboard for the number pad.
    */
    @IBAction func dismissKeyBoard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    
    
    /*
        This piece of code dismisses the keyboard when you are not touching
        the text fields.
        Works also for the number pad.
     UITapGestureRecognizer: looks for multiple taps in the view.
            1) looks for a target.
            2) action -> the .endEditing action.
    */
    func dissmissKeyBoardWhenNotTouchingTextFields() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
}

