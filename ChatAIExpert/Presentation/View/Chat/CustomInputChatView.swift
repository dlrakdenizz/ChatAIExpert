//
//  CustomInputChatView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI
import PhotosUI

struct CustomInputChatView: View {
    
    @Binding var text : String
    var action : () -> Void
    let chatbot : Chatbots
    @Binding var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isCameraPresented = false
    @State private var showImageSourceMenu = false
    @State private var isAddViewExpanded = false
    @ObservedObject var viewModel: ChatViewModel
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundStyle(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
            
            HStack{
                AddView(isImagePickerPresented: $isImagePickerPresented, isCameraPresented: $isCameraPresented)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 2) {
                    TextField("\(NSLocalizedString("Ask to ", comment: "")) \(chatbot.title)...", text: $text, axis: .vertical)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.body)
                        .frame(minHeight: 30)
                        .focused($isTextFieldFocused)
                        .onChange(of: text) { newValue in
                            if newValue.count > 300 {
                                text = String(newValue.prefix(300))
                            }
                        }
                    
                    if text.count > 0 {
                        Text("\(text.count)/300")
                            .font(.caption2)
                            .foregroundColor(text.count > 290 ? .red : .gray)
                            .padding(.leading, 4)
                    }
                }
                
                Button(action: {
                    action()
                    text = ""
                    isTextFieldFocused = false
                }, label: {
                    Text(NSLocalizedString("Send", comment: ""))
                        .bold()
                        .foregroundStyle(viewModel.isResponding ? Color.gray : Color.black)
                })
                .disabled(viewModel.isResponding)
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
            
            if let selectedImage = selectedImage {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button(action: {
                        self.selectedImage = nil
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 28))
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 32, height: 32)
                            )
                            .padding(8)
                    }
                }
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .sheet(isPresented: $isCameraPresented) {
            CameraView(selectedImage: $selectedImage)
        }
    }
}


