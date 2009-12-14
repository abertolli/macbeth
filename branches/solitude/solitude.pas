PROGRAM Solitude;

{
Solitude game, text version
Copyright (C) 2007 - Jefferey Querner
}

USES crt;

CONST

   screenlines      = 21;

   black            = 0;
   darkblue         = 1;
   darkgreen        = 2;
   darkcyan         = 3;
   darkred          = 4;
   darkmagenta      = 5;
   darkyellow       = 6;
   lightgray        = 7;
   darkgray         = 8;
   blue             = 9;
   green            = 10;
   cyan             = 11;
   red              = 12;
   magenta          = 13;
   yellow           = 14;
   white            = 15;

   defaultcolor     = lightgray;
   promptcolor      = white;
   statscolor       = darkgray;
   titlecolor       = darkred;
   creditcolor      = darkmagenta;
   introcolor       = darkyellow;
   attackcolor      = red;
   endingcolor      = blue;

   textfile         = 'text.txt';
   datafile         = 'info.dat';

TYPE

   namelist         = array[1..4] of string;
   numlist          = array[1..4] of integer;
   list             = array[1..4] of boolean;
   matrix           = array[1..4,1..4] of integer;

VAR

     name            : namelist;
     funds,
     power,
     morale          : numlist;
     loyal           : matrix;
     moscoteend,
     gameover        : boolean;
     theword         : string;
     cost            : integer;
     alive           : list;
     num             : integer;

{---------------------------------------------------------------------------}
procedure lowbeep;

begin
     sound(262);delay(400);nosound;
end;
{---------------------------------------------------------------------------}
procedure prompt;

var
   ch     :char;

begin
   writeln;
   writeln('press any key to continue...');
   ch:=readkey;
   writeln;
end;
{---------------------------------------------------------------------------}
function d(dnum:integer):integer;

begin
   d:=random(dnum)+1;
end;
{---------------------------------------------------------------------------}
function randomcolor:integer;

begin
   randomcolor:=random(6)+9;
end;
{---------------------------------------------------------------------------}
procedure screentext(textname:string);

var
   control     : integer;
   lineoftext  : string;
   pasfile     : text;

begin
   textname:='~'+textname;
   assign(pasfile,textfile);
   reset(pasfile);
   control:=0;
   While not((eof(pasfile))or(pos(textname,lineoftext)=1)) DO
      readln(pasfile,lineoftext);

   if not(pos(textname,lineoftext)=1) then
      begin
         writeln;
         writeln('ERROR: ',textname,' not found in ',textfile);
         prompt;
      end
   else
      repeat
         control:=control+1;
         readln(pasfile,lineoftext);
         if not(pos('~',lineoftext)=1) then
            begin
               writeln(lineoftext);
               if((control MOD screenlines)=0)then
                  begin
                     prompt;
                     control:=0;
                  end;
            end;
      until((eof(pasfile))or(pos('~',lineoftext)=1));

   close(pasfile);
end;
{---------------------------------------------------------------------------}
procedure mainmenu(var ans:char);

var
   ch:char;

begin
   textcolor(white);
   screentext('mainmenu');
   repeat
      ans:=readkey;
      if not(ans in ['1'..'9',' ','R'])then
         lowbeep;
      if(ans='R')then
         begin
            ch:=readkey;
            if(ch='E')then
               begin
                  ch:=readkey;
                  if(ch='S')then
                     begin
                        writeln;
                        textcolor(darkcyan);
                        screentext('research');
                        prompt;
                        writeln;
                        textcolor(white);
                        screentext('mainmenu');
                     end;
               end;
         end;
   until(ans in ['1'..'8',' ','q','Q']);
end;
{---------------------------------------------------------------------------}
procedure menu1(var ans:char);

begin
   textcolor(randomcolor);
   screentext('menu1');
   repeat
      ans:=readkey;
      if not(ans in ['a'..'e','A'..'E'])then
         lowbeep;
   until(ans in ['a'..'e','A'..'E']);
end;
{---------------------------------------------------------------------------}
procedure menu2(var ans:char);

begin
   textcolor(randomcolor);
   screentext('menu2');
   repeat
      ans:=readkey;
      if not(ans in ['a'..'d','A'..'D'])then
         lowbeep;
   until(ans in ['a'..'d','A'..'D']);
end;
{---------------------------------------------------------------------------}
procedure menu3(var ans:char);

begin
   textcolor(randomcolor);
   screentext('menu3');
   repeat
      ans:=readkey;
      if not(ans in ['a'..'e','A'..'E'])then
         lowbeep;
   until(ans in ['a'..'e','A'..'E']);
