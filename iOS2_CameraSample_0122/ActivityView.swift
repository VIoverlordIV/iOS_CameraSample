
import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    let shareItems: [Any]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
