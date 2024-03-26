#const w=9.
#const h=9.

{set(X1, Y1, space(X, Y)): X1=1..w, Y1=1..w} = 1 :- pr(X, Y, N).
:- pr(X, Y, N), {sprite(X1, Y1, space(X, Y))}<h*w/2.


:-{sprite(X1, h, space(X, Y)):sprite(X1, 1, space(X, Y+1)), X1=1..w}=0 , c_r(N, X, Y+1), pr(X, Y, N).
:-{sprite(X1, 1, space(X, Y)):sprite(X1, h, space(X, Y-1)), X1=1..w}=0 , c_r(N, X, Y-1), pr(X, Y, N).

:-{sprite(X1, h, space(X, Y)):sprite(X1, 1, space(X, Y+1)), X1=1..w}>5 , c_r(N, X, Y+1), pr(X, Y, N).
:-{sprite(X1, 1, space(X, Y)):sprite(X1, h, space(X, Y-1)), X1=1..w}>5 , c_r(N, X, Y-1), pr(X, Y, N).

:-{sprite(w, Y1, space(X, Y)):sprite(1, Y1, space(X+1, Y)), Y1=1..h}=0 , c_r(N, X+1, Y), pr(X, Y, N).
:-{sprite(1, Y1, space(X, Y)):sprite(w, Y1, space(X-1, Y)), Y1=1..h}=0 , c_r(N, X-1, Y), pr(X, Y, N).

:-{sprite(w, Y1, space(X, Y)):sprite(1, Y1, space(X+1, Y)), Y1=1..h}>5 , c_r(N, X+1, Y), pr(X, Y, N).
:-{sprite(1, Y1, space(X, Y)):sprite(w, Y1, space(X-1, Y)), Y1=1..h}>5 , c_r(N, X-1, Y), pr(X, Y, N).

:-{sprite(X1, h, space(X, Y)):sprite(X1, 1, space(X, Y+1)), X1=1..w}=0 , not wall(X,Y,X,Y+1), pr(X, Y, N1), pr(X, Y+1, N2).
:-{sprite(X1, 1, space(X, Y)):sprite(X1, h, space(X, Y-1)), X1=1..w}=0 , not wall(X, Y, X, Y-1), pr(X, Y, N1), pr(X, Y-1, N2).

:-{sprite(w, Y1, space(X, Y)):sprite(1, Y1, space(X+1, Y)), Y1=1..h}=0 , not wall(X+1,Y,X,Y), pr(X, Y, N1), pr(X+1, Y, N2).
:-{sprite(1, Y1, space(X, Y)):sprite(w, Y1, space(X-1, Y)), Y1=1..h}=0 , not wall(X-1, Y, X, Y),  pr(X, Y, N1), pr(X-1, Y, N2).

:-{sprite(X1, h, space(X, Y)):sprite(X1, 1, space(X, Y+1)), X1=1..w}!=0 ,  wall(X,Y,X,Y+1).
:-{sprite(X1, 1, space(X, Y)):sprite(X1, h, space(X, Y-1)), X1=1..w}!=0 ,  wall(X, Y, X, Y-1).

:-{sprite(w, Y1, space(X, Y)):sprite(1, Y1, space(X+1, Y)), Y1=1..h}!=0 ,  wall(X+1,Y,X,Y).
:-{sprite(1, Y1, space(X, Y)):sprite(w, Y1, space(X-1, Y)), Y1=1..h}!=0 ,  wall(X-1, Y, X, Y).

border(X1, h, space(X, Y)):- connect(X, Y, X, Y+1), sprite(X1, h, space(X, Y)), sprite(X1, 1, space(X, Y+1)).
border(X1, 1, space(X, Y+1)):- connect(X, Y, X, Y+1), sprite(X1, h, space(X, Y)), sprite(X1, 1, space(X, Y+1)).
border(w, Y1, space(X, Y)):- connect(X, Y, X+1, Y), sprite(w, Y1, space(X, Y)), sprite(1, Y1, space(X+1, Y)).
border(1, Y1, space(X+1, Y)):- connect(X, Y, X+1, Y), sprite(w, Y1, space(X, Y)), sprite(1, Y1, space(X+1, Y)).

