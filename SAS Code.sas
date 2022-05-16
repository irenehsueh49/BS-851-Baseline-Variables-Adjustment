/******************** Irene Hsueh's BS 851 Homework 4 ********************/

proc format;
	value $trt_format "Denerv2"="Treatment";
	value gender_format 0="Male" 1="Female";
	value hypertension_format 0="No" 1="Yes";
run;

libname homework "C:/Irene Hsueh's Documents/MS Applied Biostatistics/BS 851 - Applied Statistics in Clinical Trials I/Class 4 - Baseline Variables Adjustment/Homework 4";
data hypertension;
	set homework.anti_htn;
	drop pt;
	label trt="Treatment" Female="Gender" htn="Hypertension";
	format trt $trt_format. Female gender_format. htn hypertension_format.;
run;

proc print data=hypertension label;
run;




/* Question 2 */
title "Categorical Variables Statistics by Treatment";
proc freq data=hypertension;
	by trt;
	tables female site htn / norow nopercent;
run;
title;

title "Categorical Variables Statistics";
proc freq data=hypertension;
	tables female site htn / nocum;
run;
title;

title "Continuous Variables Statistics by Treatment";
proc means data=hypertension;
	class trt;
	var sbp_base sbp_reduction_12m;
run;
title;

title "Continuous Variables Statistics by Treatment";
proc means data=hypertension;
	var sbp_base sbp_reduction_12m;
run;
title;




/* Question 3 */
title "Adjusted Linear Regression";
proc glm data=hypertension;
	class trt (ref="Placebo") site (ref="1");
	model sbp_reduction_12m = trt site / solution clparm;
run; 
title;




/* Question 4 */
title "ANCOVA";
proc glm data=hypertension;
	class trt (ref="Placebo") site (ref="1");
	model sbp_reduction_12m = trt site sbp_base / solution clparm;
run; 
title;


title "Correlation Matrix";
proc corr data=hypertension;
	var sbp_reduction_12m sbp_base;
run;
title;



/* Question 6 */ 
title "Adjusted Logistic Regression";
proc logistic data=hypertension;
	class trt (ref="Placebo") site (ref="1") / param=ref;
	model htn (event="Yes")= trt site / risklimits;
run;
quit;
title;




ODS HTML CLOSE;
ODS HTML;
