PROGRAM Macbeth;

{
Early, unlicensed version kept for reference.
}

Uses graph, crt, user2;

Const

     location='';
     default=0; triplex=1; small=2; sanseri=3; gothic=4;
     horizontal=0; verticle=1;

Type
     stringtype=string[40];
     stringline=string[100];
     namelist=array[1..4] of stringtype;
     numlist=array[1..4] of integer;
     matrix=array[1..4,1..4] of integer;
     list=array[1..4] of boolean;
Var

     pasfile:text;
     lineoftext:stringline;
     device, mode:integer;
     style,size,control,color,x,y,loop,count:integer;
     ch,ans:char;
     name:namelist;
     funds,power,morale:numlist;
     loyal:matrix;
     malcolmend,done,gameover:boolean;
     theword:stringtype;
     cost:integer;
     alive:list;
     num:integer;

{$I mbinclud.pas}

{---------------------------------------------------------------------------}
procedure malcolmsending(alive:list);

begin
     clearall;
     setcolor(lightblue);
     color:=lightblue;
     if (alive[4]) then
          screentext(5,0,40,'ending1.txt')
     else
          screentext(5,0,40,'ending2.txt');
     prompt;
end;
{---------------------------------------------------------------------------}
procedure gomacbeth(var alive:list);

var
     finish:boolean;
     victim,worst,counter:integer;

begin
     clearall;
     setcolor(lightred);
     color:=lightred;
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
               clearall;
               setcolor(lightred);
               screentext(5,0,40,'macbeth1.txt');
               prompt;
               alive[2]:=false;
          end;
     if (morale[2]=0) then
          begin
               clearall;
               setcolor(lightred);
               screentext(5,0,40,'macbeth2.txt');
               prompt;
               alive[2]:=false;
          end;
end;
{---------------------------------------------------------------------------}
procedure gomacduff(var alive:list);

var
     finish:boolean;
     victim,worst,counter:integer;

begin
     clearall;
     setcolor(lightred);
     color:=lightred;
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
               clearall;
               setcolor(lightred);
               screentext(5,0,40,'macduff1.txt');
               prompt;
               alive[3]:=false;
          end;
     if (morale[3]=0) then
          begin
               clearall;
               setcolor(lightred);
               screentext(5,0,40,'macduff2.txt');
               prompt;
               alive[3]:=false;
          end;
end;
{---------------------------------------------------------------------------}
procedure gomalcolm(var alive:list);

var
     finish:boolean;
     victim,worst,counter:integer;

begin
     clearall;
     setcolor(lightred);
     color:=lightred;
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
               clearall;
               setcolor(lightred);
               screentext(5,0,40,'malcolm1.txt');
               prompt;
               alive[4]:=false;
          end;
     if (morale[4]=0) then
          begin
               clearall;
               setcolor(lightred);
               screentext(5,0,40,'malcolm2.txt');
               prompt;
               alive[4]:=false;
          end;
end;
{---------------------------------------------------------------------------}
procedure game(var ans:char);

begin
     gameover:=false;
     malcolmend:=false;
     repeat
          clearall;
          setcolor(white);
          color:=white;
          done:=false;
          control:=0;
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
               if(ans='9')then
                    begin
                         menu9(ans);
                         if(ans in ['y','Y'])then
                              begin
                                   done:=true;
                                   gameover:=true;
                              end;
                    end;
          until(done);
          clearall;
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
                    malcolmend:=true;
               end;
          if not(gameover)and(morale[1]=0)then
               begin
                    screentext(5,0,40,'overthrw.txt');
                    prompt;
                    gameover:=true;
               end;
          if not(gameover)and(morale[1]=100)then
               begin
                    screentext(5,0,40,'goodrule.txt');
                    prompt;
                    funds[1]:=funds[1] + 20;
               end;
          if not(gameover) and (power[1]=0) then
               begin
                    screentext(5,0,40,'cnquered.txt');
                    prompt;
                    gameover:=true;
               end;
          if not(gameover) and (alive[2]) then
               begin
                    gomacbeth(alive);
                    setstats(power,morale,loyal);
                    if not(alive[1])then
                         gameover:=true;
                    if not(alive[2]) and not(gameover) then
                         begin
                              gameover:=true;
                              malcolmend:=true;
                         end;
               end;
          if not(gameover) and (alive[3]) then
               begin
                    gomacduff(alive);
                    setstats(power,morale,loyal);
                    if not(alive[1])then
                         gameover:=true;
                    if not(alive[2]) and not(gameover) then
                         begin
                              gameover:=true;
                              malcolmend:=true;
                         end;
               end;
          if not(gameover) and (alive[4]) then
               begin
                    gomalcolm(alive);
                    setstats(power,morale,loyal);
                    if not(alive[1])then
                         gameover:=true;
                    if not(alive[2]) and not(gameover) then
                         begin
                              gameover:=true;
                              malcolmend:=true;
                         end;
               end;
          if not(alive[2]) and not(gameover) then
               begin
                    gameover:=true;
                    malcolmend:=true;
               end;
          if (malcolmend) and (alive[1]) then
               malcolmsending(alive);
     until(gameover);
end;
{---------------------------------------------------------------------------}
procedure one;

begin

end;
{===========================================================================}

Begin {main}

     randomize;
     clrscr;
     color:=lightblue;
     size:=4;
     style:=gothic;
     gfilesloc(device,mode,location);
     mbintro;
     readinfo(name,funds,power,morale,loyal);
     game(ans);
     over;
     closegraph;
     
End.