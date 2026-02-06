xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadatosPEPResponse" element="ns0:ConsultadatosPEPResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPEPResponse" location="../../ConsultaListasRegulatorias/xsd/consultaListasRegulatoriasTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaListasRegulatoriasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPEP/xq/ConsultadatosPEPOut/";

declare function xf:ConsultadatosPEPOut($consultadatosPEPResponse as element(ns0:ConsultadatosPEPResponse))
    as element(ns1:consultaPEPResponse) {
        <ns1:consultaPEPResponse>
            <IS_PUBLIC_FIGURE>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/ISPUBLICFIGURE) }</IS_PUBLIC_FIGURE>
            <PUBLIC_POSITION>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/ACTUALPUBLICCHARGE) }</PUBLIC_POSITION>
            <PERIOD_PEP_POSITION>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/PUBLICCHARGEPERIOD) }</PERIOD_PEP_POSITION>
            <INSTITUTION>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/INSTITUTIONNAME) }</INSTITUTION>
            <HAS_FAMILY_PEP>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/HASPUBLICFIGUREFAM) }</HAS_FAMILY_PEP>
            {
	            if(fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/HASPUBLICFIGUREFAM/text()) = ("SI")) then (
		            <FAMILY_MEMBERS>
					{	
	            		let $FULLNAME1 :=  fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/FULLNAME1/text())
	            		let $CHANGE1 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/CHARGE1/text())
	            		let $PERIOD1 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/PERIOD1/text())
	            		return
	            		(
		            		if($FULLNAME1 != "" or $CHANGE1 != "" or $PERIOD1 != "")then(
		            			<FAMILY>
				            		<NAME>{ data($FULLNAME1) }</NAME>
				           		 	<POSITION>{ data($CHANGE1) }</POSITION>
				            		<PERIOD>{ data($PERIOD1) }</PERIOD>
				       			 </FAMILY>
		            		)else()
		            		
		            	)
					}
					{
		            	let $FULLNAME2 :=  fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/FULLNAME2/text())
	            		let $CHANGE2 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/CHARGE2/text())
	            		let $PERIOD2 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/PERIOD2/text())
	            		return
	            		(
		            		if($FULLNAME2 != "" or $CHANGE2!= "" or $PERIOD2 != "")then(
		            			<FAMILY>
				            		<NAME>{ data($FULLNAME2) }</NAME>
				           		 	<POSITION>{ data($CHANGE2) }</POSITION>
				            		<PERIOD>{ data($PERIOD2) }</PERIOD>
				       			 </FAMILY>
		            		)else()
		            	)
	            	  }
	            	  {
		            	let $FULLNAME3 :=  fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/FULLNAME3/text())
	            		let $CHANGE3 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/CHARGE3/text())
	            		let $PERIOD3 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/PERIOD3/text())
	            		return
	            		(
		            		if($FULLNAME3 != "" or $CHANGE3!= "" or $PERIOD3 != "")then(
		            			<FAMILY>
				            		<NAME>{ data($FULLNAME3) }</NAME>
				           		 	<POSITION>{ data($CHANGE3) }</POSITION>
				            		<PERIOD>{ data($PERIOD3) }</PERIOD>
				       			 </FAMILY>
		            		)else()
		            	)
	            	  }
	            	  {
		            	let $FULLNAME4 :=  fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/FULLNAME4/text())
	            		let $CHANGE4 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/CHARGE4/text())
	            		let $PERIOD4 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/PERIOD4/text())
	            		return
	            		(
		            		if($FULLNAME4 != "" or $CHANGE4!= "" or $PERIOD4 != "")then(
		            			<FAMILY>
				            		<NAME>{ data($FULLNAME4) }</NAME>
				           		 	<POSITION>{ data($CHANGE4) }</POSITION>
				            		<PERIOD>{ data($PERIOD4) }</PERIOD>
				       			 </FAMILY>
		            		)else()
		            	)
	            	  }
		              {
		            	let $FULLNAME5 :=  fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/FULLNAME5/text())
	            		let $CHANGE5 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/CHARGE5/text())
	            		let $PERIOD5 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/PERIOD5/text())
	            		return
	            		(
		            		if($FULLNAME5 != "" or $CHANGE5!= "" or $PERIOD5 != "")then(
		            			<FAMILY>
				            		<NAME>{ data($FULLNAME5) }</NAME>
				           		 	<POSITION>{ data($CHANGE5) }</POSITION>
				            		<PERIOD>{ data($PERIOD5) }</PERIOD>
				       			 </FAMILY>
		            		)else()
		            	)
	            	  } 
		            </FAMILY_MEMBERS>
		        )else(
		        	 <FAMILY_MEMBERS/>
		        )
		     }
            <MOTHER_NAME>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/MOTHERSFULLNAME) }</MOTHER_NAME>
            <FATHER_NAME>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/FATHERSFULLNAME) }</FATHER_NAME>
            <CHILDRENS>
        	{	
        		let $SONSNAME1 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/SONSNAME1/text())
        		return
        		(
            		if($SONSNAME1 != "")then(
            			<CHILDRENS_TYPES>
           					 <CHLIDREN_NAME>{ data($SONSNAME1) }</CHLIDREN_NAME>
       					</CHILDRENS_TYPES>
            		)else()
            		
            	)
			}
            {	
        		let $SONSNAME2 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/SONSNAME2/text())
        		return
        		(
            		if($SONSNAME2 != "")then(
            			<CHILDRENS_TYPES>
           					 <CHLIDREN_NAME>{ data($SONSNAME2) }</CHLIDREN_NAME>
       					</CHILDRENS_TYPES>
            		)else()
            		
            	)
			}
			{	
        		let $SONSNAME3 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/SonsFullname3/text())
        		return
        		(
            		if($SONSNAME3 != "")then(
            			<CHILDRENS_TYPES>
           					 <CHLIDREN_NAME>{ data($SONSNAME3) }</CHLIDREN_NAME>
       					</CHILDRENS_TYPES>
            		)else()
            		
            	)
			}
			{	
        		let $SONSNAME4 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/SONSFULLNAME3/text())
        		return
        		(
            		if($SONSNAME4 != "")then(
            			<CHILDRENS_TYPES>
           					 <CHLIDREN_NAME>{ data($SONSNAME4) }</CHLIDREN_NAME>
       					</CHILDRENS_TYPES>
            		)else()
            		
            	)
			} 
			{	
        		let $SONSNAME5 := fn:string($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/SONSFULLNAME5/text())
        		return
        		(
            		if($SONSNAME5 != "")then(
            			<CHILDRENS_TYPES>
           					 <CHLIDREN_NAME>{ data($SONSNAME5) }</CHLIDREN_NAME>
       					</CHILDRENS_TYPES>
            		)else()
            		
            	)
			}       
            </CHILDRENS>
            <AUTH_NAME>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/AUTHFULLNAME) }</AUTH_NAME>
            <AUTH_POSITION>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/CHARGE) }</AUTH_POSITION>
            <AUTH_DATE>{ data($consultadatosPEPResponse/WSCUSTPEPAPType[1]/gWSCUSTPEPAPDetailType/mWSCUSTPEPAPDetailType[1]/AUTHDATE) }</AUTH_DATE>
        </ns1:consultaPEPResponse>
};

declare variable $consultadatosPEPResponse as element(ns0:ConsultadatosPEPResponse) external;

xf:ConsultadatosPEPOut($consultadatosPEPResponse)