end;
{---------------------------------------------------------------------------}
procedure menu4(var ans:char);

begin
   textcolor(randomcolor);
   screentext('menu4');
   repeat
      ans:=readkey;
      if not(ans in ['a'..'d','A'..'D'])then
         lowbeep;
   until(ans in ['a'..'d','A'..'D']);
end;
{---------------------------------------------------------------------------}
procedure menu5(var ans:char);

begin
   textcolor(randomcolor);
   screentext('menu5');
   repeat
      ans:=readkey;
      if not(ans in ['a'..'d','A'..'D'])then
         lowbeep;
   until(ans in ['a'..'d','A'..'D']);
end;
{---------------------------------------------------------------------------}
procedure menu6(var ans:char);

begin
   textcolor(randomcolor);
   screentext('menu6');
   repeat
      ans:=readkey;
      if not(ans in ['y','Y','n','N'])then
         lowbeep;
   until(ans in ['y','Y','n','N']);
end;
{---------------------------------------------------------------------------}
procedure menu7(var ans:char);

begin
   textcolor(randomcolor);
   screentext('menu7');
   repeat
      ans:=readkey;
      if not(ans in ['y','Y','n','N'])then
         lowbeep;
   until(ans in ['y','Y','n','N']);
end;
{---------------------------------------------------------------------------}
procedure menu8(var ans:char);

begin
   textcolor(randomcolor);
   screentext('menu8');
   repeat
      ans:=readkey;
      if not(ans in ['y','Y','n','N'])then
         lowbeep;
   until(ans in ['y','Y','n','N']);
end;
{---------------------------------------------------------------------------}
procedure menu9(var ans:char);



begin
   textcolor(randomcolor);
   screentext('menu9');
   repeat
      ans:=readkey;
      if not(ans in ['y','Y','n','N'])then
         lowbeep;
   until(ans in ['y','Y','n','N']);
end;
{---------------------------------------------------------------------------}
procedure over;

var
   ch:char;

begin
   writeln;
   textcolor(white);
   screentext('gameover');
   ch:=readkey;
end;
{---------------------------------------------------------------------------}
procedure initgame(var name:namelist;
                   var funds,power,morale:numlist;
                   var loyal:matrix);

var
   pasfile:text;
   loop:integer;
   count:integer;

begin
   assign(pasfile,datafile);
   reset(pasfile);
   for loop:=1 to 4 do
      begin
         readln(pasfile,name[loop]);
         readln(pasfile,funds[loop]);
         readln(pasfile,power[loop]);
         readln(pasfile,morale[loop]);
         for count:=1 to 4 do
            begin
               readln(pasfile,loyal[loop,count]);
            end;
      end;
   close(pasfile);
   for loop:=1 to 4 do
      alive[loop]:=true;
end;
{---------------------------------------------------------------------------}
procedure statsbox(faction:integer);

begin
   writeln;
   textcolor(statscolor);
   writeln(name[faction]);
   writeln('funds:':8,funds[faction]:5);
   writeln('power:':8,power[faction]:5);
   writeln('morale:':8,morale[faction]:5);
   writeln;
   textcolor(defaultcolor);
   prompt;
   writeln;
end;
{---------------------------------------------------------------------------}
procedure setstats(var power,morale:numlist;
                   var loyal:matrix);


var
   loop:integer;
   count:integer;

begin
   for loop:=1 to 4 do
      begin

         if(power[loop]<0)then
            power[loop]:=0;
         if(power[loop]>100)then
            power[loop]:=100;
         if(morale[loop]<0)then
            morale[loop]:=0;
         if(morale[loop]>100)then
            morale[loop]:=100;
         for count:=1 to 4 do
            begin
               if(loyal[loop,count]<0)then
                  loyal[loop,count]:=0;
               if(loyal[loop,count]>100)then
                  loyal[loop,count]:=100;
            end;
      end;
end;
{---------------------------------------------------------------------------}
PROCEDURE mbintro;

var
   ans         : char;

begin
   clrscr;
   textcolor(titlecolor);
   screentext('title');
   textcolor(titlecolor);
   writeln('(text version)');
   writeln;
   write('(C)redits or (G)ame? ');
   repeat
      ans:=readkey;
   until (ans in ['c','C','g','G',' ']);
   writeln;
   writeln;
   if(ans in ['c','C'])then
      begin
         textcolor(creditcolor);
         screentext('credits');
         prompt;
         writeln;
      end;
   textcolor(introcolor);
   screentext('intro');
   prompt;
   writeln;
