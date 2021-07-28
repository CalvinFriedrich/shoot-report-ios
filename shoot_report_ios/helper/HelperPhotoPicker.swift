import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var pickerResult: [UIImage]
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        
        // TODO Fix the colors
        // Set the colors
        //let barApperance = UINavigationBar.appearance()
        //barApperance.tintColor = UIColor(Color("mainColor"))
        //barApperance.backgroundColor = UIColor(Color("mainColor"))
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { (newImage, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.parent.pickerResult = []
                            self.parent.pickerResult.append(newImage as! UIImage)
                        }
                    }
                }
            }
            
            // dismiss the picker
            parent.isPresented = false
        }
    }
}
