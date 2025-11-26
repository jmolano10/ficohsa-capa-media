xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/XMLSchema_-1855765488.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/payRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/payRemittancesTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $pagoRemesas as element() (:: schema-element(ns1:pagoRemesas) ::) external;
declare variable $pagoderemesaFTResponse as element() (:: schema-element(ns2:PagoderemesaFTResponse) ::) external;

declare function xq:pagoRemesaT24Out($pagoRemesas as element() (:: schema-element(ns1:pagoRemesas) ::), 
                                     $pagoderemesaFTResponse as element() (:: schema-element(ns2:PagoderemesaFTResponse) ::)) 
                                     as element() (:: schema-element(ns1:pagoRemesas) ::) {
    <ns1:pagoRemesas>
        <ns1:REMITTANCE_ID>{fn:data($pagoRemesas/ns1:REMITTANCE_ID)}</ns1:REMITTANCE_ID>
        <ns1:REMITTER_ID>{fn:data($pagoRemesas/ns1:REMITTER_ID)}</ns1:REMITTER_ID>
        <ns1:BENEFICIARY_INFO>
            <ns1:ID>{fn:data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ID)}</ns1:ID>
                {
                    let $LRDATEBIRTH := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ID_ISSUE_DATE
                    return
                    if ($LRDATEBIRTH != '') then(
                    	<ID_ISSUE_DATE>{ data($LRDATEBIRTH) }</ID_ISSUE_DATE>
                    )else(
                    	<ID_ISSUE_DATE>{data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRDATEBIRTH)}</ID_ISSUE_DATE>
                    
                    )
                        
                }
                {
                    let $LRNAME := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:NAME
                    return
                    if($LRNAME != '') then(
                    	<NAME>{ data($LRNAME) }</NAME>
                    )else(
                    	<NAME>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRNAME) }</NAME>
                    )
                        
                }
                {
                    let $LRIDENTYPE := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ID_TYPE 
                    return
                    if($LRIDENTYPE != '') then(
                    	<ID_TYPE>{ data($LRIDENTYPE) }</ID_TYPE>
                    )else(
                    	<ID_TYPE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRIDENTYPE) }</ID_TYPE>
                    )
                        
                }
                {
                    let $ADDRESSTYPE :=  $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ADDRESS_TYPE
                    return
                    if($ADDRESSTYPE != '') then(
                    	<ADDRESS_TYPE>{ data($ADDRESSTYPE) }</ADDRESS_TYPE>
                    )else(
                    	<ADDRESS_TYPE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/ADDRESSTYPE) }</ADDRESS_TYPE>
                    )
                        
                }
                {
                    let $CITYCODE := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:CITY
                    return
                    if($CITYCODE != '') then(
                    	<CITY>{ data($CITYCODE) }</CITY>
                    )else(
                    	<CITY>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/CITYCODE) }</CITY>
                    )
                }
                {
                    let $STATECODE := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:STATE
                    return
                    if($STATECODE != '') then(
                    	<STATE>{ data($STATECODE) }</STATE>
                    )else(
                    	<STATE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/STATECODE) }</STATE>
                    )                        
                }
                {
                    let $COUNTRYCODE := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:COUNTRY
                    return
                    if($COUNTRYCODE != '') then(   
                        <COUNTRY>{ data($COUNTRYCODE) }</COUNTRY>
                    )else(
                    	<COUNTRY>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/COUNTRYCODE) }</COUNTRY>
                    )
                }>
                {
                    let $COLONYCODE := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:NEIGHBORHOOD
                    return
                    if($COLONYCODE != '') then(
                        <NEIGHBORHOOD>{ data($COLONYCODE) }</NEIGHBORHOOD>
                    )else(
                    	<NEIGHBORHOOD>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/COLONYCODE) }</NEIGHBORHOOD>
                    )
                }
                {
                        let $TELEPHONEREFER := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:PHONE_TYPE
                        return
                        if($TELEPHONEREFER != '')then(
                        	<PHONE_TYPE>{ data($TELEPHONEREFER) }</PHONE_TYPE>
                        )else(
                        	<PHONE_TYPE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gTELEPHONE.REFER/TELEPHONEREFER) }</PHONE_TYPE>
                        )
                            
                }
                {
                    let $LRREMITMOBILE := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:PHONE_NUMBER
                    return
                    if($LRREMITMOBILE != '') then(
                        <PHONE_NUMBER>{ data($LRREMITMOBILE) }</PHONE_NUMBER>
                    )else(
                    	<PHONE_NUMBER>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRREMITMOBILE) }</PHONE_NUMBER>
                    )
                }
                {
                        let $LROCCUPATION := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:OCCUPATION
                        return
                        if ($LROCCUPATION != '') then (
                        	<OCCUPATION>{ data($LROCCUPATION) }</OCCUPATION>
                        ) else(
                        	<OCCUPATION>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gLR.OCCUPATION/LROCCUPATION) }</OCCUPATION>
                        )
                            
                }
                {
                    let $SRCOFINCOME := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:INCOME_SOURCE
                    return
                    if($SRCOFINCOME != '') then(
                        <INCOME_SOURCE>{ data($SRCOFINCOME) }</INCOME_SOURCE>
                    )else(
                    	<INCOME_SOURCE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/SRCOFINCOME) }</INCOME_SOURCE>
                    )
                }
                {
                    let $LRDATEOFBIR := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:DATE_OF_BIRTH
                    return
                    if($LRDATEOFBIR != '') then(
                        <DATE_OF_BIRTH>{ data($LRDATEOFBIR) }</DATE_OF_BIRTH>
                    )else(
                    	<DATE_OF_BIRTH>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRDATEOFBIR) }</DATE_OF_BIRTH>
                    )
                }
                {
                	let $COMPLETEADDRES := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ADDRESS
                    return
                    if($COMPLETEADDRES != '') then(
                        <ADDRESS>{ data($COMPLETEADDRES) }</ADDRESS>
                    )else(
                    	<ADDRESS>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/COMPLETEADDRES) }</ADDRESS>
                    )
                }
                {
                    for $THIRDPARTY_INFO in $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:THIRDPARTY_INFO
                    return
                        <THIRDPARTY_INFO>
                            <ID>{ concat($THIRDPARTY_INFO/ns1:ID , $pagoderemesaFTResponse/FUNDSTRANSFERType/LRIDUSERFN) }</ID>
                            <NAME>{ concat($THIRDPARTY_INFO/ns1:NAME , $pagoderemesaFTResponse/FUNDSTRANSFERType/LRNAMEUSERFN) }</NAME>
                            <RELATIONSHIP>{ concat($THIRDPARTY_INFO/ns1:RELATIONSHIP , $pagoderemesaFTResponse/FUNDSTRANSFERType/RELWTHPERREF) }</RELATIONSHIP>
                        </THIRDPARTY_INFO>
                }
                {
                        
                    let $GENDER := $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:GENDER
	                return
	                if ($GENDER != '') then(
	                	<GENDER>{data($GENDER)}</GENDER>
	                ) else(	                	
		                if ($pagoderemesaFTResponse/FUNDSTRANSFERType/LRGENDER = "01" ) then (
		                    <GENDER>M</GENDER>
		                ) else if ($pagoderemesaFTResponse/FUNDSTRANSFERType/LRGENDER = "02") then(
		                    <GENDER>F</GENDER>
		                )else() 
	                ) 
                }
        </ns1:BENEFICIARY_INFO>
                {
                    let $CREDIT_ACCOUNT := $pagoRemesas/ns1:CREDIT_ACCOUNT
                    return
                    if($CREDIT_ACCOUNT != '') then(
                        <CREDIT_ACCOUNT>{ data($CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>
                    )else(
                    	<CREDIT_ACCOUNT>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/CREDITACCTNO) }</CREDIT_ACCOUNT>
                    )
                }            
            <BRANCHCODE>{ data($pagoRemesas/ns1:BRANCHCODE) }</BRANCHCODE>
            <TELLERID>{ data($pagoRemesas/ns1:TELLERID) }</TELLERID>
            <REFERENCE_NUMBER>{ data($pagoRemesas/ns1:REFERENCE_NUMBER) }</REFERENCE_NUMBER>
            {
                for $ADDITIONAL_INFO in $pagoRemesas/ns1:ADDITIONAL_INFO
                return
                    <ADDITIONAL_INFO>{ $ADDITIONAL_INFO/@* , $ADDITIONAL_INFO/node() }</ADDITIONAL_INFO>
            }        
    </ns1:pagoRemesas>
};

xq:pagoRemesaT24Out($pagoRemesas, $pagoderemesaFTResponse)