End;
{---------------------------------------------------------------------------}
procedure taxes(person:integer;var funds,morale:numlist);

begin
   writeln;
   textcolor(defaultcolor);
   writeln(name[person]);
   screentext('taxes1');
   prompt;
   funds[person]:=funds[person] + 200;
   morale[person]:=morale[person] - (d(10) + 10);
end;
{---------------------------------------------------------------------------}
procedure holiday(person:integer;var funds,morale:numlist);

begin
   writeln;
   textcolor(defaultcolor);
   if(funds[person]<123)and(person=1)then
      screentext('holiday1');
   if(funds[person]>=123)then
      begin
         textcolor(defaultcolor);
         writeln(name[person]);
         screentext('holiday2');
         funds[person]:=funds[person] - 123;
         morale[person]:=morale[person] + d(10) + 4;
      end;
   prompt;
end;
{---------------------------------------------------------------------------}
procedure visit(host:integer;
                var funds,power:numlist;
                var loyal:matrix;
                var alive:list);

var
   success          :boolean;

begin
   textcolor(defaultcolor);
   writeln;
   case host of
      2:cost:=56;
      3:cost:=42;
      4:cost:=84;
   end;{case}
   success:=true;
   if(cost>funds[1])then
      begin
         screentext('visit1');
         prompt;
         writeln;
         success:=false;
      end
   else
      begin
         funds[1]:=funds[1] - cost;
         case d(100) of
            1..18:begin
                     screentext('visit2');
                     prompt;
                     writeln;
                  end;
           19..40:begin
                     screentext('visit3');
                     prompt;
                     writeln;
                  end;
           41..50:begin
                     screentext('visit4');
                     prompt;
                     writeln;
                     success:=false;
                  end;
           51..56:begin
                     screentext('visit11');
                     prompt;
                     writeln;
                  end;
         end;{case}
      end;
   if not(alive[host])then
      begin
         case host of
            3:screentext('visit9');
            4:screentext('visit10');
         end;{case}
         prompt;
         success:=false;
      end;
   if(success)then
      begin
         case host of
            2:begin
                 screentext('visit5');
                 alive[1]:=false;
              end;
            3:begin
                 screentext('visit6');
                 loyal[3,1]:=loyal[3,1] + d(10);
              end;
            4:begin
                 if(d(100)<=(loyal[4,1] + 10))then
                    begin
                       screentext('visit7');
                       loyal[4,1]:=loyal[4,1] + d(10);
                       power[1]:=power[1] + d(4) + 4;
                    end
                 else
                    screentext('visit8');
              end;
         end;{case}
         prompt;
         writeln;
      end;
end;
{---------------------------------------------------------------------------}
procedure menu3a(ans:char;var num:integer);

begin
   textcolor(randomcolor);
   screentext('menu3a');
   repeat
      ans:=readkey;
      if not(ans in ['a'..'d','A'..'D'])then
         lowbeep;
   until(ans in ['a'..'d','A'..'D']);
   case ans of
      'a','A':num:=3;
      'b','B':num:=4;
      'c','C':num:=2;
      'd','D':num:=0;
   end;{case}
end;
{---------------------------------------------------------------------------}
procedure army(person,target:integer;
               var funds,power:numlist;
               var loyal:matrix;
               alive:list);

var
   ratio       :integer;
   attack      :string;
   success     :boolean;

begin
   writeln;
   textcolor(attackcolor);
   success:=true;
   if (funds[person]<400) or not(alive[target]) then
      begin
        success:=false;
        if (funds[person]<400) and (person=1) then
           screentext('attack1');
           if not(alive[target]) and (person=1) then
              screentext('attack2');
           prompt;
      end;
   if(success)then
      begin
         funds[person]:=funds[person] - 400;
         loyal[target,person]:=loyal[target,person] - (d(20) + 50);
         if(target=3)then
            loyal[4,person]:=loyal[4,person] - d(20);
         if(target=4)then
            loyal[3,person]:=loyal[4,person] - d(20);
         ratio:=power[person] - power[target];
         attack:='sends an army against ';
         if(target=1)then
            attack:=attack + 'you!'
         else
            attack:=attack + name[target] + ' ...';
         writeln(name[person]);
         writeln(attack);
         ratio:=ratio + 50;
         if(d(100)<=ratio)then
            begin
               power[target]:=power[target] - (d(10) + 30);
               power[person]:=power[person] + (d(30) + 10);
               screentext('army1');
            end
         else
            begin
               power[target]:=power[target] - d(10);
               power[person]:=power[person] - (d(10) + 30);
               screentext('army2');
            end;
         prompt;
      end;
