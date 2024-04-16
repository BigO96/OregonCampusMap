//
//  IdView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/14/24.
//

import SwiftUI

struct IdView: View {
    @State private var showingImagePicker = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var image: UIImage?
    @State private var showingActionSheet = false
    @State private var showingResetConfirmation = false
    @State private var showingInfoSheet = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Duck ID")
                    .font(.largeTitle)
                    .padding(.top)
                
                Spacer()
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding()
                    
                    Button("Reset Image") {
                        showingResetConfirmation = true // Show reset confirmation
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                    .padding()
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "camera.viewfinder")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        Text("Here you can store your digital duck ID to get into the Student Recreation Center.")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                        Text("Simply take a photo of the barcode on the back and come back to the app when you need to scan in.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button(action: {
                            showingActionSheet = true
                        }) {
                            Text("Get Started")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                        }
                    }
                    .padding()
                    .transition(.opacity.combined(with: .scale))
                }
                
                Spacer()
            }
            .navigationBarItems(trailing: Button(action: {
                    showingInfoSheet = true
                }) {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                })
                .sheet(isPresented: $showingInfoSheet) {
                    InfoView()
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
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(imageSource: imageSource, selectedImage: $image)
            }
            .onAppear {
                image = ImageHelper.shared.loadImage()
            }
            .onChange(of: image) { _, newImage in
                if let newImage = newImage {
                    _ = ImageHelper.shared.saveImage(image: newImage)
                }
            }
            .alert(isPresented: $showingResetConfirmation) {
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
}

struct ImagePicker: UIViewControllerRepresentable {
    var imageSource: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = imageSource
        picker.allowsEditing = true // Enable the editing interface
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
            let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
            
            if let image = selectedImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}


#Preview {
    IdView()
}
