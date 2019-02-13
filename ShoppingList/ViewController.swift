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
class ViewController: UIViewController {
    
    @IBOutlet var textFields: [UITextField]!
    
    
    @IBOutlet weak var descriptionTextField: UITextField!
   
    @IBOutlet weak var amountTextField: UITextField!
    
    
    @IBOutlet weak var itemsListArea: UITextView!
    
    
    /*
     ShoppingCart: contains the item and its price.
    */
    var shoppingCart: [(String, Int)] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dissmissKeyBoardWhenNotTouchingTextFields()
    }
    

    
    /*
        Dismisses the keyboard when you hit return.
        Does not dismisses the keyboard for number pads.
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
    
    /*
     newList: clears the shopping cart and the text area
     that displays the items from the shopping cart.
    */
    @IBAction func createNewList(_ sender: UIButton) {
        self.shoppingCart.removeAll()
        self.itemsListArea.text = ""
    }
    
    /*
        Builds a string from the array of tupples of
        (Item, Price)
    */
    func buildString(_ someArray:[(String, Int)])-> String {
        var result:String = ""
        for tupple in  someArray {
            result = tupple.0 + " " + String(tupple.1) + "\n"
        }
        return result
    }

    /*
        Adds an item to the shopping cart when pressed.
    */
    @IBAction func addItemToCart(_ sender: UIButton) {
        var product:(String, Int);
        let descriptionText = self.descriptionTextField.text!
       
        let quantityText = Int(self.amountTextField.text!)
        if self.isInstanceOfInt(quantityText) &&
            descriptionText.count > 0 {
            product.1 = quantityText!
            product.0 = descriptionText
            self.shoppingCart.append(product)
        } else {
            self.displayPopUpErrorMessage()
        }
        let stringToShow = buildString(self.shoppingCart)
        self.itemsListArea.text += stringToShow
    }
    
    /*
        Resets the description and quantity fields.
    */
    @IBAction func clearInputFields(_ sender: UIButton) {
        self.descriptionTextField.text = ""
        self.amountTextField.text = ""
    }
    
    /*
     Checks if a number is an instance of Int.
    */
    func isInstanceOfInt(_ possibleNumber:Int?)-> Bool {
        let result = possibleNumber is Int
        if result == true {
            return true
        } else {
            return false
        }
    }
    /*
        Displays an error message pop-up.
    */
    func displayPopUpErrorMessage() {
        let messageTitle = "Wrong Input Values"
        let errorMessage = "Description field is empty or quantity value is not numeric"
        
        // build a controller: UIAlertController.
        let alertController = UIAlertController(
            title: messageTitle,
            message: errorMessage,
            preferredStyle: .alert
        )
        
        let cancelAlertOption = UIAlertAction(title: "Understood", style: .cancel, handler: nil)
        // pass to the controller the option to cancel.
        alertController.addAction(cancelAlertOption)
        present(alertController, animated: true, completion: nil)
        
    }
}