end;
{---------------------------------------------------------------------------}
procedure band(person,target:integer;
               var funds,power:numlist;
               var loyal:matrix;
               alive:list);

var
     ratio     :integer;
     attack    :string;
     success   :boolean;

begin
   writeln;
   textcolor(attackcolor);
   success:=true;
   if (funds[person]<50) or not(alive[target]) then
      begin
         success:=false;
         if (funds[person]<50) and (person=1) then
            screentext('attack1');
         if not(alive[target]) and (person=1) then
            screentext('attack2');
         prompt;
      end;
   if(success)then
      begin
         funds[person]:=funds[person] - 50;
         loyal[target,person]:=loyal[target,person] - (d(5) + 15);
         if(target=3)then
            loyal[4,person]:=loyal[4,person] - d(5);
         if(target=4)then
            loyal[3,person]:=loyal[4,person] - d(5);
         ratio:=power[person] - power[target];
         attack:='sends a band of men against ';
         if(target=1)then
            attack:=attack + 'you!'
         else
            attack:=attack + name[target] + ' ...';
         writeln(name[person]);
         writeln(attack);
         ratio:=ratio + 40;
         if(d(100)<=ratio)then
            begin
               power[target]:=power[target] - (d(5) + 5);
               power[person]:=power[person] + d(5);
               screentext('band1');
            end
         else
            begin
               power[target]:=power[target] - d(5);
               power[person]:=power[person] - (d(5) + 5);
               screentext('band2');
            end;
          prompt;
      end;
end;
{---------------------------------------------------------------------------}
procedure knight(person,target:integer;
                 var funds,power:numlist;
                 var loyal:matrix;
                 alive:list);

var
     ratio     :integer;
     attack    :string;
     success   :boolean;

begin
   writeln;
   textcolor(attackcolor);
   success:=true;
   if (funds[person]<120) or not(alive[target]) then
      begin
         success:=false;
         if (funds[person]<120) and (person=1) then
            screentext('attack1');
         if not(alive[target]) and (person=1) then
            screentext('attack2');
         prompt;
      end;
   if(success)then
      begin
         funds[person]:=funds[person] - 120;
         loyal[target,person]:=loyal[target,person] - (d(10) + 40);
         if(target=3)then
            loyal[4,person]:=loyal[4,person] - d(10);
         if(target=4)then
            loyal[3,person]:=loyal[4,person] - d(10);
         ratio:=power[person] - power[target];
         attack:='sends a legion against ';
         if(target=1)then
            attack:=attack + 'you!'
         else
            attack:=attack + name[target] + ' ...';
         writeln(name[person]);
         writeln(attack);
         ratio:=ratio + 45;
         if(d(100)<=ratio)then
            begin
               power[target]:=power[target] - (d(10) + 20);
               power[person]:=power[person] + (d(20) + 10);
               screentext('knight1');
            end
         else
            begin
               power[target]:=power[target] - d(10);
               power[person]:=power[person] - (d(10) + 20);
               screentext('knight2');
            end;
         prompt;
      end;

end;
{---------------------------------------------------------------------------}
procedure assassin(person,target:integer;
                   var funds,power:numlist;
                   var loyal:matrix;
                   var alive:list);

var
     ratio     :integer;
     success   :boolean;
     caught    :boolean;
     attack    :string;
     loop      :integer;

begin
   writeln;
   textcolor(defaultcolor);
   success:=true;
   if (funds[person]<80) or not(alive[target]) then
      begin
         success:=false;
         if (funds[person]<80) then
            screentext('attack3');
         if not(alive[target]) then
            screentext('attack4');
         prompt;
      end;
   if(success)then
      begin
         funds[person]:=funds[person] - 80;
         writeln('You secretly hire an assassin...');
         ratio:=d(5) + 10;
         if(d(100)<=ratio)then
            caught:=false
         else
            caught:=true;
         if(caught)then
            begin
               loyal[target,person]:=loyal[target,person] - 25;
               for loop:=1 to 4 do
                  if(loop<>person)then
                     loyal[loop,person]:=loyal[loop,person] - (d(20) + 10);
               screentext('caught1')
            end;
          if not(caught) then
             begin
                screentext('assassin1');
                alive[target]:=false;
             end;
          prompt;
      end;
end;
{---------------------------------------------------------------------------}
procedure menu1a(ans:char;var num:integer);

