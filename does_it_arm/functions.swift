//
//  functions.swift
//  does_it_arm
//
//  Created by Michele Marcucci on 21/04/21.
//

import Foundation

func comando(arg: String) -> String {
    let task = Process()
    task.launchPath = "/bin/zsh"
    task.arguments = ["-c", arg]
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)
    task.waitUntilExit()
    return output!
}

func getdir() -> [String] {
    var apps: [String] = []
    let str = comando(arg: "ls /Applications/")
    let c = str.components(separatedBy: "\n")
    
    for x in c{
        var x = x.replacingOccurrences(of: ".app", with: "")
        x = x.replacingOccurrences(of: ".localized", with: "")
        apps.append(x)
    }
    return apps
}

func getresult(arg: String) -> [String]{
    var res = ""
    var name = arg
    var output = ""
    var realExecName = ""
    var title = ""
    name = name.replacingOccurrences(of: " ", with: "\\ ")
    
    realExecName = comando(arg: "ls /Applications/\(name).app/Contents/MacOS/")
    if(realExecName == ""){
        realExecName = comando(arg: "ls /Applications/\(name).localized/Contents/MacOS/")
    }
    realExecName = realExecName.replacingOccurrences(of: " ", with: "\\ ")
    
    output = comando(arg: "file /Applications/\(name).app/Contents/MacOS/\(realExecName)")
    if(output == ""){
        output = comando(arg: "file /Applications/\(name).localized/Contents/MacOS/\(realExecName)")
    }
    //output = comando(arg: "file /Applications/\(name).localized/Contents/MacOS/\(name)")
    if(output.contains("universal")){
        res = "Universal app"
        title = "Universal! 🚀"
        
        
    }
    if(output.contains("x86_64") && !output.contains("arm64")){
        res = "App Intel x86_64"
        title = "Works on Rosetta2! 🪦 "
    }
    if(!output.contains("x86_64") && output.contains("arm64")){
        res = "App arm64"
        title = "Pure arm! 💣"
    }
    
    return [res, title]
}


func setTitle(arg: String) -> String{
    if(arg == ""){
        return "Does it Arm?"
    }
    else{
        return arg
    }
}
