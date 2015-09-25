//
//  ActionViewController.swift
//  Shorten
//
//  Created by Subash Luitel on 9/23/15.
//  Copyright © 2015 Luitel Apps. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {


	var shortURL: NSString?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
		for item: AnyObject in self.extensionContext!.inputItems {
			let inputItem = item as! NSExtensionItem
			for provider: AnyObject in inputItem.attachments! {
				let itemProvider = provider as! NSItemProvider
				if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
					itemProvider.loadItemForTypeIdentifier(kUTTypeURL as String, options: nil, completionHandler: { (longURL,error) in
						if let url = longURL as? NSURL {
							print("Here")
							// Shorten url code here
							do {
								self.shortURL = try NSString(contentsOfURL: NSURL(string: "http://api.bit.ly/v3/shorten?login=o_44889edclf&apikey=R_bd0b259c526e4333b96e205cb6599daf&longUrl=\(url)&format=txt")!, usedEncoding: nil)

							} catch {
								// contents could not be loaded
							}
							NSOperationQueue.mainQueue().addOperationWithBlock {
								if let short = self.shortURL {
									let activityViewController = UIActivityViewController(activityItems: [short], applicationActivities: nil)
									self.presentViewController(activityViewController, animated: true, completion: nil)
								}
							}


						}
					})

                    break
                }
            }
            
		}
    }

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }

}
