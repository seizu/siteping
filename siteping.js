// Windows site ping script
// Run this script from the Windows command line
// tpush.bat must be in the same directory
// Usage: cscript /nologo siteping.js

var WshShell = new ActiveXObject("WScript.Shell")
var count = 5
var interval = 60
var timeout = 1000
var regexp = new RegExp('\\((0)%');
   
var site = [
            "www.google.com",1,
            "www.microsoft.com",1,
            "www.raspberrypi.org",1
           ]
            
while(1) {           
  for(var i=0;i < site.length; i+=2) {
      WScript.Echo(site[i])    
      output = cmd("ping " + site[i] + " -n 1 -w " + timeout)
      
      var match  = output.match(regexp) || 0;
      if(site[i+1] < count && match.length > 1) {
        cmd("tpush.bat \"Server '" + site[i] + "' is Up\"")
        site[i+1] = count
      } else if (site[i+1] > 0 && match == 0) {
        cmd("tpush.bat \"Server '" + site[i] + "' is Down\"")
        site[i+1]-=1
      }
  }

  WScript.Sleep(interval*1000)
}

function cmd(cmd) {
  var pid = WshShell.Exec(cmd)
  var stdstr = pid.StdOut.ReadAll()
  return stdstr
}
