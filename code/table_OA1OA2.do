

********************************************************
***TABLES OA.1 and OA.2: MAIN SPECIFICATIONS WITH EPI***
********************************************************

	capture drop sample*
	capture est drop _all
	
	capture erase ".\results\table_OA1.csv"
	capture erase ".\results\table_OA2.csv"
	
	foreach n in TC {
			reghdfe rel_share ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
				est store regr_`n'_noECSP
				estfe regr_`n'_noECSP, labels(year_iso3code "Country-Year FE")
			reghdfe rel_share ${ECSP_`n'} ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
				est store regr_`n'_ECSP
				estfe regr_`n'_ECSP, labels(year_iso3code "Country-Year FE")
			
		foreach m in EPI {
			
			reghdfe rel_share ${ECSP_`n'}  c.${ECSP_`n'}#c.`m' ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
				est store regr_`n'_`m'
				estfe regr_`n'_`m', labels(year_iso3code "Country-Year FE")
				est restore regr_`n'_`m'
				margins, post dydx(${ECSP_`n'}) at((p5) `m') at((p10) `m') at( (p20) `m') at( (p30) `m') at( (p40) `m') at( (p50) `m') at( (p60) `m') at( (p70) `m') at( (p80) `m') at( (p90) `m')
				est store marg_`n'_`m'
			
			reghdfe rel_share ${ECSP_`n'}  c.${ECSP_`n'}#c.`m' ${AYcontrols_`n'} ${HO_interact_all_nocou_`n'} ${contract_interact_nocou}, absorb(year_iso3code) vce(cluster i.IO2007_num)
				gen sample_`n'_`m' = 1 if e(sample)	
				est store regr_`n'_`m'_HOcontr
				estfe regr_`n'_`m'_HOcontr, labels(year_iso3code "Country-Year FE")
				est restore regr_`n'_`m'_HOcontr
				margins, post dydx(${ECSP_`n'}) at((p5) `m') at((p10) `m') at( (p20) `m') at( (p30) `m') at( (p40) `m') at( (p50) `m') at( (p60) `m') at( (p70) `m') at( (p80) `m') at( (p90) `m')
				est store marg_`n'_`m'_HOcontr
			
			reghdfe rel_share ${ECSP_`n'}  c.${ECSP_`n'}#c.`m' ${AYcontrols_`n'} ${disp} ${Antras_Chor} ${HO_interact_all_nocou_`n'} ${contract_interact_nocou} ${credit_interact_nocou} ${labormarket_interact_nocou} ${interm_interact}, absorb(year_iso3code) vce(cluster i.IO2007_num)
				est store regr_`n'_`m'_HOconcrelab
				estfe regr_`n'_`m'_HOconcrelab, labels(year_iso3code "Country-Year FE")
				est restore regr_`n'_`m'_HOconcrelab
				margins, post dydx(${ECSP_`n'}) at((p5) `m') at((p10) `m') at( (p20) `m') at( (p30) `m') at( (p40) `m') at( (p50) `m') at( (p60) `m') at( (p70) `m') at( (p80) `m') at( (p90) `m')
				est store marg_`n'_`m'_HOconcrelab
			
			reghdfe rel_share  c.${ECSP_`n'}#c.`m' ${HO_interact_all_nocou_`n'} ${credit_interact_nocou} ${labormarket_interact_nocou} ${contract_interact_nocou} ${interm_interact}, absorb(year_iso3code year_ind)  vce(cluster i.IO2007_num)
				est store regr_`n'_`m'_indfe
				estfe regr_`n'_`m'_indfe, labels(year_iso3code "Country-Year FE" year_ind "Industry-Year FE")
			

			}
		}	

		
		esttab regr* using ".\results\table_OA1.csv", replace scsv ///
					cells(b(fmt(a) star) se(par(( )) fmt(a))) order(waste* c.waste_int_ln_totalcost_2#*) drop(0.sigma_median_dummy) /// 
					stats(N_clust r2_a N, fmt(a) labels("IO2007 Industry Clusters" "Adj. R2" "Observations")) /// 
					obslast starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) title("Dependent Variable: Intrafirm Import Share") ///
					mlabels(- - EPI EPI EPI EPI, lhs(Intensity Definition: Total Cost, Environmental Index:)) ///
					label interact(" X ") noomit indicate(`r(indicate_fe)') 
		
		esttab marg* using ".\results\table_OA2.csv", replace scsv ///
					cells(b(fmt(a) star) se(par(( )) fmt(a))) ///
					noobs starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) label ///
					mlabels(EPI EPI EPI, lhs(ENVI:)) coeflabels(waste_int_ln_totalcost_2 "Percentile")
