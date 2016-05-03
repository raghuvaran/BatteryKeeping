'he help of Freeform 3 v07-15-08
'[exit] 8Generated on Feb 09, 2014 at 11:54:41\
open "log.txt" for output as #log
t= time$("seconds")
gosub [retro]
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
    print #log, "Battery is not 100% or Fully charged"
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





print #log, "When program started time was ";timecov$(t)
open "exec.bat" for output as #bat
print #log,"opened exec.bat as #bat"
print #bat,"wmic path win32_battery get estimatedchargeremaining >D:\battinfo.txt"
print #bat,"exit"
close #bat
print #log,"printed and close #bat"
[check]
timer 0
k= time$("seconds")
print #main.time1, timecov$(k)
run "exec.bat",hide
print #log,"Ran exec.bat in hidden mode"
timer 1500,[time1]
wait
[time1]
timer 0
open "D:\battinfo.txt" for input as #char
print #log,"opened batinfo.txt as #charge"
line input #char, txt$ 
print #log,"Inputed first line"
print #log,"Ignored line is as follows:";txt$
line input #char, txt$ 
close #char
print #log,"Inputed second line"
print #log,"Saved line is as follows:";txt$
print #log,"Using word$() function we got index 1=";word$(txt$,1);" ;2=";word$(txt$,2);" ;3=";word$(txt$,3)
charge$=word$(txt$,1)+word$(txt$,2)+word$(txt$,3)
print #log,"charge$=";charge$



print #log,"close #charge"
if k<>t then
timer 1500,[time2]
wait
[time2]
timer 0
kill "D:\battinfo.txt"
print #log,"KILLED"
end if
charge=eval(charge$)
print #log,charge
print #main.chargestatic, charge$+"%."



[main.inputLoop]   'wait here for input event
    skip$="Skipped "
timer 0

if charge>=90 then goto[90]
print #log,skip$;90


if charge<=40 then
print #log,"entered charge<";40
print #main.time2,timecov$(k+1200)
timer 1200000,[check] 'wait 20 mins
wait
end if
print #log,skip$;40


if charge<=50 then
print #log,"entered charge<";50
print #main.time2,timecov$(k+600)
timer 600000,[check]  'wait 10 mins
wait
end if
print #log,skip$;50


if charge<=60 then
print #log,"entered charge<";60
print #main.time2,timecov$(k+600)
timer 600000,[check]  'wait 10 mins
wait
end if
print #log,skip$;60


if charge <=70 then
print #log,"entered charge<";70
print #main.time2,timecov$(k+600)
timer 600000, [check] 'wait 10 mins
wait
end if
              print skip$;70
if charge<90 then
print #log,"entered charge<";90
print #main.time2,timecov$(k+600)
timer 600000,[check]  'wait 10 mins
wait
end if
                            print #log, skip$;90
[90]
if charge<92 then
print #log,"entered charge<";92
print #main.time2,timecov$(k+300)
timer 300000,[check]  'wait 5 mins
wait
end if
                            print #log, skip$;92
if charge<95 then
print #log,"entered charge<";95
print #main.time2,timecov$(k+120)
timer 120000,[check]  'waitn 2 mins
wait
end if
print #log,skip$;95

timer 0
if charge>=95 then
print #log,"entered charge>=";95

run "notice.bat", hide
charged=charge
print #main.time2,timecov$(k+30)
timer 30000,[time3]
wait
[time3]
gosub [retro]
if battst=2 then
run "logoff.bat",hide
notice "Please unlplug the POWER CHORD"
print #main.time1, timecov$(k+30)
timer 0
end if
print #main.time2,timecov$(k+3630)
timer 3600000,[check]  'wait 1 hour
wait
end if


end




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
print #log, "Called for battery status"
run "battstatus.bat",hide
timer 1500,[time4]
wait
[time4]
open "D:\battstatus.txt" for input as #retro
print  #log,"opened battstatus.txt as #retro"
line input #retro, txt$ 
print  #log,"Inputed first line #retro"
print  #log,"Ignored line is as follows:";txt$
line input #retro, txt$ 
close #retro

print  #log,"Inputed second line #retro"
print  #log,"Saved line is as follows:";txt$
print  #log,"Using word$() function we got index 1=";word$(txt$,1)
battst$=word$(txt$,1)
print  #log,"battst$=";battst$
battst=eval(battst$)
kill "D:\battstatus.txt"
return
