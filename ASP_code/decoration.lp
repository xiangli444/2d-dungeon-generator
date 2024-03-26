%% The number of treasures:
#const tmax = 5.
#const tmin = 1.

{treasure(X1, Y1, space(X, Y))}:- sprite(X1, Y1, space(X, Y)), ps(X, Y, N), {sprite(X2, Y2, space(X, Y)):sadj(X1, Y1, X2, Y2)} = 1,not border(X1, Y1, space(X, Y)).

:- {treasure(X1, Y1, space(X, Y))} > tmax, ps(X, Y, N).
:- {treasure(X1, Y1, space(X, Y))} < tmin, ps(X, Y, N).

tfinal((X-1)*w+X1, (Y-1)*h+Y1, space(X, Y)):- treasure(X1, Y1, space(X, Y)).
#show tfinal/3.

%% The number of monsters:
#const mmax = 7.
#const mmin = 3.

{monster(X1, Y1, space(X, Y))} :- sprite(X1, Y1, space(X, Y)), ps(X, Y, N), {sprite(X2, Y2, space(X, Y)):sadj(X1, Y1, X2, Y2)}>1.

:- {monster(X1, Y1, space(X, Y))} > mmax, ps(X, Y, N).
:- {monster(X1, Y1, space(X, Y))} < mmin, ps(X, Y, N).

:- monster(X1, Y1, space(X, Y)),monster(X2, Y2, space(X, Y)), 
	sadj(X1, Y1, X2, Y2).

K/2 {monster_p(X1, Y1, space(X, Y)): monster(X1, Y1, space(X, Y))}:- {monster(_, _, space(X, Y))} = K, ps(X, Y, N).
1 {monsterzone(X2, Y2, space(X, Y)):
	sadj(X1, Y1, X2, Y2), sprite(X2, Y2, space(X, Y))} 2:- 
		monster_p(X1, Y1, space(X, Y)).

mfinal((X-1)*w+X1, (Y-1)*h+Y1, space(X, Y)):- monster(X1, Y1, space(X, Y)).
mfinal((X-1)*w+X1, (Y-1)*h+Y1, space(X, Y)):- monsterzone(X1, Y1, space(X, Y)).

#show mfinal/3.

trap(X1, Y1, space(X, Y)):- 
	not sprite(X1,Y1,space(X, Y)), X1=1..w,Y1=1..h,%, dimx(X),dimy(Y),
	{sprite(X2,Y2,space(X,Y)):sadj(X1, Y1, X2, Y2)}=4, ps(X, Y, N).

rfinal((X-1)*w+X1, (Y-1)*h+Y1, space(X, Y)):- trap(X1, Y1, space(X, Y)).
:- {trap(_,_,space(X, Y))}=0, ps(X, Y, N).

#show rfinal/3.

lava(X1, Y1, space(X, Y)):- not sprite(X1,Y1,space(X, Y)), ps(X, Y, N),
	{sprite(X1+W1, Y1,space(X, Y)):W1=1..w} > 0,
	{sprite(X1-W1, Y1,space(X, Y)):W1=1..w} > 0,
	{sprite(X1, Y1+H1,space(X, Y)):H1=1..h} > 0,
	{sprite(X1, Y1-H1,space(X, Y)):H1=1..h} > 0,
	X1=1..w,Y1=1..h,
	not trap(X1, Y1, space(X, Y)).

1 {lava(X2, Y2, space(X, Y))}:-
	lava(X1, Y1, space(X, Y)), not sprite(X2,Y2,space(X, Y)), sadj(X1, Y1, X2, Y2).%, X2=1..w,Y2=1..h.

lfinal((X-1)*w+X1, (Y-1)*h+Y1, space(X, Y)):- lava(X1, Y1, space(X, Y)).
:- {lava(_,_,space(X, Y))}=0, ps(X, Y, N).
#show lfinal/3.

#show sfinal/3.