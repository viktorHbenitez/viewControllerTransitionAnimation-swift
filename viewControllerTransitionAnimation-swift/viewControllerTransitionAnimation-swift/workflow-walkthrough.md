#  Looking through the starter project 

## important view's in the app

### view's
1.  App's title and main description  
2. scroll view at the botton: show's the list of available herbs  
3. the main view controller present HerbsDetailsViewController whenever the user tas one of the images in the list.  

![imagen](../master/assets/sketch1.gif)

### How to create a scroll view and add imageview on it  

1. Create all image view's  
2. Position all images inside the list (scrollview)  
3. Set the size horizontally to the scroll  
4. Action to the image when the user pressed the image view (present viewController)  

```swift

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

```




