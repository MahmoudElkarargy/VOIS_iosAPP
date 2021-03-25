//
//  TrigerredWordsControler.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//

import UIKit
import AVFoundation

class TrigerredWordsController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate{
    
    
    // MARK: - Properties
   
    let commands = ["money Counter", "lightness Detection", "object Detection", "text Scanner", "color Detection"]
    var pickerView = UIPickerView()
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var picker: UITextField!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var playLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioPlayer : AVAudioPlayer?
    var audioRecorder : AVAudioRecorder?

//    enum RecordingState {
//        case  recording
//        case notRecording
//    }
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(image: UIImage(named: "WhiteLogo")!)
//        stopRecordingButton.isEnabled = false
        playLabel.text = "No saved Records yet"
//        playButton.isEnabled = false
        pickerView.delegate = self
        pickerView.dataSource = self
        picker.delegate = self
        picker.inputView = pickerView
        picker.textAlignment = .center
        
        playButton.isEnabled = false
        stopButton.isEnabled = false

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

//    func  configureUI(_ recordingState: RecordingState) {
//        switch recordingState {
//        case .recording:
//        // Update the UI to reflect recording state
//            recordingLabel.text = "Recording in progress"
//            stopRecordingButton.isEnabled = true
//            recordButton.isEnabled = false
//
//            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
//            let recordingName = "recordedVoice.wav"
//            let pathArray = [dirPath, recordingName]
//            let filePath = URL(string: pathArray.joined(separator: "/"))
//
//            let session = AVAudioSession.sharedInstance()
//            try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
//            try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
//            audioRecorder.delegate = self
//            audioRecorder.isMeteringEnabled = true
//
//            audioRecorder.prepareToRecord()
//            audioRecorder.record()
//        case .notRecording:
//            // Update the UI to reflect not recording state
//            stopRecordingButton.isEnabled = false
//            recordButton.isEnabled = true
//            recordingLabel.text = "Tab to record"
//
//            audioRecorder.stop()
//            let audioSession = AVAudioSession.sharedInstance()
//            try! audioSession.setActive(false)
//        }
//    }
    
    // MARK: - Handlers
//    @IBAction func RecordAudio(_ sender: Any) {
//        configureUI(.recording)
//    }
//
//    @IBAction func StopRecording(_ sender: Any) {
//        configureUI(.notRecording)
//
//    }
//    @IBAction func playAudio(_ sender: Any) {
//
//    }
//
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if flag {
////            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
//            playButton.isEnabled = true
//            playLabel.text = "Play your Record"
//        }
//        else {
//            let controller = UIAlertController()
//            controller.title = "Error"
//            controller.message = "Please try agian"
//
//            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in self.dismiss(animated: true, completion: nil)
//            }
//
//            controller.addAction(okAction)
//            self.present(controller, animated: true, completion: nil)
//        }
//    }
    
    
    //record audio
    @IBAction func recordAudio(sender: AnyObject) {

        if audioRecorder?.isRecording == false{
            playButton.isEnabled = false
            stopButton.isEnabled = true
            audioRecorder?.record()
        }
    }
    //stop recording audio
    @IBAction func stopAudio(sender: AnyObject) {

        stopButton.isEnabled = false
        playButton.isEnabled = true
        recordButton.isEnabled = true

        if audioRecorder?.isRecording == true{
            audioRecorder?.stop()
        }else{
            audioPlayer?.stop()
        }
    }
    //play your recorded audio
    @IBAction func playAudio(sender: AnyObject) {

        if audioRecorder?.isRecording == false{
            stopButton.isEnabled = true
            recordButton.isEnabled = false

            var error : NSError?
            do {
                let player = try AVAudioPlayer(contentsOf: audioRecorder!.url)
                 audioPlayer = player
             } catch {
                 print(error)
             }

            audioPlayer?.delegate = self

            if let err = error{
                print("audioPlayer error: \(err.localizedDescription)")
            }else{
                audioPlayer?.play()
            }
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
    }

    private func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        print("Audio Play Decode Error")
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }

    private func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        print("Audio Record Encode Error")
    }
}

extension TrigerredWordsController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
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
        picker.text = commands[row]
//        picker.resignFirstResponder()
    }
}
