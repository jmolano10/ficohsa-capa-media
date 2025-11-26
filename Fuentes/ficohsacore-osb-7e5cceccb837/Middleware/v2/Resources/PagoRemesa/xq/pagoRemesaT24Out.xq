(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns1:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoderemesaFTResponse" element="ns0:PagoderemesaFTResponse" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoRemesaT24Out/";

declare function xf:pagoRemesaT24Out($pagoRemesas as element(ns1:pagoRemesas),
    $pagoderemesaFTResponse as element(ns0:PagoderemesaFTResponse))
    as element(ns1:pagoRemesas) {
        <ns1:pagoRemesas>
            <REMITTANCE_ID>{ data($pagoRemesas/REMITTANCE_ID) }</REMITTANCE_ID>
            <REMITTER_ID>{ data($pagoRemesas/REMITTER_ID) }</REMITTER_ID>
            <BENEFICIARY_INFO>
                <ID>{ data($pagoRemesas/BENEFICIARY_INFO/ID) }</ID>
                {
                    let $LRDATEBIRTH := $pagoRemesas/BENEFICIARY_INFO/ID_ISSUE_DATE
                    return
                    if ($LRDATEBIRTH != '') then(
                    	<ID_ISSUE_DATE>{ data($LRDATEBIRTH) }</ID_ISSUE_DATE>
                    )else(
                    	<ID_ISSUE_DATE>{data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRDATEBIRTH)}</ID_ISSUE_DATE>
                    
                    )
                        
                }
                {
                    let $LRNAME := $pagoRemesas/BENEFICIARY_INFO/NAME
                    return
                    if($LRNAME != '') then(
                    	<NAME>{ data($LRNAME) }</NAME>
                    )else(
                    	<NAME>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRNAME) }</NAME>
                    )
                        
                }
                {
                    let $LRIDENTYPE := $pagoRemesas/BENEFICIARY_INFO/ID_TYPE 
                    return
                    if($LRIDENTYPE != '') then(
                    	<ID_TYPE>{ data($LRIDENTYPE) }</ID_TYPE>
                    )else(
                    	<ID_TYPE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRIDENTYPE) }</ID_TYPE>
                    )
                        
                }
                {
                    let $ADDRESSTYPE :=  $pagoRemesas/BENEFICIARY_INFO/ADDRESS_TYPE
                    return
                    if($ADDRESSTYPE != '') then(
                    	<ADDRESS_TYPE>{ data($ADDRESSTYPE) }</ADDRESS_TYPE>
                    )else(
                    	<ADDRESS_TYPE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/ADDRESSTYPE) }</ADDRESS_TYPE>
                    )
                        
                }
                {
                    let $CITYCODE := $pagoRemesas/BENEFICIARY_INFO/CITY
                    return
                    if($CITYCODE != '') then(
                    	<CITY>{ data($CITYCODE) }</CITY>
                    )else(
                    	<CITY>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/CITYCODE) }</CITY>
                    )
                }
                {
                    let $STATECODE := $pagoRemesas/BENEFICIARY_INFO/STATE
                    return
                    if($STATECODE != '') then(
                    	<STATE>{ data($STATECODE) }</STATE>
                    )else(
                    	<STATE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/STATECODE) }</STATE>
                    )                        
                }
                {
                    let $COUNTRYCODE := $pagoRemesas/BENEFICIARY_INFO/COUNTRY
                    return
                    if($COUNTRYCODE != '') then(   
                        <COUNTRY>{ data($COUNTRYCODE) }</COUNTRY>
                    )else(
                    	<COUNTRY>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/COUNTRYCODE) }</COUNTRY>
                    )
                }
                {
                    let $COLONYCODE := $pagoRemesas/BENEFICIARY_INFO/NEIGHBORHOOD
                    return
                    if($COLONYCODE != '') then(
                        <NEIGHBORHOOD>{ data($COLONYCODE) }</NEIGHBORHOOD>
                    )else(
                    	<NEIGHBORHOOD>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/COLONYCODE) }</NEIGHBORHOOD>
                    )
                }
                {
                        let $TELEPHONEREFER := $pagoRemesas/BENEFICIARY_INFO/PHONE_TYPE
                        return
                        if($TELEPHONEREFER != '')then(
                        	<PHONE_TYPE>{ data($TELEPHONEREFER) }</PHONE_TYPE>
                        )else(
                        	<PHONE_TYPE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gTELEPHONE.REFER/TELEPHONEREFER) }</PHONE_TYPE>
                        )
                            
                }
                {
                    let $LRREMITMOBILE := $pagoRemesas/BENEFICIARY_INFO/PHONE_NUMBER
                    return
                    if($LRREMITMOBILE != '') then(
                        <PHONE_NUMBER>{ data($LRREMITMOBILE) }</PHONE_NUMBER>
                    )else(
                    	<PHONE_NUMBER>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRREMITMOBILE) }</PHONE_NUMBER>
                    )
                }
                {
                        let $LROCCUPATION := $pagoRemesas/BENEFICIARY_INFO/OCCUPATION
                        return
                        if ($LROCCUPATION != '') then (
                        	<OCCUPATION>{ data($LROCCUPATION) }</OCCUPATION>
                        ) else(
                        	<OCCUPATION>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gLR.OCCUPATION/LROCCUPATION) }</OCCUPATION>
                        )
                            
                }
                {
                    let $SRCOFINCOME := $pagoRemesas/BENEFICIARY_INFO/INCOME_SOURCE
                    return
                    if($SRCOFINCOME != '') then(
                        <INCOME_SOURCE>{ data($SRCOFINCOME) }</INCOME_SOURCE>
                    )else(
                    	<INCOME_SOURCE>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/SRCOFINCOME) }</INCOME_SOURCE>
                    )
                }
                {
                    let $LRDATEOFBIR := $pagoRemesas/BENEFICIARY_INFO/DATE_OF_BIRTH
                    return
                    if($LRDATEOFBIR != '') then(
                        <DATE_OF_BIRTH>{ data($LRDATEOFBIR) }</DATE_OF_BIRTH>
                    )else(
                    	<DATE_OF_BIRTH>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/LRDATEOFBIR) }</DATE_OF_BIRTH>
                    )
                }
                {
                	let $COMPLETEADDRES := $pagoRemesas/BENEFICIARY_INFO/ADDRESS
                    return
                    if($COMPLETEADDRES != '') then(
                        <ADDRESS>{ data($COMPLETEADDRES) }</ADDRESS>
                    )else(
                    	<ADDRESS>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/gADDRESS.TYPE/mADDRESS.TYPE[1]/COMPLETEADDRES) }</ADDRESS>
                    )
                }
                {
                    for $THIRDPARTY_INFO in $pagoRemesas/BENEFICIARY_INFO/THIRDPARTY_INFO
                    return
                        <THIRDPARTY_INFO>
                            <ID>{ concat($THIRDPARTY_INFO/ID , $pagoderemesaFTResponse/FUNDSTRANSFERType/LRIDUSERFN) }</ID>
                            <NAME>{ concat($THIRDPARTY_INFO/NAME , $pagoderemesaFTResponse/FUNDSTRANSFERType/LRNAMEUSERFN) }</NAME>
                            <RELATIONSHIP>{ concat($THIRDPARTY_INFO/RELATIONSHIP , $pagoderemesaFTResponse/FUNDSTRANSFERType/RELWTHPERREF) }</RELATIONSHIP>
                        </THIRDPARTY_INFO>
                }
                {
                        
                    let $GENDER := $pagoRemesas/BENEFICIARY_INFO/GENDER
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
            </BENEFICIARY_INFO>
                {
                    let $CREDIT_ACCOUNT := $pagoRemesas/CREDIT_ACCOUNT
                    return
                    if($CREDIT_ACCOUNT != '') then(
                        <CREDIT_ACCOUNT>{ data($CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>
                    )else(
                    	<CREDIT_ACCOUNT>{ data($pagoderemesaFTResponse/FUNDSTRANSFERType/CREDITACCTNO) }</CREDIT_ACCOUNT>
                    )
                }
            <BRANCHCODE>{ data($pagoRemesas/BRANCHCODE) }</BRANCHCODE>
            <TELLERID>{ data($pagoRemesas/TELLERID) }</TELLERID>
            <REFERENCE_NUMBER>{ data($pagoRemesas/REFERENCE_NUMBER) }</REFERENCE_NUMBER>
            {
                for $ADDITIONAL_INFO in $pagoRemesas/ADDITIONAL_INFO
                return
                    <ADDITIONAL_INFO>{ $ADDITIONAL_INFO/@* , $ADDITIONAL_INFO/node() }</ADDITIONAL_INFO>
            }
        </ns1:pagoRemesas>
};

declare variable $pagoRemesas as element(ns1:pagoRemesas) external;
declare variable $pagoderemesaFTResponse as element(ns0:PagoderemesaFTResponse) external;

xf:pagoRemesaT24Out($pagoRemesas,
    $pagoderemesaFTResponse)