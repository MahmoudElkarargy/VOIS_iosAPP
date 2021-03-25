//
//  TrigerredWordsControler.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//

import UIKit
import AVFoundation

class TrigerredWordsController: UIViewController, AVAudioRecorderDelegate{
    
    
    // MARK: - Properties
   
    let commands = ["money Counter", "lightness Detection", "object Detection", "text Scanner", "color Detection"]
    var pickerView = UIPickerView()
    
    @IBOutlet weak var picker: UITextField!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!

    enum RecordingState {
        case  recording
        case notRecording
    }
    // MARK: - Init
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        self.setupNavigationBar(image: UIImage(named: "WhiteLogo")!)
        stopRecordingButton.isEnabled = false
        pickerView.delegate = self
        pickerView.dataSource = self
        picker.delegate = self
        picker.inputView = pickerView
        picker.textAlignment = .center
    }

    func  configureUI(_ recordingState: RecordingState) {
        switch recordingState {
        case .recording:
        // Update the UI to reflect recording state
            recordingLabel.text = "Recording in progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = URL(string: pathArray.joined(separator: "/"))
            
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        case .notRecording:
            // Update the UI to reflect not recording state
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
            recordingLabel.text = "Tab to record"
            
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            try! audioSession.setActive(false)
        }
    }
    // MARK: - Handlers
    @IBAction func RecordAudio(_ sender: Any) {
        configureUI(.recording)
    }
    
    @IBAction func StopRecording(_ sender: Any) {
        configureUI(.notRecording)

    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
//            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            let controller = UIAlertController()
            controller.title = "Error"
            controller.message = "Please try agian"
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in self.dismiss(animated: true, completion: nil)
            }
            
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
        }
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
