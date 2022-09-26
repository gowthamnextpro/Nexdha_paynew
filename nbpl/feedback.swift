//
//  feedback.swift
//  nbpl
//
//  Created by Nexdha on 27/07/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import LocalAuthentication
import AVFAudio
import CoreData

class feedback: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    var isRed = false
    var progressBarTimer: Timer?!
    var isRunning = false
    var final_urls: String!
    @IBOutlet weak var get_text: UITextField!
    @IBOutlet weak var Recorder: UIStackView!
    @IBOutlet weak var back_btn: UIImageView!
    @IBOutlet weak var progress_bar: UIProgressView!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var soundnote_title_label: UILabel!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var record: UIButton!
    var soundsNoteID: String!        // populated from incoming seque
    var soundsNoteTitle: String!     // populated from incoming seque
    var soundURL: String!            // store in CoreData
    @IBOutlet weak var sound_record_label: UILabel!
    var audioRecorder:AVAudioRecorder?
    var audioPlayer:AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
      //  progress_bar.progress = 0.0
        checkMicrophoneAccess()
      
        btn_save.new_grad(colors: [UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor, UIColor.magenta.cgColor])    //  saveButtonOutlet.isEnabled = false
     // self.navigationController?.navigationBar.tintColor = .white
    //  soundTitleTextField.delegate = self
             //   soundnote_title_label.text = soundsNoteTitle
             //   soundSaveConfirmationLabel.alpha = 0
                // Disable Stop/Play button when application launches
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        back_btn.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.recorders(_:)))
        Recorder.addGestureRecognizer(tap1)
        stop.isEnabled = false
        play.isEnabled = false
        let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
            FileManager.SearchPathDomainMask.userDomainMask).first // as! NSURL
        let audioFileName = UUID().uuidString + ".m4a"
        let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
        soundURL = audioFileName       // Sound URL to be stored in CoreData
        let audioSession = AVAudioSession.sharedInstance()
        do {
           // try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)), mode: .default)   // old code 
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [])
        } catch _ {
        }
       let recorderSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC as UInt32),
                              AVSampleRateKey: 44100.0,
                              AVNumberOfChannelsKey: 2 ]
       audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
       audioRecorder?.delegate = self
       audioRecorder?.isMeteringEnabled = true
       audioRecorder?.prepareToRecord()
       sound_record_label.text = "Ready to Record"
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /* @objc func updateProgressView(){
        progress_bar.progress += 0.1
        progress_bar.setProgress(progress_bar.progress, animated: true)
        if(progress_bar.progress == 1.0)
        {
            progressBarTimer.invalidate()
            isRunning = false
           // btn.setTitle("Start", for: .normal)
        }
    }*/
    @objc func recorders(_ sender: UITapGestureRecognizer? = nil) {
        sound_record_label.text = ""
                // Stop the audio player before recording
        let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
            FileManager.SearchPathDomainMask.userDomainMask).first // as! NSURL
        let audioFileName = UUID().uuidString + ".m4a"
        let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
        soundURL = audioFileName
      //  let videoData = try Data(contentsOf: audioFileURL)
