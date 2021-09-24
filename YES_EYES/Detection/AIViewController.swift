import UIKit
import CoreVideo
import AVFoundation

class AIViewController: UIViewController {

    @IBOutlet weak var previewView: CapturePreviewView!
    @IBOutlet weak var classifiedLabel: UILabel!
    
    let videoCapture : VideoCapture = VideoCapture()
    let context = CIContext()
    let model: Inceptionv3 = try! Inceptionv3(configuration: .init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoCapture.delegate = self

        
        if self.videoCapture.initCamera(){
            (self.previewView.layer as! AVCaptureVideoPreviewLayer).session =
                self.videoCapture.captureSession
            
            (self.previewView.layer as! AVCaptureVideoPreviewLayer).videoGravity =
                AVLayerVideoGravity.resizeAspectFill
            
            self.videoCapture.asyncStartCapturing()
        } else{
            // revise
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    func myAlert(_ title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default , handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
}

// MARK: - VideoCaptureDelegate

extension AIViewController : VideoCaptureDelegate{
    
    func onFrameCaptured(videoCapture: VideoCapture,pixelBuffer:CVPixelBuffer?,timestamp:CMTime){
        
        guard let pixelBuffer = pixelBuffer else{ return }
        
        //모델에 쓰일 이미지 준비
        guard let scaledPixelBuffer = CIImage(cvImageBuffer: pixelBuffer).resize(size: CGSize(width: 299, height: 299)).toPixelBuffer(context: context)else { return }
        
        let prediction = try? self.model.prediction(image: scaledPixelBuffer)
        
        //레이블 업데이트
        DispatchQueue.main.async {
            self.classifiedLabel.text = prediction?.classLabel ?? "이건모르겠음"
        }
        
    }
}
