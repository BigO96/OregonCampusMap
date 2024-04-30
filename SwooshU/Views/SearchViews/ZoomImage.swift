//
//  ZoomImage.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/27/24.
//

import SwiftUI

struct ZoomImage: View {
    var body: some View {
        VStack {
            
            Image("FentonLVL1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width - 30, height: 250)
                .cornerRadius(15)
                .addPinchZoom()
        }
        .padding()
        
    }
}

#Preview {
    ZoomImage()
}

extension View {
    func addPinchZoom() -> some View {
        return PinchZoomContext{
            self
        }
    }
    
}



struct PinchZoomContext<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: @escaping ()-> Content) {
        self.content = content()
    }
    
    @State var offset: CGPoint = .zero
    @State var scale: CGFloat = 0
    @State var scalePosition: CGPoint = .zero
    
    var body: some View {
        
        content
            .offset(x: offset.x, y: offset.y)
            .overlay(
                GeometryReader{ proxy in
                    
                    let size = proxy.size
                    
                    ZoomGesture(size: size, scale: $scale, offset: $offset, scalePosition: $scalePosition)
                }
            )
            .scaleEffect(1 + scale, anchor: .init(x: scalePosition.x, y: scalePosition.y))
            .zIndex(scale != 0 ? 1000 : 0)
            .onChange(of: scale) { newValue in
                if scale == -1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        scale = 0
                    }
                }
            }
    }
}

struct ZoomGesture: UIViewRepresentable {
    
    var size: CGSize
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    @Binding var scalePosition: CGPoint
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let Pinchgesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(sender:)))
        
        let Pangesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(sender:)))
        
        Pangesture.delegate = context.coordinator
        
        view.addGestureRecognizer(Pinchgesture)
        view.addGestureRecognizer(Pangesture)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        
        var parent: ZoomGesture
        
        init(parent: ZoomGesture) {
            self.parent = parent
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        @objc func handlePan(sender: UIPanGestureRecognizer) {
            if sender.state == .began || sender.state == .changed {
                let translation = sender.translation(in: sender.view)
                parent.offset.x += translation.x
                parent.offset.y += translation.y
                sender.setTranslation(.zero, in: sender.view)
            } else if sender.state == .ended || sender.state == .cancelled {
                withAnimation(.spring()) {
                    parent.offset = .zero
                }
            }
        }
        @objc func handlePinch(sender: UIPinchGestureRecognizer) {
            if sender.state == .began || sender.state == .changed {
                let scaleChange = sender.scale - 1
                parent.scale += scaleChange
                sender.scale = 1

                if parent.scalePosition == .zero {
                    let scalePoint = CGPoint(
                        x: sender.location(in: sender.view).x / sender.view!.frame.size.width,
                        y: sender.location(in: sender.view).y / sender.view!.frame.size.height
                    )
                    parent.scalePosition = scalePoint
                }
            } else if sender.state == .ended || sender.state == .cancelled {
                withAnimation(.spring()) {
                    parent.scale = 0
                    parent.scalePosition = .zero
                }
            }
        }
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
