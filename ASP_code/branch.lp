ring_edge(N1, N):- ring(N, repeat(X, 1)), ring(N1, repeat(X, Y)), repeat(X, Y).
ring_edge(N1, N):- ring(N, secret(X, 1)), ring(N1, secret(X, Z)), secret(X, Y, Z).

be_r(N) :- node(N), {edge_d(N1, N): node(N1), not ring_edge(N1, N)} > 1.

pl_min(N, N, 0):- be_r(N).
pl_min(N2, N, L+1):- edge_d(N2, N1), pl_min(N1, N, L), {pl_min(N2, N, L1): L1<=L}=0, L<puzzle_n+combat_n, not ring_edge(N2, N1).

b(N1, N):- pl_min(N1, N, _), pl_min(N2, N, _), pl_min(N3, N, _), N2!=N3, edge_d(N1, N2), edge_d(N1, N3), not ring_edge(N1, N2), not ring_edge(N1, N3).

:- b(N1, N), edge_d(N1, N2), pl_min(N1, N, X1), pl_min(N2, N, X2), X1-X2!=1, not pl_min(N1, N, 1).

{key(N3, (N1, N)):direction(N1, N3), pl_min(N3, N, 1), N3!=N1}=1:- pl_min(N1, N, 1), b(N1, N).

:- key(N, (N1, N2)),key(N, (N3, N4)), N1!=N3.
:- key(N, (N1, N2)),key(N, (N3, N4)), N2!=N4.

#show b/2.
#show key/2.