begin
   screentext('menu1a');
   repeat
      ans:=readkey;
      if not(ans in ['a'..'d','A'..'D'])then
         lowbeep;
   until(ans in ['a'..'d','A'..'D']);
   case ans of
      'a','A':num:=3;
      'b','B':num:=4;
      'c','C':num:=2;
      'd','D':num:=0;
   end;{case}
end;
{---------------------------------------------------------------------------}
procedure peace(host:integer;var funds:numlist;var loyal:matrix;alive:list);

var
     chance    :integer;

begin
   writeln;
   textcolor(defaultcolor);
   if not(alive[host]) then
      screentext('peace1')
   else
      if(funds[1]<40)then
         screentext('peace2')
      else
         begin
            funds[1]:=funds[1] - 40;
            chance:=loyal[host,1] - 10;
            if(d(100)<=chance)then
               begin
                  screentext('peace3');
                  if(host=2)then
                     loyal[host,1]:=loyal[host,1] + d(5)
                  else
                     loyal[host,1]:=loyal[host,1] + d(20);
               end
            else
               case d(100) of
                  1..30:screentext('peace4');
                 31..60:screentext('peace5');
               else
                  screentext('peace6');
               end;{case}
         end;
   prompt;
end;
{---------------------------------------------------------------------------}
procedure threat(host:integer;var funds:numlist;var loyal:matrix;alive:list);

var
     chance    :integer;

begin
   writeln;
   textcolor(defaultcolor);
   if not(alive[host]) then
      screentext('threat1')
   else
      if(funds[1]<1)then
         screentext('threat2')
      else
         begin
            funds[1]:=funds[1] - 1;
            chance:=78;
            if(d(100)<=chance)then
               begin
                  screentext('threat3');
                  loyal[host,1]:=loyal[host,1] - d(20);
               end
            else
               if(d(100)<=75)then
                  screentext('threat4')
               else
                  screentext('threat5');
         end;
   prompt;
end;
{---------------------------------------------------------------------------}
procedure aid(host:integer;var funds,power:numlist;var loyal:matrix;alive:list);

var
     chance    :integer;
     given     :integer;

begin
   writeln;
   textcolor(defaultcolor);
   if not(alive[host]) then
      begin
         screentext('aid1');
         prompt;
      end
   else
      if(funds[1]<10)then
         begin
            screentext('aid2');

            prompt;
         end
      else
         begin
            funds[1]:=funds[1] - 10;
            chance:=loyal[host,1] - 40;
            if(d(100)<=chance)and(power[host]>50)then
               begin
                  screentext('aid3');
                  prompt;
                  loyal[host,1]:=loyal[host,1] - d(20);
                  given:=d(4) + 16;
                  power[host]:=power[host] - given;
                  power[1]:=power[1] + given;
               end
            else
               if(chance<=10)then
                  begin
                     screentext('aid4');
                     prompt;
                  end
               else
                  begin
                     screentext('aid5');
                     prompt;
                  end;
         end;
end;
{---------------------------------------------------------------------------}
procedure gifts(host:integer;
                var funds,morale:numlist;
                var loyal:matrix;
                alive:list);

var
     chance    :integer;

begin
   writeln;
   textcolor(defaultcolor);
   if not(alive[host]) then
      screentext('gifts1')
   else
      if(funds[1]<100)then
         screentext('gifts2')
      else
         begin
            funds[1]:=funds[1] - 100;
            chance:=72;
            if(d(100)<=chance)and(funds[host]<4000)then
               begin
                  screentext('gifts3');
                  loyal[host,1]:=loyal[host,1] + d(5) + 10;
                  morale[1]:=morale[1] + d(5);
               end
            else
               if(d(100)<=60)then
                  screentext('gifts4')
               else
                  screentext('gifts5');
         end;
   prompt;
end;

{---------------------------------------------------------------------------}
procedure spy(host:integer;var funds:numlist;var loyal:matrix;alive:list);

var
     chance    :integer;
     cost      :integer;

begin
   writeln;
   textcolor(defaultcolor);
   case host of
      2:cost:=42;
      3:cost:=23;
      4:cost:=28;
   end;{case}
   if not(alive[host]) then
      begin
         screentext('spy1');
         prompt;
      end
   else
      if(funds[1]<cost)then
         begin
            screentext('spy2');
            prompt;
         end
      else
         begin
            funds[1]:=funds[1] - cost;
            chance:=92;
            if(d(100)<=chance)then
               begin
                  screentext('spy3');
                  prompt;
                  statsbox(host);
               end
            else
               begin
                  screentext('spy4');
                  prompt;
               end;
         end;
