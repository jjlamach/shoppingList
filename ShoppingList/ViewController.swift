//
//  ViewController.swift
//  ShoppingList
//
//  Created by Julio on 2/12/19.
//  Copyright © 2019 Julio Lama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var descriptionTextField: UITextField!
   
    @IBOutlet weak var amountTextField: UITextField!
    
    
    @IBOutlet weak var itemsListArea: UITextView!
    
    
    /*
     ShoppingCart, a tupple: contains the item and its price.
    */
    var shoppingCart: [(String, Int)] = []
    
    
    
// Do any additional setup after loading the view, typically from a nib.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dissmissKeyBoardWhenNotTouchingTextFields()
       self.textViewProperties()
    }
    
    /*
        Trigger keyboard when touched.
        For description text field.
    */
    @IBAction func activateKeyboard(_ sender: UITextField) {
        sender.becomeFirstResponder()
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
            result = String(tupple.1) + "x " + tupple.0 + "\n"
        }
        return result
    }

    /*
        Adds an item to the shopping cart when pressed.
    */
    @IBAction func addItemToCart(_ sender: UIButton) {
        var product:(String, Int);
        // check for empty fields.
        if self.descriptionTextField.text == "" && self.amountTextField.text == "" {
            self.errorBothTextFieldsEmpty()
            return
        }
        else if self.descriptionTextField.text != "" &&
            self.amountTextField.text == "" {
            self.generalErrorPopUpMessage()
            return
        }
        else if self.descriptionTextField.text == "" &&
            self.amountTextField.text != "" {
            self.generalErrorPopUpMessage()
            return
        }
        // gets the values of the input fields.
        let descriptionText = self.descriptionTextField.text!

        let quantityText = Int(self.amountTextField.text!)
        
        // to make sure it is a valid number, should not be nil
        if quantityText == nil {
            self.generalErrorPopUpMessage()
            return
        }
            // fill the tupple.
        else if quantityText != nil && descriptionText != "" {
            product.1 = quantityText!
            product.0 = descriptionText
            self.shoppingCart.append(product)
        } else {
            self.generalErrorPopUpMessage()
            return
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
        Displays an error message pop-up.
    */
    func generalErrorPopUpMessage() {
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
    
    /*
        Error pop-up message for when both text fields
     are empty.
    */
    func errorBothTextFieldsEmpty() {
        let messageTitle = "Empty Input Values"
        let errorMessage = "Description and Quantity fields are empty."
        
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
    
    
    
    /*
     Properties for the UITextView.
    */
    func textViewProperties() -> Void {
        self.itemsListArea.isEditable = false
        self.itemsListArea.textColor = UIColor.blue
        self.itemsListArea.font = UIFont.init(name: "Times New Roman", size: 20)
    }
}

