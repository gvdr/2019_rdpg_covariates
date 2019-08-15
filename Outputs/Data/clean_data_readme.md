## Disclaimer

Cleaned data from

[The ground truth about metadata and community detection in networks](http://advances.sciencemag.org/content/3/5/e1602548.full)
Leto Peel\*, Daniel B. Larremore\*, and Aaron Clauset.
Science Advances 3(5) e1602548.

as downloaded and munged from http://danlarremore.com/metadata/ and associated repos

all data rights as per original paper

Data is produced from /Code/Data_from_raw Rmd files

## Data Format

All data has been munged to be in the same shape and easily readable by any law-abiding computer user.

Each folder contains one `metadata.csv` file and at least one `adj(_xxx).csv` file.

### `metadata.csv`

Comma Separated Values file with the node metadata for the network.

First row gives the names of the variables.
the "names" column contains the unique ID (or names) of the nodes.

### `adj(_xxx).csv`

Comma Separated Values file with the adjacency matrices.
If more than one, make reference to http://danlarremore.com/metadata for their meaning (usually, repeated observation or different edge interpretations).

First row gives the names of the nodes matching the "names" in `metadata.csv`.
No rownames nor any column for ID.
