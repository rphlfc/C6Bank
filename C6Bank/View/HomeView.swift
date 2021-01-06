//
//  HomeView.swift
//  C6Bank
//
//  Created by Raphael Cerqueira on 05/01/21.
//

import SwiftUI

struct HomeView: View {
    @State var opacity: Double = 0
    @State var yOffset: CGFloat = 0
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            .ignoresSafeArea(.all, edges: .all)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    GeometryReader { reader in
                        VStack {
                            HStack(spacing: 15) {
                                VStack(alignment: .leading) {
                                    Text("Bom dia")
                                        .font(.system(size: 19))
                                    
                                    Text("Raphael")
                                        .font(.system(size: 23, weight: .bold))
                                }
                                .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button(action: {}, label: {
                                    Image(systemName: "bell.fill")
                                        .font(.system(size: 21))
                                        .foregroundColor(.white)
                                })
                                
                                Button(action: {}, label: {
                                    Text("R")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17, weight: .regular))
                                        .padding(12)
                                        .background(Color.white.opacity(0.9))
                                        .clipShape(Circle())
                                })
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                HStack(spacing: 15) {
                                    CardView(content:
                                                Image("brasil")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                    .clipShape(Circle()),
                                             title: "Saldo", preValue: "R$", value: "3.200,00")
                                    
                                    CardView(content:
                                                ZStack(alignment: .topLeading) {
                                                    Text("A")
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.white)
                                                        .padding(1)
                                                    
                                                    Image(systemName: "triangle.fill")
                                                        .font(.system(size: 4))
                                                        .foregroundColor(.orange)
                                                        .rotationEffect(.init(degrees: -50))
                                                },
                                             title: "Pontos Átomos", preValue: "PTS", value: "1.100")
                                }
                                .padding(.top)
                                .padding(.horizontal)
                            })
                            .padding(.top)
                        }
                        .offset(y: -reader.frame(in: .global).minY + 44)
                        .onChange(of: reader.frame(in: .global).minY) { value in
                            let offset = value + (UIScreen.main.bounds.height / 2.5)
                            if offset < 160 {
                                if offset > 80 {
                                    let opacity = (160 - offset) / 160
                                    self.opacity = Double(opacity)
                                    return
                                }
                                self.opacity = 1
                            } else {
                                self.opacity = 0
                            }
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height / 2.5)
                    
                    BottomView()
                        .offset(y: yOffset)
                }
            })
            
            CustomNavigationView(opacity: $opacity)
        }
    }
}
    
