[retro]
run "battstatus.bat",hide
open "battstatus.txt" for input as #retro
print #log,"opened battstatus.txt as #retro"
line input #retro, txt$ 
print #log,"Inputed first line"
print #log,"Ignored line is as follows:";txt$
line input #retro, txt$ 
close #retro
print #log,"Inputed second line"
print #log,"Saved line is as follows:";txt$
print #log,"Using word$() function we got index 1=";word$(txt$,1);" ;2=";word$(txt$,2);" ;3=";word$(txt$,3)
battst$=word$(txt$,1)+word$(txt$,2)+word$(txt$,3)
print #log,"battst$=";battst$

