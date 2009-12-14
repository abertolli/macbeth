PROGRAM Macbeth_setup;

{
Macbeth game - setup/cheat program
Copyright (C) 2003 - Angelo Bertolli

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Angelo Bertolli <angelo.bertoli@gmail.com>

}

Uses crt;

Type
     stringtype=string[40];
     namelist=array[1..4] of stringtype;
     numlist=array[1..4] of integer;
     matrix=array[1..4,1..4] of integer;
Var

     pasfile:text;
     loop,count:integer;
     ch,ans:char;
     name:namelist;
     funds,power,morale:numlist;
     loyal:matrix;
     dosname:stringtype;

{***************************************************************************}
procedure pause;

begin
     writeln;writeln;
     write('press a key to continue...');
     ch:=readkey;
     clrscr;
end;
{---------------------------------------------------------------------------}
procedure writedat(name:namelist;funds,power,morale:numlist;var loyal:matrix;
dosname:stringtype);

begin
     assign(pasfile,dosname);
     rewrite(pasfile);
     writeln;
     for loop:=1 to 4 do
          begin
               writeln(pasfile,name[loop]);
               writeln(pasfile,funds[loop]);
               writeln(pasfile,power[loop]);
               writeln(pasfile,morale[loop]);
               for count:=1 to 4 do
                   writeln(pasfile,loyal[loop,count]);
          end;
     close(pasfile);

end;
{---------------------------------------------------------------------------}
procedure setdefaults(var name:namelist;var funds,power,morale:numlist;
var loyal:matrix);

begin
     name[1]:='Thane of the Highlands';
     name[2]:='Macbeth';
     name[3]:='Macduff';
     name[4]:='Malcolm';
     funds[2]:=2000;
     funds[3]:=800;
     funds[4]:=1200;
     funds[1]:=1000;
     power[2]:=80;
     power[3]:=50;
     power[4]:=70;
     power[1]:=20;
     morale[1]:=50;
     morale[2]:=20;
     morale[3]:=80;
     morale[4]:=60;
     loyal[1,1]:=100;
     loyal[1,2]:=0;
     loyal[1,3]:=0;
     loyal[1,4]:=0;
     loyal[2,1]:=20;
     loyal[2,2]:=100;
     loyal[2,3]:=5;
     loyal[2,4]:=5;
     loyal[3,1]:=60;
     loyal[3,2]:=5;
     loyal[3,3]:=100;
     loyal[3,4]:=90;
     loyal[4,1]:=50;
     loyal[4,2]:=10;
     loyal[4,3]:=75;
     loyal[4,4]:=100;
end;
{---------------------------------------------------------------------------}
procedure getinfo(var name:namelist;var funds,power,morale:numlist;
var loyal:matrix);

begin
     name[1]:='Thane of the Highlands';
     name[2]:='Macbeth';
     name[3]:='Macduff';
     name[4]:='Malcolm';
     repeat
          write(name[1],' funds:  ');
          readln(funds[1]);
     until(funds[1]>=0)and(funds[1]<=4000);
     repeat
          write(name[1],' power:  ');
          readln(power[1]);
     until(power[1]>=0)and(power[1]<=4000);
     repeat
          write(name[1],' morale:  ');
          readln(morale[1]);
     until(morale[1]>=0)and(morale[1]<=4000);
     loyal[1,1]:=100;
     loyal[1,2]:=0;
     loyal[1,3]:=0;
     loyal[1,4]:=0;
     for loop:=2 to 4 do
          begin
               repeat
                    write(name[loop],' funds:  ');
                    readln(funds[loop]);
               until(funds[loop]>=0)and(funds[loop]<=4000);
               repeat
                    write(name[loop],' power:  ');
                    readln(power[loop]);
               until(power[loop]>=0)and(power[loop]<=4000);
               repeat
                    write(name[loop],' morale:  ');
                    readln(morale[loop]);
               until(morale[loop]>=0)and(morale[loop]<=4000);
               for count:=1 to 4 do
                    loyal[loop,count]:=50;
          end;
end;
{===========================================================================}

Begin {main}

     clrscr;
     writeln;
     repeat
           write('(R)eset defaults or (M)ake your own:  ');
           readln(ans);
     until(ans in ['r','R','m','M']);
     if(ans in ['m','M'])then
          getinfo(name,funds,power,morale,loyal)
     else
          setdefaults(name,funds,power,morale,loyal);
     writeln;writeln;
     write('Saving ...');
     writedat(name,funds,power,morale,loyal,'info.dat');
     writeln;
     writeln('... DONE.');

     
End.