end;
{---------------------------------------------------------------------------}
procedure alliance(host:integer;var funds:numlist;var loyal:matrix;alive:list);

var
     chance    :integer;
     cost      :integer;

begin
   writeln;
   textcolor(defaultcolor);
   case host of
      2:cost:=120;
      3:cost:=60;
      4:cost:=75;
   end;{case}
   if not(alive[host]) then
      screentext('ally1')
   else
      if(funds[1]<cost)then
         screentext('ally2')
      else
         begin
            funds[1]:=funds[1] - cost;
            chance:=loyal[host,1] - 20;
            if(host=2)then
               chance:=chance - 10;
            if(d(100)<=chance)then
               begin
                  screentext('ally3');
                  if(host=2)then
                     loyal[host,1]:=loyal[host,1] + d(5) + 20
                  else
                     loyal[host,1]:=loyal[host,1] + d(20) + 40;
                  morale[1]:=morale[1] + d(10) + 5;
               end
            else
               screentext('ally4');
         end;
   prompt;
end;
{---------------------------------------------------------------------------}
procedure moscotesending(alive:list);

begin
   textcolor(endingcolor);
   writeln;
   if (alive[4]) then
      screentext('ending1')
   else
      screentext('ending2');
   prompt;
end;
{---------------------------------------------------------------------------}
procedure goarcadio(var alive:list);

var
     finish    :boolean;
     victim    :integer;
     worst     :integer;
     counter   :integer;

begin
   writeln;
   finish:=false;
   worst:=100;
   victim:=0;
   repeat
       if (funds[2]<400) and (morale[2]>20) then
          begin
             taxes(2,funds,morale);
             finish:=true;
          end;
       if not(finish) and (funds[2]>400) and (morale[2]<20) then
          begin
             holiday(2,funds,morale);
             finish:=true;
          end;
       if not(finish) and (funds[2]>400) and (power[2]<60)then
          begin
             funds[2]:=funds[2] - 100;
             power[2]:=power[2] + d(10) + 20;
             finish:=true;
          end;
        if not(finish) then
           case d(100) of
              1..20:if(funds[2]>600)and(power[2]>40)then
                       begin
                          finish:=true;
                          for counter:=1 to 4 do
                             if(counter<>2)then
                                if(loyal[2,counter]<worst)then
                                   begin
                                      victim:=counter;
                                      worst:=loyal[2,counter];
                                   end;
                          army(2,victim,funds,power,loyal,alive);
                       end;
             21..50:if(funds[2]>400)and(power[2]>30)then
                       begin
                          finish:=true;
                          for counter:=1 to 4 do
                             if(counter<>2)then
                                if(loyal[2,counter]<worst)then
                                   begin
                                      victim:=counter;
                                      worst:=loyal[2,counter];
                                   end;
                          knight(2,victim,funds,power,loyal,alive);
                       end;
             51..65:if(funds[2]>100)and(power[2]>20)then
                       begin
                          finish:=true;
                          for counter:=1 to 4 do
                             if(counter<>2)then
                                if(loyal[2,counter]<worst)then
                                   begin
                                      victim:=counter;
                                      worst:=loyal[2,counter];
                                   end;
                          band(2,victim,funds,power,loyal,alive);
                       end;
             66..100:begin
                        finish:=true;
                     end;
           end;{case}
   until(finish);
   if (power[2]=0) then
      begin
         writeln;
         screentext('arcadio1');
         prompt;
         alive[2]:=false;
      end;
   if (morale[2]=0) then
      begin
         writeln;
         screentext('arcadio2');
         prompt;
         alive[2]:=false;
      end;
end;
{---------------------------------------------------------------------------}
procedure goaureliano(var alive:list);

var
     finish    :boolean;
     victim    :integer;
     worst     :integer;
     counter   :integer;

