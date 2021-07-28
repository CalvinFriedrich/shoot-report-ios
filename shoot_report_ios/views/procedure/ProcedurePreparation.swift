import SwiftUI

struct ProcedurePreparation: View {
    
    @State var before: String = ""
    
    var rifle: Rifle
    
    var body: some View {
        Form {
            Section(header:
                        Text(LocalizedStringKey("procedure_before_section"))
                        .foregroundColor(Color("accentColor"))
                        .bold()
                        .textCase(nil)) {
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey("procedure_before_title"))
                    TextEditor(text: $before)
                        .onChange(of: before) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "procedure_before_\(rifle.pref)")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                        .ignoresSafeArea(.keyboard)
                    
                }
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear(perform: {
            self.before = UserDefaults.standard.string(forKey: "procedure_before_\(rifle.pref)") ?? ""
        })
    }
}

struct ProcedurePreparation_Previews: PreviewProvider {
    static var previews: some View {
        ProcedurePreparation(rifle: Rifle())
    }
}
