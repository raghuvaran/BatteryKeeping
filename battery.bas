cls
t= time$("seconds")
open "notice.bat" for output as #not
print #not, "D:\unplug.jpg"
close #not
print "closed #not"
open "exec.bat" for output as #bat
print"opened exec.bat as #bat"
print #bat,"wmic path win32_battery get estimatedchargeremaining >D:\battinfo.txt"
print #bat,"exit"
close #bat
print "printed and close #bat"

[check]
timer 0
k= time$("seconds")
run "exec.bat",hide
print "Ran exec.bat in hidden mode"

timer 1500,[go]
wait
[go]
timer 0

open "D:\battinfo.txt" for input as #char
print "opened batinfo.txt as #charge"
line input #char, txt$ 
print "Inputed first line"
print "Ignored line is as follows:";txt$
line input #char, txt$ 
close #char
print "Inputed second line"
print "Saved line is as follows:";txt$
print "Using word$() function we got index 1=";word$(txt$,1);" ;2=";word$(txt$,2);" ;3=";word$(txt$,3)
charge$=word$(txt$,1)+word$(txt$,2)+word$(txt$,3)
print "charge$=";charge$



print "close #charge"
if k<>t then
timer 1500,[go2]
wait
[go2]
timer 0
kill "D:\battinfo.txt"
print "KILLED"
end if
charge=eval(charge$)
print charge




skip$="Skipped "
timer 0

if charge>=90 then goto[90]
print skip$;90


if charge<=40 then
print "entered charge<";40
timer 1200000,[check] 'wait 20 mins
wait
end if
print skip$;40


if charge<=50 then
print "entered charge<";50
timer 600000,[check]  'wait 10 mins
wait
end if
print skip$;50


if charge<=60 then
print "entered charge<";60
timer 600000,[check]  'wait 10 mins
wait
end if
print skip$;60


if charge <=70 then
print "entered charge<";70
timer 600000, [check] 'wait 10 mins
wait
end if
              print skip$;70
if charge<90 then
print "entered charge<";90
timer 600000,[check]  'wait 10 mins
wait
end if
                            print skip$;90
[90]
if charge<92 then
print "entered charge<";92
timer 300000,[check]  'wait 5 mins
wait
end if
                                          print skip$;92
if charge<95 then
print "entered charge<";95
timer 120000,[check]  'waitn 2 mins
wait
end if
print skip$;95

timer 0
if charge>=95 then
print "entered charge>=";95
run "notice.bat", hide
notice "Please unlplug the POWER CHORD"
charged=charge

timer 3600000,[check]  'wait 1 hour
wait
end if


end