// Sound URL to be stored in CoreData
       // try videoData.write(to: audioFileURL)
        print(audioFileName)
        let audioSession = AVAudioSession.sharedInstance()
        do {
           // try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)), mode: .default)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [])
        } catch _ {
        }
       let recorderSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC as UInt32),
                              AVSampleRateKey: 44100.0,
                              AVNumberOfChannelsKey: 2 ]
        
       audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
       audioRecorder?.delegate = self
       audioRecorder?.isMeteringEnabled = true
       audioRecorder?.prepareToRecord()
       sound_record_label.text = "Ready to Record"
                if let player = audioPlayer {
                    if player.isPlaying {
                        player.stop()
                        play.setImage(UIImage(named: "Play-Jolly"), for: UIControl.State())
                        play.isSelected = false
                    }
                }
                if let recorder = audioRecorder {
                    if !recorder.isRecording {
                        let audioSession = AVAudioSession.sharedInstance()
                        
                        do {
                            try audioSession.setActive(true)
                        } catch _ {
                        }
                        // Start recording
                        recorder.record()
                        sound_record_label.text = "Recording .."
                        record.setImage(UIImage(named: "accept"), for: UIControl.State.selected)
                        stop.setImage(UIImage(named: "Stop-Jolly"), for: UIControl.State())
                        play.setImage(UIImage(named: "Play-Outlined"), for: UIControl.State())
                        record.isSelected = true
                        stop.isEnabled = true
                        play.isEnabled = false
                    } else {
                        // Pause recording
                        recorder.pause()
                        sound_record_label.text = "Paused!"
                        record.setImage(UIImage(named: "Microphone-Pause"), for: UIControl.State())
                        play.setImage(UIImage(named: "Play-Outlined"), for: UIControl.State.selected)
                        stop.setImage(UIImage(named: "Stop-Outlined"), for: UIControl.State())
                        stop.isEnabled = false
                        play.isEnabled = false
                        record.isSelected = false
                    }
                }
    }
    @IBAction func recorder(_ sender: Any) {
       
                if let player = audioPlayer {
                    if player.isPlaying {
                        player.stop()
                        play.setImage(UIImage(named: "Play-Jolly"), for: UIControl.State())
                        play.isSelected = false
                    }
                }
                if let recorder = audioRecorder {
                    if !recorder.isRecording {
                        let audioSession = AVAudioSession.sharedInstance()
                        
                        do {
                            try audioSession.setActive(true)
                        } catch _ {
                        }
                        // Start recording
                        recorder.record()
                        sound_record_label.text = "Recording .."
                        record.setImage(UIImage(named: "accept"), for: UIControl.State.selected)
                        stop.setImage(UIImage(named: "Stop-Jolly"), for: UIControl.State())
                        play.setImage(UIImage(named: "Play-Outlined"), for: UIControl.State())
                        record.isSelected = true
                        stop.isEnabled = true
                        play.isEnabled = false
                    } else {
                        // Pause recording
                        recorder.pause()
                        sound_record_label.text = "Paused!"
                        record.setImage(UIImage(named: "Microphone-Pause"), for: UIControl.State())
                        play.setImage(UIImage(named: "Play-Outlined"), for: UIControl.State.selected)
                        stop.setImage(UIImage(named: "Stop-Outlined"), for: UIControl.State())
                        stop.isEnabled = false
                        play.isEnabled = false
                        record.isSelected = false
                    }
                }
    }
    @IBAction func stop(_ sender: Any) {
              sound_record_label.text = "Stopped!"
              record.setImage(UIImage(named: "Microphone-Jolly"), for: UIControl.State())
              play.setImage(UIImage(named: "Play-Jolly"), for: UIControl.State())
              stop.setImage(UIImage(named: "Stop-Outlined"), for: UIControl.State())
              record.isSelected = false
              play.isSelected = false
              stop.isEnabled = false
              play.isEnabled = true
              record.isEnabled = true
              if let recorder = audioRecorder {
                  if recorder.isRecording {
                      audioRecorder?.stop()
                      let audioSession = AVAudioSession.sharedInstance()
                      do {
                          try audioSession.setActive(false)
                      } catch _ {
                      }
                  }
              }
              // Stop the audio player if playing
              if let player = audioPlayer {
                  if player.isPlaying {
                      player.stop()
                  }
              }
    }
    func getDirectory() -> URL
        {
            sound_record_label.text = ""
                    // Stop the audio player before recording
            let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
                FileManager.SearchPathDomainMask.userDomainMask).first // as! NSURL
            let audioFileName = UUID().uuidString + ".m4a"
            let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
         //   soundURL = audioFileURL
            print(audioFileURL)
          //  final_urls = audioFileName// Sound URL to be stored in CoreData
            let audioSession = AVAudioSession.sharedInstance()
            do {
               // try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)), mode: .default)
                try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [])
            } catch _ {
            }
           let recorderSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC as UInt32),
                                  AVSampleRateKey: 44100.0,
                                  AVNumberOfChannelsKey: 2 ]
           audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
           audioRecorder?.delegate = self
           audioRecorder?.isMeteringEnabled = true
           audioRecorder?.prepareToRecord()
           sound_record_label.text = "Ready to Record"
           print("CR")
           print(audioFileURL)
           print("ROI")
           print("A23")
           print(audioRecorder)
           print("A24")
            //let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                //  let documentDirectory = paths[0]
                //  return documentDirectory
           return audioFileURL
        }
    @IBAction func saving(_ sender: Any) {
   /*           let soundsContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
              
              let sound = NSEntityDescription.insertNewObject(forEntityName: "Sounds", into: soundsContext) as! Sounds
              
              sound.noteID = soundsNoteID         // V2.0
              sound.noteTitle = soundsNoteTitle
              sound.noteSoundURL = soundURL
              
              var noteSoundTitle:String = "Sound " + Common().stringCurrentDate()
              
              if (sound_record_label.text?.isEmpty)! {
                  noteSoundTitle = "Sound " + Common().stringCurrentDate()
                  sound_record_label.text = noteSoundTitle
              } else {
                  noteSoundTitle =  sound_record_label.text!
              }
              
              sound.noteSoundTitle =  noteSoundTitle
              do {
                  try soundsContext.save()
              } catch _ {
              }
              print(sound_record_label)
          //    soundSaveConfirmationLabel.alpha = 1
          //    soundSaveConfirmationLabel.text = "Saved " + noteSoundTitle
          //    soundSaveConfirmationLabel.adjustsFontSizeToFitWidth = true
          //    soundTitleTextField.text = ""
              // Set the audio recorder ready to record the next audio with a unique audioFileName
              let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
                  FileManager.SearchPathDomainMask.userDomainMask).first // as! NSURL
              let audioFileName = UUID().uuidString + ".m4a"
              let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
              soundURL = audioFileName       // Sound URL to be stored in CoreData
              
              // Setup audio session
              let audioSession = AVAudioSession.sharedInstance()
              do {
                  try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)), mode: .default)
              } catch _ {
              }
              
              // Define the recorder setting
              let recorderSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC as UInt32),
                                     AVSampleRateKey: 44100.0,
                                     AVNumberOfChannelsKey: 2 ]
              
              audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
              audioRecorder?.delegate = self
              audioRecorder?.isMeteringEnabled = true
              audioRecorder?.prepareToRecord()
              
        sound_record_label.text = "Ready to Record"
              
              play.isEnabled = false
              stop.isEnabled = false
              btn_save.isEnabled = false
              play.setImage(UIImage(named: "Play-Outlined"), for: UIControl.State())
              */
        // Define the recorder setting
        
        
        
     /*         let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
                  FileManager.SearchPathDomainMask.userDomainMask).first // as! NSURL
              print(directoryURL)
              let audioFileName = UUID().uuidString + ".m4a"
              let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
            //  soundURL = audioFileURL       // Sound URL to be stored in CoreData
              // Setup audio session
              print("A!@#$%^&*()")
              print(audioFileURL)
              print("hashmismatch")
              let audioSession = AVAudioSession.sharedInstance()
              do {
                 // try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)), mode: .default)
                  try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [])
                //  try! AVAudioSession.sharedInstance().setCategory(.playback)
              } catch _ {
              }
             let recorderSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC as UInt32),
                                    AVSampleRateKey: 44100.0,
                                    AVNumberOfChannelsKey: 2 ]
             audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
             audioRecorder?.delegate = self
             audioRecorder?.isMeteringEnabled = true
             audioRecorder?.prepareToRecord()
             sound_record_label.text = "Ready to Record"*/
        print("John cc0")
        print(getDirectory())
        print("John ccsss1")
        fileupload()
}
    

    @IBAction func played(_ sender: Any) {
     /*   if(isRunning){
            progressBarTimer.invalidate()
          //  btn.setTitle("Start", for: .normal)
        }
        else{
        //btn.setTitle("Stop", for: .normal)
            progress_bar.progress = 0.0
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(feedback.updateProgressView), userInfo: nil, repeats: true)
        if(isRed){
            progress_bar.progressTintColor = UIColor.blue
            progress_bar.progressViewStyle = .default
        }
        else{
            progress_bar.progressTintColor = UIColor.red
            progress_bar.progressViewStyle = .bar
            
        }
        isRed = !isRed
        }
        isRunning = !isRunning*/
              if let recorder = audioRecorder {
                  if !recorder.isRecording {
                      try! AVAudioSession.sharedInstance().setCategory(.playback)
                      print("john")
                      print(try! AVAudioSession.sharedInstance().setCategory(.playback))
                      print("bruto")
                      audioPlayer = try? AVAudioPlayer(contentsOf: recorder.url)
                      audioPlayer?.delegate = self
                      audioPlayer?.play()
                      play.setImage(UIImage(named: "Play-Outlined"), for: UIControl.State.selected)
                      play.isSelected = true
                      stop.isEnabled = true
                      sound_record_label.text = "Playing .."
                      stop.setImage(UIImage(named: "Stop-Jolly"), for: UIControl.State())
                      record.setImage(UIImage(named: "Microphone-Outlined"), for: UIControl.State())
                      record.isEnabled = false
                      print(recorder)
                  }
              }
    }
    // Microphone Access
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
         if flag {
             print("G5")
             sound_record_label.text = "Recording Completed"
             print("G6")
             record.setImage(UIImage(named: "Microphone-Jolly"), for: UIControl.State())
             play.setImage(UIImage(named: "Play-Jolly"), for: UIControl.State())
             stop.setImage(UIImage(named: "Stop-Outlined"), for: UIControl.State())
             record.isEnabled = true
             play.isEnabled = true
             stop.isEnabled = false
         }
     }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
         sound_record_label.text = "Playing Completed"
         record.setImage(UIImage(named: "Microphone-Jolly"), for: UIControl.State())
         play.setImage(UIImage(named: "Play-Jolly"), for: UIControl.State())
         stop.setImage(UIImage(named: "Stop-Outlined"), for: UIControl.State())
         play.isSelected = false
         stop.isEnabled = false
         record.isEnabled = true
     }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    public func fileupload(){
    //    self.Toast12(Title: "Please Wait....", Text: "", delay: 2)
   //  let url = URL(string: "file:///var/mobile/Containers/Data/Application/AE7E7262-A217-42E4-AFD6-BD8FC882AD5A/Documents/4B4388C6-B49E-47A7-A156-71D4E68C6C5A.m4a")!
      let headers: HTTPHeaders = [
             .authorization(UserDefaults.standard.object(forKey: "token") as! String)
          ]
   //   final_urls = "file:///var/mobile/Containers/Data/Application/154CC2D8-82D3-43F9-B7F3-8A8A6FE193E9/Documents/D0387AB8-E64D-400C-88A5-CEFE21CE7544.m4a"

        let voiceData = try? Data(contentsOf: getDirectory())
      //  var url = NSURL.fileURLWithPath(voiceData as String)

        print("APPLE")
        print(voiceData)
        print("ORANGE")
        let parameters = ["os": "iOS" , "type" : "audio" , "text" : "null" ,
        ]
      //  "audio" :
              //              ""////audio send  text to null and text send audio to null
        AF.upload(
              multipartFormData: { (multipartForm) in
                  for (key, value) in parameters {
                      multipartForm.append(value.data(using: String.Encoding.utf8)!, withName: key)
                  }
                  multipartForm.append(voiceData!, withName: "audio", fileName: "john1.m4a" , mimeType: "audio/mpeg")
          },
                  to: AppDelegate.Nexdha_student.server+"/api/feedback", method: .post  ,headers: headers)
                  .responseJSON { response in
                        debugPrint("Resssssssssss")
                        debugPrint(response)
                        switch response.result{
                                      case .success(let value):
                                          let json = JSON(value)
                                          print(json)
                                          let status = json["status"].stringValue
                                          /*
                                          if status == "Success"{
                                            let alertController = UIAlertController(title: "Upload Success", message:
                                                                                                        "We will verify KYC and update you soon.", preferredStyle: .alert)
                                            alertController.addAction(UIAlertAction(title: "Close", style: .default,handler: self.alertaction(_:)))
                                            self.present(alertController, animated: true, completion: nil)
                                          }else{
                                            let alertController = UIAlertController(title: "Upload Failed", message:
                                                                                                        "There was an error during upload. Please try again or contact support.", preferredStyle: .alert)
                                            alertController.addAction(UIAlertAction(title: "Close", style: .default,handler: self.alertaction(_:)))
                                            self.present(alertController, animated: true, completion: nil)
                                          }*/
                                      case.failure(let error):
                                          print(error)
                                      }
                  
                           }
    }
     func checkMicrophoneAccess() {
         // Check Microphone Authorization
         switch AVAudioSession.sharedInstance().recordPermission {
         case AVAudioSession.RecordPermission.granted:
             print(#function, " Microphone Permission Granted")
             break
         case AVAudioSession.RecordPermission.denied:
             // Dismiss Keyboard (on UIView level, without reference to a specific text field)
          /*   UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
             
             let alertVC = PMAlertController(title: "Microphone Error!", description: "8Code is Not Authorized to Access the Microphone!", image: UIImage(named: "MicrophoneX"), style: .alert)
             
             // Left hand option (default color in PMAlertAction.swift)
             alertVC.addAction(PMAlertAction(title: "Settings", style: .default, action: { () in
                 
                 DispatchQueue.main.async {
                     if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                         UIApplication.shared.open(settingsURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                     }
                 } // end dispatchQueue
                 
             }))
             // Right hand option (default color grey)
             alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel))
             self.present(alertVC, animated: true, completion: nil)*/
             //   self.handleDismiss()
                let alertController = UIAlertController (title: "Permission denied", message: "Nexdha pay does not have permission to access you Microphone.please go to settings and enable it", preferredStyle: .alert)
                   let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                       guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                           return
                       }
                       if UIApplication.shared.canOpenURL(settingsUrl) {
                           UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                               print("Settings opened: \(success)") // Prints true
                               if(success == true){
                                   self.performSegue(withIdentifier: "scans", sender: nil)
                               }
                               else{
                                   let alertController = UIAlertController (title: "Permission denied", message: "Nexdha pay does not have permission to access you Microphone.please go to settings and enable it", preferredStyle: .alert)
                                   alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
                                      }))
                                      self.present(alertController, animated: true, completion: nil)
                               }
                           })
                       }
                   }
                   alertController.addAction(settingsAction)
                   let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                   alertController.addAction(cancelAction)
                   print(cancelAction)
                   self.present(alertController, animated: true, completion: nil)
             return
         case AVAudioSession.RecordPermission.undetermined:
             print("Request permission here")
             // Dismiss Keyboard (on UIView level, without reference to a specific text field)
             UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
             AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                 // Handle granted
                 if granted {
                     print(#function, " Now Granted")
                 } else {
                     print("Pemission Not Granted")
                     
                 } // end else
             })
         @unknown default:
             print("ERROR! Unknown Default. Check!")
         } // end switch
     }
}
    
