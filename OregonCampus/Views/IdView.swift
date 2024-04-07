//
//  IdView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/3/24.
//

import SwiftUI

struct IdView: View {
    @State private var showingImagePicker = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var image: UIImage?
    @State private var showingActionSheet = false
    @State private var showingResetConfirmation = false

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Select an Image")
            }
            Button("Select Image") {
                showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Select Image"), message: Text("Choose a source"), buttons: [
                    .default(Text("Camera")) {
                        imageSource = .camera
                        showingImagePicker = true
                    },
                    .default(Text("Photo Library")) {
                        imageSource = .photoLibrary
                        showingImagePicker = true
                    },
                    .cancel()
                ])
            }
            Button("Reset Image") {
                showingResetConfirmation = true // Show reset confirmation
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(imageSource: imageSource, selectedImage: $image)
        }
        .onAppear {
            image = ImageManager.shared.loadImage()
        }
        .onChange(of: image) { oldImage, newImage in
            if let newImage = newImage {
                _ = ImageManager.shared.saveImage(image: newImage)
            }
        }
        .alert(isPresented: $showingResetConfirmation) { // Confirmation alert
            Alert(
                title: Text("Are you sure?"),
                message: Text("Do you want to reset the image? This action cannot be undone."),
                primaryButton: .destructive(Text("Reset")) {
                    image = nil // Proceed with resetting the image
                },
                secondaryButton: .cancel()
            )
        }
    }
}

// Update ImagePicker to accept an image source
struct ImagePicker: UIViewControllerRepresentable {
    var imageSource: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = imageSource // Use the provided source type
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


#Preview {
    IdView()
}