struct CustomNavigationView: View {
    @Binding var opacity: Double
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        opacity = 0
                    }
                }, label: {
                    Image(systemName: "chevron.up")
                        .font(.system(size: 17, weight: .bold))
                })

                Spacer(minLength: 0)

                Button(action: {}, label: {
                    Text("R")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .regular))
                        .padding(12)
                        .background(Color.white.opacity(0.9))
                        .clipShape(Circle())
                })
            }
            .padding(.horizontal)
            .padding(.vertical, 8)

            Divider()
        }
        .foregroundColor(opacity > 0.6 ? .black : .white)
        .padding(.top, edges!.top)
        .background(Color.white.opacity(opacity))
        .opacity(opacity)
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct CardView<Content: View>: View {
    var content: Content
    var title: String
    var preValue: String
    var value: String
    @State var isVisible = true
    
    var body: some View {
        VStack {
            HStack {
                content
                
                Text(title)
                    .font(.system(size: 19, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.7))
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack {
                Text(preValue)
                    .font(.system(size: 19, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.7))
                
                if isVisible {
                    Text(value)
                        .font(.system(size: 19, weight: .bold))
                        .foregroundColor(Color.white)
                } else {
                    ForEach(0..<6) { _ in
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.6470008492, green: 0.6470960975, blue: 0.646979928, alpha: 1)))
                            .frame(width: 8, height: 8)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    isVisible.toggle()
                }, label: {
                    Image(systemName: isVisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.white)
                        .padding(13)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                })
            }
            .padding(.horizontal)
            
            Button(action: {}, label: {
                HStack {
                    Text("VER EXTRATO")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color.white.opacity(0.7))
                }
                .padding()
                .padding(.trailing, 30)
                .background(Color(#colorLiteral(red: 0.2431125939, green: 0.2431530058, blue: 0.243103683, alpha: 1)))
            })
        }
        .background(Color(#colorLiteral(red: 0.1411602199, green: 0.1411868036, blue: 0.1411544085, alpha: 1)))
        .frame(width: UIScreen.main.bounds.width - 60)
        .cornerRadius(15)
    }
}

struct BottomView: View {
    var body: some View {
        VStack(spacing: 15) {
            VStack {
                HStack {
                    Spacer()
                    
                    Capsule()
                        .frame(width: 70, height: 6)
                        .foregroundColor(Color(#colorLiteral(red: 0.9136454463, green: 0.9137767553, blue: 0.9136165977, alpha: 1)))
                        .padding(.vertical)
                    
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 0) {
                        ForEach(menuItems) { item in
                            MenuItemView(item: item)
                                .frame(width: 85, height: 90)
                        }
                    }
                    .padding(.horizontal)
                })
                .background(Color.white)
            }
            .background(Color.white)
            
            PraVoceView()
                .background(Color.white)
                
            PixView()
                .background(Color.white)
                
            Spacer(minLength: 30)
        }
        .background(Color(#colorLiteral(red: 0.9607002139, green: 0.9608381391, blue: 0.9606701732, alpha: 1)))
        .cornerRadius(15)
    }
}

struct MenuItemView: View {
    var item: MenuItem
    
    var body: some View {
        Button(action: {}, label: {
            VStack {
                Image(systemName: item.image)
                    .foregroundColor(Color(#colorLiteral(red: 0.2431125939, green: 0.2431530058, blue: 0.243103683, alpha: 1)))
                    .padding(12)
                    .background(Color(#colorLiteral(red: 0.9136454463, green: 0.9137767553, blue: 0.9136165977, alpha: 1)))
                    .clipShape(Circle())
                
                Spacer()
                
                Text(item.title)
                    .font(.system(size: 13))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(#colorLiteral(red: 0.2431125939, green: 0.2431530058, blue: 0.243103683, alpha: 1)))
                
                Spacer()
            }
        })
    }
}

struct PraVoceView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pra você")
                .font(.system(size: 19, weight: .medium))
                .padding(.leading)
                .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 15) {
                    PraVoceCardView(title: "Store", subtitle: "Ofertas exclusivas\nna C6 Store", description: "2x limite de crédito\n2x pontos Átomos\n3% cashback em pontos")
                    
                    PraVoceCardView(title: "Tag", subtitle: "Fila de estacionamento e\npedágio nunca mais!", description: "Com C6 Tag você só paga quando usa.\nNão tem taxa de adesão, nem\nmensalidade.")
                }
                .padding(.horizontal)
            })
            .padding(.top)
            .padding(.bottom)
        }
    }
}

struct PraVoceCardView: View {
    var title: String
    var subtitle: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text("C6")
                    .font(.system(size: 21, weight: .heavy))
                
                Text(title)
                    .font(.system(size: 20))
                
                Spacer()
            }
            
            Text(subtitle)
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 4)
            
            Text(description)
                .font(.system(size: 20))
                .padding(.top, 8)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(#colorLiteral(red: 0.1411602199, green: 0.1411868036, blue: 0.1411544085, alpha: 1)))
                        .frame(width: 40, height: 40)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8883421421, blue: 0.316564858, alpha: 1)), Color(#colorLiteral(red: 0.9998981357, green: 0.8188202977, blue: 0.1988540888, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                        .clipShape(Circle())
                })
            }
        }
        .foregroundColor(.white)
        .padding()
        .frame(width: UIScreen.main.bounds.width - 45, height: UIScreen.main.bounds.width - 100)
        .background(Color(#colorLiteral(red: 0.1411602199, green: 0.1411868036, blue: 0.1411544085, alpha: 1)))
        .cornerRadius(15)
    }
}

struct PixView: View {
    let items = [
        MenuItem(image: "dollarsign.circle", title: "PAGAR"),
        MenuItem(image: "dock.arrow.down.rectangle", title: "RECEBER"),
        MenuItem(image: "arrow.left.arrow.right", title: "TRANSFERIR"),
        MenuItem(image: "key.fill", title: "MINHAS CHAVES")
    ]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("pix")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30)
                
                Text("Pix")
                    .font(.system(size: 19, weight: .medium))
                    
                Spacer()
            }
            .padding(.top)
            
            Text("Faça um Pix agora mesmo")
                .font(.system(size: 21, weight: .regular))
                .padding(.top)
                .padding(.bottom)
            
            ForEach(items) { item in
                Button(action: {}, label: {
                    HStack {
                        Image(systemName: item.image)
                            .font(.system(size: 23, weight: .bold))
                    
                        Text(item.title)
                            .font(.system(size: 15))
                            .padding(.leading)
                    }
                })
                .buttonStyle(PlainButtonStyle())
                
                if items.last != item {
                    Divider()
                }
            }
            .padding(.top)
        }
        .padding(.vertical)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
