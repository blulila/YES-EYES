//
//  CUSearchViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/29.
//

import UIKit
import FirebaseDatabase
import Speech


class CUSearchViewController: UIViewController, SFSpeechRecognizerDelegate {
    @IBOutlet weak var searchBarContainerView: UIView!
    @IBOutlet weak var speechbutton: UIButton!
    
    private var cuSearchViewController: CUSearchViewController?
    private var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupNavigationBarTitle()
        speechRecognizer?.delegate = self
    }

    private func setupNavigationBarTitle() {
        title = "상품 검색"
    }
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
        
    @IBAction func speechToText(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            speechbutton.isEnabled = false
            speechbutton.setTitle("음성 녹음", for: .normal)
        } else {
            startRecording()
            speechbutton.setTitle("녹음 중지", for: .normal)
        }
    }

    @IBOutlet weak var cuTextView: UITextView!
    
    func startRecording() {
            
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("ERROR")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode;
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("ERROR")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                self.cuTextView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.speechbutton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("ERROR")
        }
        cuTextView.text = "음성 녹음을 켜 원하시는 상품을 말씀하세요."
    }
   
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            speechbutton.isEnabled = true
        } else {
            speechbutton.isEnabled = false
        }
    }
}

extension CUSearchViewController {
    private func setupSearchBar() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "검색 창"
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.frame = searchBarContainerView.bounds
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchBarContainerView.addSubview(searchController.searchBar)
        definesPresentationContext = true
    }
}

extension CUSearchViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }
}

extension CUSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
        print(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
    }
}

