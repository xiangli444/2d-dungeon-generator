%% The number of missions:
#const puzzle_n = 5.
#const combat_n = 5.

node(start;end).
node(puzzle(1..puzzle_n)).
node(combat(1..combat_n)).

%% In- & outdegree:
#const out = 2.
#const in =2.

{edge_d(N,N1):node(N1)} out :- node(N).
{edge_d(N1,N):node(N1)} in :- node(N).

:- edge_d(N, start), node(N).
:- edge_d(end, N), node(N).

direction(N1, N2) :- edge_d(N1, N2).
direction(N1, N3) :- direction(N1, N2), 
                     direction(N2, N3).
:- not direction(start, N), node(N), N!=start.

%% Length of critical path:
%#const cl_min = 10. 
%#const cl_max = 20. 
#const cl_min = (puzzle_n+combat_n+2)/3.
#const cl_max = (puzzle_n+combat_n+2)/2.

pl_min(start, start, 0).
pl_min(start, N2, L+1):- edge_d(N1, N2), 
	pl_min(start, N1, L), 
	{pl_min(start, N2, L1): L1<=L}=0,
	L<puzzle_n+combat_n+2.
:- pl_min(start, end, L), L<cl_min.
:- pl_min(start, end, L), L>cl_max.

cp(end).
cp(N1) :- pl_min(start, end, L), 
		pl_min(start, N1, L1),
        L1<L,
        direction(N1, end).
		
n_ip :- cp(N1), cp(N2), 
		N1!=N2, 
		pl_min(start, N1, L1), 
		pl_min(start, N2, L2), 
		L1=L2.
independent.
:- independent, n_ip.
:- not independent, not n_ip.

%% The number of branches on the critical path: 
%#const cb_min = 1.
%#const cb_max = 3.
#const cbp_min = 4.
#const cbp_max = 2.

bh(N):- {edge_d(N,N1):node(N1)}>1, node(N).
cp_b(N) :- cp(N), bh(N).
%:- {cp_b(N)} < cb_min.
%:- {cp_b(N)} > cb_max.
:- {cp_b(N)} > L/cbp_max, pl_min(start, end, L).
:- {cp_b(N)} < L/cbp_min, pl_min(start, end, L).

de(N) :- node(N), not direction(N, end), N!=end.
subm(N):- node(N), edge_d(N, N1), direction(N1, N2), de(N2), direction(N1, end).
de :- {subm(N)} != 0.

side_mission.
:- side_mission, not de.
:- not side_mission, de.

#show node/1.
#show edge_d/2.