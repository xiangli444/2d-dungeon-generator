#const x_n =5.
#const y_n =5.
dimx(1..x_n).
dimy(1..y_n).
dim(X, Y):- X=1..x_n, Y=1..y_n.

room(N):- node(N).
edge(N1, N2):- edge_d(N1, N2).

{pr(X, Y, N): dim(X, Y)} = 1 :- room(N).
:- pr(X, Y, N1), pr(X, Y, N2), N1!=N2.

rest(empty;lr;ud;lu;ld;ru;rd;lud;rud;ulr;dlr).
{pn(X, Y, N):rest(N)} = 1 :- dimx(X), dimy(Y), not pr(X, Y, _).

co(X1, Y1, X2, Y2):- |X1-X2|+|Y1-Y2| = 1, dimx(X1), dimx(X2), dimy(Y1), dimy(Y2). 

connection(N1, N2):- pr(X, Y, N1), co(X, Y, X1, Y1), pr(X1, Y1, N2).

%:- {connection(N, N1):room(N1)}>4, room(N).

%:- not edge(N1, N2), not edge(N2, N1), connection(N1, N2).

%:- {c_r(N2,X2,Y2):connect(X1,Y1,X2,Y2),N1!=N2}>4,c_r(N1,X1,Y1).

%:- not edge(N1, N2), not edge(N2, N1), connection(N1, N2), in_ring(N1,X), not in_ring(N2,X), not smr(N2,X).
%:- not edge(N1, N2), not edge(N2, N1), connection(N1, N2), smr(N1,X).

ps(X2, Y2, N1):- c_r(N, X1, Y1), connect(X1, Y1, X2, Y2), pn(X2, Y2, N1).
remain(X, Y):- pn(X, Y, N), not ps(X, Y, _).

c_r(N, X1, Y1):- pr(X, Y, N), co(X, Y, X1, Y1), possible(X1, Y1, X, Y).
c_r(N, X1, Y1):- pr(X, Y, N), possible(X1, Y1, X, Y).
connection(N1, N2):- c_r(N1, X1, Y1), connect(X1, Y1, X2, Y2), c_r(N2, X2, Y2), N1!=N2.

possible(X, Y, X+1, Y):- pn(X, Y, lr).
possible(X, Y, X-1, Y):- pn(X, Y, lr).
possible(X, Y, X, Y+1):- pn(X, Y, ud).
possible(X, Y, X, Y-1):- pn(X, Y, ud).

possible(X, Y, X-1, Y):- pn(X, Y, ld).
possible(X, Y, X, Y-1):- pn(X, Y, ld).
possible(X, Y, X+1, Y):- pn(X, Y, rd).
possible(X, Y, X, Y-1):- pn(X, Y, rd).
possible(X, Y, X-1, Y):- pn(X, Y, lu).
possible(X, Y, X, Y+1):- pn(X, Y, lu).
possible(X, Y, X+1, Y):- pn(X, Y, ru).
possible(X, Y, X, Y+1):- pn(X, Y, ru).

possible(X, Y, X-1, Y):- pn(X, Y, lud).
possible(X, Y, X, Y+1):- pn(X, Y, lud).
possible(X, Y, X, Y-1):- pn(X, Y, lud).
possible(X, Y, X+1, Y):- pn(X, Y, rud).
possible(X, Y, X, Y+1):- pn(X, Y, rud).
possible(X, Y, X, Y-1):- pn(X, Y, rud).
possible(X, Y, X+1, Y):- pn(X, Y, ulr).
possible(X, Y, X-1, Y):- pn(X, Y, ulr).
possible(X, Y, X, Y+1):- pn(X, Y, ulr).
possible(X, Y, X+1, Y):- pn(X, Y, dlr).
possible(X, Y, X-1, Y):- pn(X, Y, dlr).
possible(X, Y, X, Y-1):- pn(X, Y, dlr).

connect(X, Y, X1, Y1):- possible(X, Y, X1, Y1), possible(X1, Y1, X, Y).
connect(X, Y, X2, Y2):- connect(X, Y, X1, Y1), connect(X1, Y1, X2, Y2).

:- edge(N1, N2), not connection(N1, N2).

%wall(X, Y, X1, Y1):-  
%	co(X, Y, X1, Y1), 
%	not edge(N1, N), not edge(N, N1), 
%	pr(X, Y, N), pr(X1, Y1, N1).