begin
   writeln;
   finish:=false;
   worst:=100;
   victim:=0;
   repeat
      if (funds[3]<100) and (morale[3]>50) then
         begin
            taxes(3,funds,morale);
            finish:=true;
         end;
      if not(finish) and (funds[3]>200) and (morale[3]<40) then
         begin
            holiday(3,funds,morale);
            finish:=true;
         end;
      if not(finish) and (funds[3]>400) and (power[3]<40)then
         begin
            funds[3]:=funds[3] - 100;
            power[3]:=power[3] + d(10) + 20;
            finish:=true;
         end;
      if not(finish) then
         case d(100) of
            1..15:if(funds[3]>400)and(power[3]>40)then
                     begin
                        finish:=true;
                        for counter:=1 to 4 do
                           if(counter<>3)then
                              if(loyal[3,counter]<worst)then
                                 begin
                                    victim:=counter;
                                    worst:=loyal[3,counter];
                                 end;
                        army(3,victim,funds,power,loyal,alive);
                     end;
           16..30:if(funds[3]>200)and(power[3]>30)then
                     begin
                        finish:=true;
                        for counter:=1 to 4 do
                           if(counter<>3)then
                              if(loyal[3,counter]<worst)then
                                 begin
                                    victim:=counter;
                                    worst:=loyal[3,counter];
                                 end;
                        knight(3,victim,funds,power,loyal,alive);
                     end;
           31..45:if(funds[3]>100)and(power[3]>20)then
                     begin
                        finish:=true;
                        for counter:=1 to 4 do
                           if(counter<>3)then
                              if(loyal[3,counter]<worst)then
                                 begin
                                    victim:=counter;
                                    worst:=loyal[3,counter];
                                 end;
                        band(3,victim,funds,power,loyal,alive);
                     end;
          46..100:begin
                     finish:=true;
                  end;
         end;{case}
   until(finish);
   if (power[3]=0) then
      begin
         writeln;
         screentext('aureliano1');
         prompt;
         alive[3]:=false;
      end;
   if (morale[3]=0) then
      begin
         writeln;
         screentext('aureliano2');
         prompt;
         alive[3]:=false;
      end;
end;
{---------------------------------------------------------------------------}
procedure gomoscote(var alive:list);

var
     finish    :boolean;
     victim    :integer;
     worst     :integer;
     counter   :integer;

begin
   writeln;
   finish:=false;
   worst:=100;
   victim:=0;
   repeat
      if (funds[4]<200) and (morale[4]>40) then
         begin
            taxes(4,funds,morale);
            finish:=true;
         end;
      if not(finish) and (funds[4]>200) and (morale[4]<30) then
         begin
            holiday(4,funds,morale);
            finish:=true;
         end;
      if not(finish) and (funds[4]>400) and (power[4]<50)then
         begin
            funds[4]:=funds[4] - 100;
            power[4]:=power[4] + d(10) + 20;
            finish:=true;
         end;
      if not(finish) then
         case d(100) of
            1..20:if(funds[4]>600)and(power[4]>60)then
                     begin
                        finish:=true;
                        for counter:=1 to 4 do
                           if(counter<>4)then
                              if(loyal[4,counter]<worst)then
                                 begin
                                    victim:=counter;



                                    worst:=loyal[4,counter];
                                 end;
                        army(4,victim,funds,power,loyal,alive);
                     end;
           21..45:if(funds[4]>300)and(power[4]>60)then
                     begin
                        finish:=true;
                        for counter:=1 to 4 do
                           if(counter<>4)then
                              if(loyal[4,counter]<worst)then
                                 begin
                                    victim:=counter;
                                    worst:=loyal[4,counter];
                                 end;
                        knight(4,victim,funds,power,loyal,alive);
                     end;
           46..55:if(funds[4]>200)and(power[4]>40)then
                     begin
                        finish:=true;
                        for counter:=1 to 4 do
                           if(counter<>4)then
                              if(loyal[4,counter]<worst)then
                                 begin
                                    victim:=counter;
                                    worst:=loyal[4,counter];
                                 end;
                        band(4,victim,funds,power,loyal,alive);
                     end;
          56..100:begin
                     finish:=true;
                  end;
         end;{case}
   until(finish);
   if (power[4]=0) then
      begin
         writeln;
         screentext('moscote1');
         prompt;
         alive[4]:=false;
      end;
   if (morale[4]=0) then
      begin
         writeln;
         screentext('moscote2');
         prompt;
         alive[4]:=false;
      end;
end;
{---------------------------------------------------------------------------}
procedure game;

var
   done:boolean;
   loop:integer;
   ans:char;

