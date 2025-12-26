import std.process.*
import std.io.*
import std.fs.*
import std.convert.*
import std.env.*

@When[os == "Windows"]
func getPythonCommand(): String{
    if (let Some(pyCommand) <- getPythonCommandFromEnv()){
        return pyCommand
    }
    if(let Some(devecoPyCommand) <- getVariable("DEVECO_OH_NATIVE_HOME")){
        return devecoPyCommand + "/llvm/python3/bin/python3.11.exe"
    }
    throw Exception("Could not find 'python3' or 'python' in your system's PATH. Please ensure Python is installed and added to your environment variables.!")
}

@When[os != "Windows"]
func getPythonCommand(): String{
    if (let Some(pyCommand) <- getPythonCommandFromEnv()){
        return pyCommand
    }
    throw Exception("Could not find 'python3' or 'python' in your system's PATH. Please ensure Python is installed and added to your environment variables.!")
}

func getPythonCommandFromEnv():?String{
    let commands = ["python3", "python"];
    for(command in commands){
        try{
            var code = execute(command,"--version")
            if(code == 0){
                return command
            }
        }catch (e: Exception) {
            continue
        }
    }
    return None
}

main(): Int64 {
    let pyCommand: String = getPythonCommand()
    match (Process.current.arguments[0]) {
        case "pre-build" => stagePreBuild(pyCommand)
        case "post-build" => stagePostBuild(pyCommand)
        case "pre-clean" => stagePreClean(pyCommand)
        case _ => 0
    }
}

public func stagePreBuild(pyCommand:String):Int64{
    var rtnCode = execute(pyCommand,"cjpm_build.py","build","-t","release","--build-stage","preBuild")
    println("---preBuild rtnCode " + rtnCode.toString())
    return rtnCode
}

public func stagePostBuild(pyCommand:String):Int64{
    var rtnCode = execute(pyCommand,"cjpm_build.py","build","-t","release","--build-stage","postBuild","--target-lib=/usr/lib/x86_64-linux-gnu")
    println("---postBuild rtnCode " + rtnCode.toString())
    return rtnCode
}

public func stagePreClean(pyCommand:String):Int64{
    let rtnCode = execute(pyCommand,"cjpm_build.py","clean")
    return rtnCode
}

