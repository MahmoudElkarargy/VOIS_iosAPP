//
//  TrigerredWordsControler.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//

import UIKit
import AVFoundation

class TrigerredWordsController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate, UITextFieldDelegate{
    
    
    // MARK: - Properties
   
    let commands = ["Money Counter", "Lightness Detection", "Object Detection", "Text Scanner", "Color Detection"]
    var pickerView = UIPickerView()
    
    @IBOutlet weak var commandTextField: UITextField!
    //    @IBOutlet weak var playButton: UIButton!
//    @IBOutlet weak var recordingLabel: UILabel!
//    @IBOutlet weak var playLabel: UILabel!
//    @IBOutlet weak var stopButton: UIButton!
//    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer!

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(image: UIImage(named: "WhiteLogo")!)
//        playLabel.text = "No saved Records yet"
        pickerView.delegate = self
        pickerView.dataSource = self
        commandTextField.delegate = self
        commandTextField.inputView = pickerView
        commandTextField.textAlignment = .center
        pickerView.backgroundColor = UIColor(red: 21/255, green: 31/255, blue: 72/255, alpha: 1)
//        playButton.isEnabled = false
//        stopButton.isEnabled = false

        // getting URL path for audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPath[0]
        let soundFilePath = (docDir as NSString).appendingPathComponent("sound.caf")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        print(soundFilePath)

        //Setting for recorder
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey: 44100.0] as [String : Any] as [String : Any] as [String : Any] as [String : Any]
        var error : NSError?
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            audioRecorder = try AVAudioRecorder(url: soundFileURL as URL, settings: recordSettings as [String : AnyObject])
        } catch _ {
            print("Error")
        }

        if let err = error {
            print("audioSession error: \(err.localizedDescription)")
        }else{
            audioRecorder?.prepareToRecord()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //if return is pressed resign first responder to hide keyboard
        textField.resignFirstResponder()
        //Search when return pressed.
        return true
    }
    
    //record audio
//    @IBAction func recordAudio(sender: AnyObject) {
//        recordingLabel.text = "Recording in progress"
//        if audioRecorder?.isRecording == false{
//            playButton.isEnabled = false
//            stopButton.isEnabled = true
//            audioRecorder?.record()
//        }
//    }
    //stop recording audio
//    @IBAction func stopAudio(sender: AnyObject) {
//
//        stopButton.isEnabled = false
//        playButton.isEnabled = true
//        recordButton.isEnabled = true
//
//        if audioRecorder?.isRecording == true{
//            audioRecorder?.stop()
//            playLabel.text = "Play your Record"
//        }else{
//            audioPlayer?.stop()
//        }
//    }
//    //play your recorded audio
//    @IBAction func playAudio(sender: AnyObject) {
//
//        if audioRecorder?.isRecording == false{
//            stopButton.isEnabled = true
//            recordButton.isEnabled = false
//
//            var error : NSError?
//            do {
//                let player = try AVAudioPlayer(contentsOf: audioRecorder!.url)
//                 audioPlayer = player
//             } catch {
//                 print(error)
//             }
//
//            audioPlayer?.delegate = self
//
//            if let err = error{
//                print("audioPlayer error: \(err.localizedDescription)")
//            }else{
//                audioPlayer?.play()
//            }
//        }
//    }
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        recordButton.isEnabled = true
//        stopButton.isEnabled = false
//    }
//
//    private func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
//        print("Audio Play Decode Error")
//    }
//
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//    }
//
//    private func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
//        print("Audio Record Encode Error")
//    }
}

extension TrigerredWordsController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return commands.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return commands[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        commandTextField.text = commands[row]
        commandTextField.resignFirstResponder()
//        self.view.endEditing(true)
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        label.text = commands[row].description
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        view.addSubview(label)
        return view
    }
}
