//
//  ContentView.swift
//  AnimationSwiftUI
//
//  Created by Sultan Rifaldy on 09/12/22.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    
    
    
    //MARK: - BODY
    var body: some View {
        ScrollView {
            
            ScalledEffecAnimatedView()
            
            LoadingView()
            
            LoadingTextView()
            
            DotLoading()
            
            RecordingView()
            
        }//SCROLLVIEW
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct ScalledEffecAnimatedView: View {
    //: PROPERTIES
    @State private var circlreColorChanged : Bool = false
    @State private var carColorChanged : Bool = false
    @State private var carSizeChanged : Bool = false
    
    let firstGradient = LinearGradient(colors: [Color.yellow, Color.blue], startPoint: .leading, endPoint: .trailing)
    let secondGradient = LinearGradient(colors: [Color.indigo, Color.pink], startPoint: .trailing, endPoint: .leading)
    
    
    
    //: BODY
    var body: some View {
        ZStack{
            Circle()
                .fill(circlreColorChanged ? firstGradient : secondGradient)
                .frame(width: 200, height: 200)
                .animation(.easeIn, value: circlreColorChanged)
            
            Image(systemName: "bolt.car.fill")
                .foregroundColor(carColorChanged ? .yellow : .white)
                .font(.system(size: 100))
                .scaleEffect(carSizeChanged ? 1.0 : 0.5)
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3), value: circlreColorChanged)
        }//ZSTACK
        .onTapGesture {
            circlreColorChanged.toggle()
            carColorChanged.toggle()
            carSizeChanged.toggle()
        }
    }
}//MARK: - SCALLED EFFECT

struct LoadingView: View {
    //: PROPERTIES
    @State private var isLoading : Bool = false
    
    
    
    //:BODY
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 100, height: 100)
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color(.purple), lineWidth: 7)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .onAppear{
                    let circlingAnimation = Animation.linear(duration: 1.0)
                    let repeatedCircle = circlingAnimation.repeatForever(autoreverses: false)
                    
                    withAnimation(repeatedCircle) {
                        isLoading = true
                    }
                }
        }//ZSTACK
        .padding()
    }
}//: LOADING VIEW

struct LoadingTextView: View {
    //: PROPERTIES
    @State private var progress : CGFloat = 0.0
    @State private var isLoadingProgress : Bool = false
    
    //: BODY
    var body: some View {
        ZStack {
            Text("\(Int(progress*100))%")
            
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 150, height: 150)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color(.blue), lineWidth: 10)
                .frame(width: 150, height: 150)
                .rotationEffect(Angle(degrees: -90 ))
                .onAppear{
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                        progress += 0.05
                        if progress >= 1.0 {
                            timer.invalidate()
                        }
                    }
                }
        }//ZSTACK
        .padding()
    }
}

struct DotLoading: View {
    //: PROPERTIES
    @State private var isDotLoading : Bool = false
    
    //: BODY
    var body: some View {
        HStack{
            ForEach (0...4, id: \.self) { item in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(.green.gradient)
                    .scaleEffect(isDotLoading ? 0 : 1)
                    .animation(.linear(duration: 0.6).repeatForever().delay(0.2 * Double(item)), value: isDotLoading)
            }//: LOOP
            .onAppear{
                isDotLoading = true
            }
        }//: HSTACK
        .padding(.vertical, 8)
    }
}

struct  RecordingView: View {
    //PROPERTIES
    
    @State private var isStop : Bool = false
    @State private var isPlay : Bool = false
    
    //BODY
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: isStop ? 30 : 5)
                .frame(width: isStop ? 60 : 250, height: 60)
                .foregroundStyle(isStop ? Color.blue.gradient : Color.red.gradient)
                .overlay {
                    Image(systemName: "mic.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .scaleEffect(isPlay ? 0.5 : 1)
                }
            RoundedRectangle (cornerRadius: isStop ? 35 : 10)
                .trim(from: 0, to: isStop ? 0.0001 : 1)
                .stroke(lineWidth: 5)
                .frame(width: isStop ? 70 : 260, height: 70)
                .foregroundColor(.red)
        }//:ZSTACK
        .padding()
        .onTapGesture {
            withAnimation(Animation.spring()){
                isStop.toggle()
            }
            withAnimation(Animation.spring().repeatForever().delay(0.5)){
                isPlay.toggle()
            }
        }
        Text("Recording...")
            .opacity(isPlay ? 0.5 : 0)
    }
}
