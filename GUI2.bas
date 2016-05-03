'he help of Freeform 3 v07-15-08
'GUI2
open "log.txt" for output as #log
startTime= time$("seconds")
print #log,time$();": "; "Program started at ";timecov$(startTime)
gosub [battstat]
[setup.main.Window]

    '-----Begin code for #main

    nomainwin
    WindowWidth = 550
    WindowHeight = 180
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code
    if battst=3 then
    notice "Idiot! You are over charging the battery"
        run "notice.bat"
        goto[bye]
    else
        print #log,time$();": ";"Battery is not 100% or Fully charged"
    end if
    if battst=0 then
        notice "How am I looking to you! You don't have one"
        goto[bye]
    end if



    statictext #main.statictext2, "I was last trigged at",   5,   5,  120,  20
    statictext #main.time1, timecov$(time$("seconds")), 125,   5,  60,  20
    statictext #main.statictext4, ".. then charge remaining was", 135,  47, 168,  20
    statictext #main.chargestatic, charge$+"%.", 305,  47, 100,  20
    statictext #main.statictext6, "My next trigg will be at",   5,  92, 128,  20
    statictext #main.time2, "<time2>", 140,  92,  60,  20
    button #main.button8,"How am I doing",[openlog], UL, 420,   5, 110,  25
    button #main.button9,"Go sleep babe",[exit], UL, 420,  92, 110,  25

    '-----End GUI objects code

    open "Battery keeping" for window as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"

[check]
gosub [retro]

timer 0
print #main.time1, timecov$(checkTime)
estimateTime=(100-charge)*20
    print #log,time$();": ";"Estimated trigg duration ";timecov$(estimateTime)
print #main.time2, timecov$(checkTime+estimateTime)
timer estimateTime*1000,[next]
wait
[next]
if battst=2 then
    if charge>=93 then
        print #log,time$();": ";"Into the logic >=93; charge=";charge
        run "notice.bat",hide
        if charge>=96 then
        notice "Locking PC as you didn't unplug chord"
        run "logoff.bat",hide
        end if
    end if
end if
goto [check]

[openlog]   'Perform action for the button named 'button8'
close #log
run "notepad log.txt"
open "log.txt" for append as #log
wait

[exit]
[quit.main]
close #main 'End the program
[bye]
    close #log
    end

function timecov$(tim)
    h=int(tim/3600)
    tim=tim-h*3600
    m=int(tim/60)
    tim=tim-m*60
    s=int(tim)
    t$=h;":";m;":";s
    timecov$=t$
    end function

[retro]
timer 0
checkTime= time$("seconds")
'print #main.time1, timecov$(checkTime)
run "exec.bat",hide
    print #log,time$();": ";time$;": ";"exec.bat file is executed"
timer 1500,[time1] 'delaying as it takes time to run batch file
wait
[time1]
    print #log,time$();": "; "Checking charge status"
open "D:\battinfo.txt" for input as #char
line input #char, txt$ 
line input #char, txt$ 
close #char
charge$=word$(txt$,1)+word$(txt$,2)+word$(txt$,3)
kill "D:\battinfo.txt"
charge=eval(charge$)
    print #log,time$();": ";"Charge=";charge
print #main.chargestatic, charge$+"%."

[battstat]
'-------Battery status Connected/Disconnected------
timer 0
    print #log,time$();": "; "Checking chord status"
run "battstatus.bat",hide
timer 1500,[time2] 'delaying as it takes time to run batch file
wait
[time2]
open "D:\battstatus.txt" for input as #retro
line input #retro, txt$ 
line input #retro, txt$ 
close #retro
battst$=word$(txt$,1)
    print  #log,time$();": ";"chord connected if its 2-->";battst$
battst=eval(battst$)
kill "D:\battstatus.txt"
return
