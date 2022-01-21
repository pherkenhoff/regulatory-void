
******************************************************
*** TABLES OA.10 and OA.11: CROSS-COUNTRY DIMENSION ***
******************************************************


	capture drop sample*
	capture est drop _all
	
	capture erase ".\results\table_OA10.csv"
	capture erase ".\results\table_OA11.csv"
	
	
		

	foreach n in TC {
		foreach m in EPSI HLT EPI {
			
			
			reghdfe rel_share c.${ECSP_`n'}#c.${`m'} ${`m'}, absorb(year_ind) vce(cluster i.IO2007_num)
				est store regr_`n'_`m'
				estfe regr_`n'_`m', labels(year_ind "Industry-Year FE")
				est restore regr_`n'_`m'
				margins, post dydx(${`m'}) at((p5) ${ECSP_`n'}) at((p10) ${ECSP_`n'}) at( (p20) ${ECSP_`n'}) at( (p30) ${ECSP_`n'}) at( (p40) ${ECSP_`n'}) at( (p50) ${ECSP_`n'}) at( (p60) ${ECSP_`n'}) at( (p70) ${ECSP_`n'}) at( (p80) ${ECSP_`n'}) at( (p90) ${ECSP_`n'})
				est store marg_`n'_`m'

			reghdfe rel_share  c.${ECSP_`n'}#c.${`m'} ${`m'} ${HO_interact_all_`n'} ${contract_interact}, absorb(year_ind) vce(cluster i.IO2007_num)
				est store regr_`n'_`m'_HOcontr
				estfe regr_`n'_`m'_HOcontr, labels(year_ind "Industry-Year FE")
				est restore regr_`n'_`m'_HOcontr
				margins, post dydx(${`m'}) at((p5) ${ECSP_`n'}) at((p10) ${ECSP_`n'}) at( (p20) ${ECSP_`n'}) at( (p30) ${ECSP_`n'}) at( (p40) ${ECSP_`n'}) at( (p50) ${ECSP_`n'}) at( (p60) ${ECSP_`n'}) at( (p70) ${ECSP_`n'}) at( (p80) ${ECSP_`n'}) at( (p90) ${ECSP_`n'})
				est store marg_`n'_`m'_HOcontr

			reghdfe rel_share c.${ECSP_`n'}#c.${`m'} ${`m'} ${HO_interact_all_`n'} ${contract_interact} ${credit_interact_noind} ${labormarket_interact_noind} ${interm_interact_noind}, absorb(year_ind) vce(cluster i.IO2007_num)
				est store regr_`n'_`m'_allcontr
				estfe regr_`n'_`m'_allcontr, labels(year_ind "Industry-Year FE")
				est restore regr_`n'_`m'_allcontr
				margins, post dydx(${`m'}) at((p5) ${ECSP_`n'}) at((p10) ${ECSP_`n'}) at( (p20) ${ECSP_`n'}) at( (p30) ${ECSP_`n'}) at( (p40) ${ECSP_`n'}) at( (p50) ${ECSP_`n'}) at( (p60) ${ECSP_`n'}) at( (p70) ${ECSP_`n'}) at( (p80) ${ECSP_`n'}) at( (p90) ${ECSP_`n'})
				est store marg_`n'_`m'_allcontr
				
			
			}
		}	

		
		esttab regr* using ".\results\table_OA10.csv", replace scsv ///
					cells(b(fmt(a) star) se(par(( )) fmt(a))) order(c.waste_int_ln_totalcost_2#* E* H* ) /// 
					stats(N_clust r2_a N, fmt(a) labels("IO2007 Industry Clusters" "Adj. R2" "Observations")) /// 
					obslast starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) title("Dependent Variable: Intrafirm Import Share") ///
					mlabels(EPSI EPSI EPSI HLT HLT HLT EPI EPI EPI, lhs(Intensity Definition: Total Cost, Environmental Index:)) ///
					label interact(" X ") noomit indicate(`r(indicate_fe)')
					
		esttab marg* using ".\results\table_OA11.csv", replace scsv ///
					cells(b(fmt(a) star) se(par(( )) fmt(a))) ///
					noobs starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) label ///
					mlabels(EPSI EPSI EPSI HLT HLT HLT EPI EPI EPI, lhs(ENVI:)) coeflabels(waste_int_ln_totalcost_2 "Percentile")
