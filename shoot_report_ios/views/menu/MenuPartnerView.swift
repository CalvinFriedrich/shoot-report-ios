import SwiftUI

struct MenuPartnerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("partner_section"))) {
                    HStack {
                        Spacer()
                        Link(destination: URL(string: "https://www.feinwerkbau.de")!) {
                            Image("adFeinbauwerk")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding()
                        Spacer()
                        
                    }
                    HStack {
                        Spacer()
                        Link(destination: URL(string: "https://www.sauer-shootingsportswear.de")!) {
                            Image("adSauer")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Link(destination: URL(string: "https://coaching-koch.de")!) {
                            Image("adKoch")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Link(destination: URL(string: "https://www.disag.de")!) {
                            Image("adDisag")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Link(destination: URL(string: "https://tec-hro.de/schiesssport")!) {
                            Image("adTechro")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Link(destination: URL(string: "https://www.kksvillingen.de")!) {
                            Image("adVerein")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding()
                        Spacer()
                    }
                }
                
                Section(header: Text(LocalizedStringKey("partner_bePartner"))) {
                    HStack {
                        Spacer()
                        Button {
                            openURL(URL(string: "https://www.burkhardt-sport.solutions/kontakt")!)
                        } label: {
                            Text(LocalizedStringKey("partner_buttonContact"))
                                .bold()
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                    }
                    .listRowBackground(Color("accentColor"))
                }
            }
            .navigationBarTitle(LocalizedStringKey("partner_thanks"))
            .navigationBarItems(
                trailing:
                    Button(LocalizedStringKey("general_close"), action: {
                        presentationMode.wrappedValue.dismiss()
                    })
            )
        }
    }
}

struct MenuPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        MenuPartnerView()
    }
}