begin
   gameover:=false;
   moscoteend:=false;
   repeat
      writeln;
      done:=false;
      repeat
         mainmenu(ans);
         if(ans=' ')then
            statsbox(1);
         if(ans='1')then
            begin
               menu1(ans);
               if not(ans in ['e','E'])then
                  menu1a(ans,num);
               done:=true;
               if(num<>0)then
                  case ans of
                     'a','A':peace(num,funds,loyal,alive);
                     'b','B':threat(num,funds,loyal,alive);
                     'c','C':aid(num,funds,power,loyal,alive);
                     'd','D':gifts(num,funds,morale,loyal,alive);
                  else
                     done:=false;
                  end{case}
               else
                  done:=false;
            end;
         if(ans='2')then
            begin
               menu2(ans);
               done:=true;
               case ans of
                  'a','A':visit(3,funds,power,loyal,alive);
                  'b','B':visit(4,funds,power,loyal,alive);
                  'c','C':visit(2,funds,power,loyal,alive);
               else
                  done:=false;
               end;{case}
            end;
         if(ans='3')then
            begin
               menu3(ans);
               if not(ans in ['e','E'])then
                  menu3a(ans,num);
               done:=true;
               if(num<>0)then
                  case ans of
                     'a','A':army(1,num,funds,power,loyal,alive);
                     'b','B':band(1,num,funds,power,loyal,alive);
                     'c','C':knight(1,num,funds,power,loyal,alive);
                     'd','D':assassin(1,num,funds,power,loyal,alive);
                  else
                     done:=false;
                  end{case}
               else
                  done:=false;
            end;
         if(ans='4')then
            begin
               menu4(ans);
               done:=true;
               case ans of
                  'a','A':spy(3,funds,loyal,alive);
                  'b','B':spy(4,funds,loyal,alive);
                  'c','C':spy(2,funds,loyal,alive);
               else
                  done:=false;
               end;{case}
            end;
         if(ans='5')then
            begin
               menu5(ans);
               done:=true;
               case ans of
                  'a','A':alliance(3,funds,loyal,alive);
                  'b','B':alliance(4,funds,loyal,alive);
                  'c','C':alliance(2,funds,loyal,alive);
               else
                  done:=false;
               end;{case}
            end;
         if(ans='6')then
            begin
               menu6(ans);
               if(ans in ['y','Y'])then
                  begin
                     taxes(1,funds,morale);
                     done:=true;
                  end;
            end;
         if(ans='7')then
            begin
               menu7(ans);
               if(ans in ['y','Y'])then
                  begin
                     holiday(1,funds,morale);
                     done:=true;
                  end;
            end;
         if(ans='8')then
            begin
               menu8(ans);
               if(ans in ['y','Y'])then
                  done:=true;
            end;
         if(ans='q')or(ans='Q')then
            begin
               menu9(ans);
               if(ans in ['y','Y'])then
                  begin
                     done:=true;
                     gameover:=true;
                  end;
            end;
      until(done);
      writeln;
      for loop:=1 to 4 do
         begin
            power[loop]:=power[loop] + (d(3)-1);
            morale[loop]:=morale[loop] + (d(3)-2);
         end;
      setstats(power,morale,loyal);
      if not(alive[1])then
         gameover:=true;
      if not(alive[2]) and not(gameover) then
         begin
            gameover:=true;
            moscoteend:=true;
         end;
      if not(gameover)and(morale[1]=0)then
         begin
            screentext('overthrow1');
            prompt;
            gameover:=true;
         end;
      if not(gameover)and(morale[1]=100)then
         begin
            screentext('goodrule1');
            prompt;
            funds[1]:=funds[1] + 20;
         end;
      if not(gameover) and (power[1]=0) then
         begin
            screentext('conquered1');
            prompt;
            gameover:=true;
         end;
      if not(gameover) and (alive[2]) then
         begin
            goarcadio(alive);
            setstats(power,morale,loyal);

            if not(alive[1])then
               gameover:=true;
            if not(alive[2]) and not(gameover) then
               begin
                  gameover:=true;
                  moscoteend:=true;
               end;
         end;
      if not(gameover) and (alive[3]) then
         begin
            goaureliano(alive);
            setstats(power,morale,loyal);
            if not(alive[1])then
               gameover:=true;
            if not(alive[2]) and not(gameover) then
               begin
                  gameover:=true;
                  moscoteend:=true;
               end;
         end;
      if not(gameover) and (alive[4]) then
         begin
            gomoscote(alive);
            setstats(power,morale,loyal);
            if not(alive[1])then
               gameover:=true;
            if not(alive[2]) and not(gameover) then
               begin
                  gameover:=true;
                  moscoteend:=true;
               end;
         end;
      if not(alive[2]) and not(gameover) then
         begin
            gameover:=true;
            moscoteend:=true;
         end;
      if (moscoteend) and (alive[1]) then
         moscotesending(alive);
   until(gameover);
end;
{===========================================================================}

Begin {main}

   randomize;
   clrscr;
   mbintro;
   initgame(name,funds,power,morale,loyal);
   game;
   over;


End.