border(X1, 1, space(X, Y+1)):- c_r(N, X, Y+1), sprite(X1, 1, space(X, Y+1)), sprite(X1, h, space(X, Y)).
border(X1, h, space(X, Y-1)):- c_r(N, X, Y-1), sprite(X1, h, space(X, Y-1)), sprite(X1, 1, space(X, Y)).
border(1, Y1, space(X+1, Y)):- c_r(N, X+1, Y), sprite(1, Y1, space(X+1, Y)), sprite(w, Y1, space(X, Y)).
border(w, Y1, space(X-1, Y)):- c_r(N, X-1, Y), sprite(w, Y1, space(X-1, Y)), sprite(1, Y1, space(X, Y)).

:-{sprite(X1, h, space(X, Y)):sprite(X1, 1, space(X, Y+1)), X1=1..w}=0 , possible(X, Y, X, Y+1), possible(X, Y+1, X, Y),ps(X, Y, _), ps(X, Y+1, _).

:-{sprite(X1, h, space(X, Y)):sprite(X1, 1, space(X, Y+1)), X1=1..w}>2, possible(X, Y, X, Y+1),possible(X, Y+1, X, Y), ps(X, Y, _), ps(X, Y+1, _).

:-{sprite(w, Y1, space(X, Y)):sprite(1, Y1, space(X+1, Y)), Y1=1..h}=0 , possible(X, Y, X+1, Y), possible(X+1, Y, X, Y), ps(X+1, Y, _), ps(X, Y, _).

:-{sprite(w, Y1, space(X, Y)):sprite(1, Y1, space(X+1, Y)), Y1=1..h}>2, possible(X, Y, X+1, Y), possible(X+1, Y, X, Y), ps(X+1, Y, _), ps(X, Y, _).


%| 
leftm(lr;lu;ld;lud;ulr;dlr).
:- {sprite(1, Y1, space(X, Y)):Y1=1..h}=0, ps(X, Y, N), leftm(N).
%  |
rightm(lr;ru;rd;rud;ulr;dlr).
:- {sprite(w, Y1, space(X, Y)):Y1=1..h}=0, ps(X, Y, N), rightm(N).

%_
downm(ud;ld;rd;lud;rud;dlr).
:- {sprite(X1, 1, space(X, Y)):X1=1..w}=0, ps(X, Y, N), downm(N).

%-
upm(ud;lu;ru;lud;rud;ulr).
:- {sprite(X1, h, space(X, Y)):X1=1..w}=0, ps(X, Y, N), upm(N).


%|
leftn(ud;ru;rd;rud).
:-{sprite(1, Y1, space(X, Y)):Y1=1..h}!=0, ps(X, Y, N), leftn(N).

%  |
rightn(ud;lu;ld;lud).
:-{sprite(w, Y1, space(X, Y)):Y1=1..h}!=0, ps(X, Y, N), rightn(N).

%_
downn(lr;lu;ru;ulr).
:- {sprite(X1, 1, space(X, Y)):X1=1..w}!=0, ps(X, Y, N), downn(N).
%-
upn(lr;ld;rd;dlr).
:- {sprite(X1, h, space(X, Y)):X1=1..w}!=0, ps(X, Y, N), upn(N).


{set(X1, Y1, space(X, Y)):X1=1..w,Y1=1..h}=1:- ps(X, Y, N).
sprite(X1, Y1, space(X, Y)):- set(X1, Y1, space(X, Y)).

sadj(X1, Y1, X2, Y2):- X1=1..w,Y1=1..h,X2=1..w,Y2=1..h,|X1-X2|+|Y1-Y2| = 1.
{sprite(X2, Y2, N): sadj(X1, Y1, X2, Y2)}:- sprite(X1, Y1, N).

sfinal((X-1)*w+X1, (Y-1)*h+Y1, space(X, Y)):- sprite(X1, Y1, space(X, Y)).