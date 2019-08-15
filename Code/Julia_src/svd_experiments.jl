using LightGraphs, MatrixDepot, SparseArrays, Arpack, MatrixNetworks

matrix_network_datasets()
A = load_matrix_network("dfs_example")
Acc,p = largest_component(A)


biggy = sprand(Int,
  10^6, 10^6,
  0.000001)
biggy_sim = (biggy + biggy')/2


using LinearAlgebra

biggy_eigs = eigs(biggy)

biggys
