/*
 * Copyright (c) 2014-2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

let arrHerbs = HerbModel.all()

class ViewController: UIViewController {
    
    @IBOutlet var listScrollView: UIScrollView!
    @IBOutlet var bgImage: UIImageView!
    var selectedImage: UIImageView?
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if listScrollView.subviews.count < arrHerbs.count {
            listScrollView.viewWithTag(0)?.tag = 1000 //prevent confusion when looking up images
            setupList()
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: View setup
    
    //1. add all images to the list
    func setupList() {
        
        for i in arrHerbs.indices {
            
            //create image view
            let imageView  = UIImageView(image: UIImage(named: arrHerbs[i].image))
            imageView.tag = i
            imageView.contentMode = .scaleAspectFill
            imageView.isUserInteractionEnabled = true
            imageView.layer.cornerRadius = 20.0
            imageView.layer.masksToBounds = true
            imageView.backgroundColor = UIColor.red
            
            listScrollView.addSubview(imageView)
            
            
            //attach tap detector
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView)))
        }
        
        listScrollView.backgroundColor = UIColor.brown
        positionListItems() // 2. position all images inside the scroll view
    }
    
    //position all images inside the scroll view
    /*
     (lldb) po listHeight
     243.0
     (lldb) po itemHeight
     323.19
     (lldb) po aspectRatio
     1.77777777777778
     (lldb) po itemWidth
     181.794375
     
     (lldb) po listView.contentSize
     ▿ (968.971875, 0.0)
     - width : 968.971875
     - height : 0.0
     */
    func positionListItems() {
        let scrollviewHeight = listScrollView.frame.height
        let itemHeight: CGFloat = scrollviewHeight * 1.33 // show image bigger than scroll view size
        
        let aspectRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width // width to the image
        let itemWidth: CGFloat = itemHeight / aspectRatio
        
        let horizontalPadding: CGFloat = 10.0
        
        for i in arrHerbs.indices {
            let imageView = listScrollView.viewWithTag(i) as! UIImageView // take the image with the tag
            imageView.frame = CGRect(x: CGFloat(i) * itemWidth + CGFloat(i+1) * horizontalPadding, // position the image one by one
                                     y: 0.0,
                                     width: itemWidth,
                                     height: itemHeight)
        }
        
        // 3. set the size of the scroll view  x ----> x
        listScrollView.contentSize = CGSize(width: CGFloat(arrHerbs.count) * (itemWidth + horizontalPadding) + horizontalPadding, height:0)
    }
    
    //MARK: Actions 4. Action to the image
    @objc func didTapImageView(_ tap: UITapGestureRecognizer) {
        selectedImage = tap.view as? UIImageView
        
        let index = tap.view!.tag
        let selectedHerb = arrHerbs[index]
        
        //present details view controller
        let herbDetails = storyboard!.instantiateViewController(withIdentifier: "HerbDetailsViewController") as! HerbDetailsViewController
        herbDetails.herb = selectedHerb
        present(herbDetails, animated: true, completion: nil)
    }
}
