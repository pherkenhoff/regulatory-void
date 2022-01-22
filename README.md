Replication files for the paper "The International Organization of Production in the Regulatory Void" by P. Herkenhoff and S. Krautheim
===========

This folder contains all the codes and data needed to compute the results of the paper "The International Organization of Production in the Regulatory Void"
by Philipp Herkenhoff and Sebastian Krautheim, Journal of International Economics (2022), https://doi.org/10.1016/j.jinteco.2022.103572.

* The folder “code” contains the do-file “MASTER”, which calls several other do-files in that folder to produce the corresponding tables from the main paper
and the online appendix. 
* The folder “data” contains our data files based on which all results are produced. Please see the paper’s Online Appendix for details on our data sources.
* All the tables produced by the code and are saved in the folder “results”.

Note that our results were obtained using proprietary data which we are not allowed to publish. This concerns R&D intensity,
which we use as a standard control variable. The corresponding variables in the dataset, “randd_intensity” and “randd_intensity_ln_AY”, are therefore set
to missing. We have included an alternative variable for R&D intensity, “lus_randd_intensity_0005_AC2013”, which comes from the replication dataset of 
Antràs and Chor (2013, Econometrica). The code is set to run all regressions and produce all tables using this variable. The results are qualitatively 
identical to those reported in the paper and the online appendix. In many cases, they are even very similar numerically. 

* The folder "tables_in_paper" contains the raw excel tables that are reported in the paper. They are generated using the proprietary R&D intensity measure. 
