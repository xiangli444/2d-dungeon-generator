% To customize cycles:
repeat(1, 2).
secret(1, 2, 4).
secret(2, 2, 2).

{ring(N, repeat(N1, Y)):node(N)} = 1 :- Y=1..N2, repeat(N1, N2).
{ring(N, secret(N1, Y)):node(N)} = 1 :- Y=1..N3, secret(N1, N2, N3).

ring(N):- ring(N, repeat(N1, N2)).
ring(N):- ring(N, secret(N1, N2)).
:- not ring(N), direction(N, N).

in_ring(N, repeat(N1)):- ring(N, repeat(N1, N2)).
in_ring(N, secret(N1)):- ring(N, secret(N1, N2)).

:- ring(N, repeat(_, _)),ring(N, secret(_, _)).
:- ring(N, repeat(N1, _)),ring(N, repeat(N2, _)), N1!=N2.
:- ring(N, secret(N1, _)),ring(N, secret(N2, _)), N1!=N2.
:- ring(N, repeat(N1, N2)),ring(N, repeat(N1, N3)), N2!=N3.
:- ring(N, secret(N1, N2)),ring(N, secret(N1, N3)), N2!=N3.

edge_d(N1, N2):- ring(N1, repeat(X, Y)), ring(N2, repeat(X, Y+1)).
edge_d(N1, N2):- ring(N1, repeat(X, Y)), ring(N2, repeat(X, 1)), repeat(X, Y).

edge_d(N1, N2):- ring(N1, secret(X, Y)), ring(N2, secret(X, Y+1)).
edge_d(N1, N2):- ring(N1, secret(X, Z)), ring(N2, secret(X, 1)), secret(X, Y, Z).


smr(N2, repeat(X)):- smr(N1, repeat(X)), edge_d(N1, N2).
smr(N1, repeat(X)):- ring(N, repeat(X, Y1)), Y1!=1, edge_d(N, N1), not in_ring(N1, repeat(X)).

smr(N2, secret(X)):- smr(N1, secret(X)), edge_d(N1, N2).
smr(N1, secret(X)):- ring(N, secret(X, Y1)), secret(X, Y, Z), Y1<Y, edge_d(N, N1), not in_ring(N1, secret(X)).

:- smr(end, repeat(X)).
:- smr(N, repeat(X)), ring(N).
:- smr(end, secret(X)).
:- smr(N, secret(X)), ring(N).

:- not smr(N, repeat(X)), edge_d(N, N1), smr(N1, repeat(X)), repeat(X, Y), not in_ring(N, repeat(X)).
in_secret(N, secret(X)):- ring(N, secret(X, Y1)), secret(X, Y, Z), Y1<Y.
:- not smr(N, secret(X)), edge_d(N, N1), smr(N1, secret(X)), secret(X, Y, Z), not in_secret(N, secret(X)).

:- ring(N, secret(X, Y)), secret(X, Y, Z), not bh(N).
:- ring(N, secret(X, Y1)), secret(X, Y, Z), Y1!=Z, edge_d(N, N1), ring(N1, secret(X, 1)). 

be(N) :- node(N), {edge_d(N1, N): node(N1)} > 1.
:- ring(N, repeat(X, Y1)), be(N), repeat(X, Y), 1<Y1<=Y. 
:- ring(N, secret(X, Z1)), be(N), secret(X, Y, Z), 1<Z1<=Z. 