//
//  LoginController.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//

import UIKit
import ARKit
class LoginController: UIViewController, UITextFieldDelegate{
    // MARK: - Properties
    var videoPlayerLayer: AVPlayerLayer?
    private var playerLooper: AVPlayerLooper?
    private var player: AVQueuePlayer?
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "WhiteLogo"))
        navigationItem.hidesBackButton = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //Styling the elments
        Utilities.styleTextField(emailText, placeHolderString: "Email.")
        Utilities.styleTextField(passwordText, placeHolderString: "Password.")
        Utilities.styleFilledButton(loginButton)
        emailText.delegate = self
        passwordText.delegate = self
        setUpVideo()
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @IBAction func LoginPressed(_ sender: Any) {
        let homeViewController = storyboard?.instantiateViewController(identifier: "home")
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //if return is pressed resign first responder to hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Handlers
    func setUpVideo(){
        //Get the path to the resource movie.
        let bandlePath = Bundle.main.path(forResource: "Login", ofType: "mp4")
        guard bandlePath != nil else { return }
        //Create the url from it.
        let url = URL(fileURLWithPath: bandlePath!)
        //Create the video player item.
        let item = AVPlayerItem(url: url)
        //Create the player.
        player = AVQueuePlayer()
        //Create the layer.
        videoPlayerLayer = AVPlayerLayer(player: player!)
        //Add the video in a loop, to be played agian.
        let duration = Int64( ( (Float64(CMTimeGetSeconds(AVAsset(url: url).duration)) *  10.0) - 1) / 10.0 )
        playerLooper = AVPlayerLooper(player: player!, templateItem: item, timeRange: CMTimeRange(start: CMTime.zero, end: CMTimeMake(value: duration, timescale: 1)) )
        //Adjust the size and frame.
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*0.3, y: 0, width: self.view.frame.size.width*1.5, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        //Add it to the view and play it.
        player?.playImmediately(atRate: 0.7)
    }
}
