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
    @Binding var selectedImage: [UIImage]
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
                    TextField("\(localized("Ask to ")) \(chatbot.title)...", text: $text, axis: .vertical)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.body)
                        .frame(minHeight: 30)
                        .focused($isTextFieldFocused)
                        .onChange(of: text) { newValue in
                            if newValue.count > 1000 {
                                text = String(newValue.prefix(300))
                            }
                        }
                    
                    if text.count > 0 {
                        Text("\(text.count)/1000")
                            .font(.caption2)
                            .foregroundColor(text.count > 990 ? .red : .gray)
                            .padding(.leading, 4)
                    }
                }
                
                Button(action: {
                    action()
                    text = ""
                    isTextFieldFocused = false
                }, label: {
                    Text(localized("Send"))
                        .bold()
                        .foregroundStyle(viewModel.isResponding ? Color.gray : Color.black)
                })
                .disabled(viewModel.isResponding)
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
            
            if !selectedImage.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(selectedImage, id: \.self) { img in
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Button(action: {
                                    // Bu resmi diziden kaldır
                                    if let index = selectedImage.firstIndex(of: img) {
                                        selectedImage.remove(at: index)
                                    }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.black)
                                        .background(Circle().fill(Color.white))
                                        .font(.title2)
                                }
                                .padding(4)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 90)
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .sheet(isPresented: $isCameraPresented) {
            CameraView(selectedImage: .init(get: { nil }, set: { image in
                if let image = image {
                    selectedImage.append(image)
                }
            }))
        }
    }
}


