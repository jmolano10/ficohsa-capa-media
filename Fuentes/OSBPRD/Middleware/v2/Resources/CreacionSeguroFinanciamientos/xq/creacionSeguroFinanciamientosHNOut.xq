xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$additionalAccountProductsAddResponse" element="ns0:AdditionalAccountProductsAddResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creacionSeguroFinanciamientosResponse" location="../xsd/creacionSeguroFinanciamientosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionSeguroFinanciamientos/xq/creacionSeguroFinanciamientosHNOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creacionSeguroFinanciamientosTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:creacionSeguroFinanciamientosHNOut($additionalAccountProductsAddResponse as element(ns0:AdditionalAccountProductsAddResponse))
    as element(ns1:creacionSeguroFinanciamientosResponse) {
        <ns1:creacionSeguroFinanciamientosResponse>
        {
                for $ARXINO-DUAL-IND in $additionalAccountProductsAddResponse/ARXINO-DUAL-IND
                return
                    <CURRENCY_INDICATOR>{ data($ARXINO-DUAL-IND) }</CURRENCY_INDICATOR>
            }
            	   {
                for $ARXINO-ORG in $additionalAccountProductsAddResponse/ARXINO-ORG
                return
                	if(string($ARXINO-ORG/text()) != "") then (  
                    	<ORG>{ data($additionalAccountProductsAddResponse/ARXINO-ORG) }</ORG>
                 	) else ()
            }           
            {
                for $ARXINO-ACCT-NBR in $additionalAccountProductsAddResponse/ARXINO-ACCT-NBR
                return
                    <ACCOUNT_NUMBER>{ data($ARXINO-ACCT-NBR) }</ACCOUNT_NUMBER>
            }
            {
                for $ARXINO-LOGO in $additionalAccountProductsAddResponse/ARXINO-LOGO
                return
                	if(string($ARXINO-LOGO/text()) != "") then (  
                    	<LOGO>{ data($ARXINO-LOGO) }</LOGO>
                 	) else ()
            }
            {
                for $ARXINO-INS-PROD-CODE in $additionalAccountProductsAddResponse/ARXINO-INS-PROD-CODE
                return
                    <INSURANCE_CODE>{ data($ARXINO-INS-PROD-CODE) }</INSURANCE_CODE>
            }
            {
                for $ARXINO-INS-STATUS-CODE in $additionalAccountProductsAddResponse/ARXINO-INS-STATUS-CODE
                return
                    <INSURANCE_STATUS>{ data($ARXINO-INS-STATUS-CODE) }</INSURANCE_STATUS>
            }
            </ns1:creacionSeguroFinanciamientosResponse>
        
};

declare variable $additionalAccountProductsAddResponse as element(ns0:AdditionalAccountProductsAddResponse) external;

xf:creacionSeguroFinanciamientosHNOut($additionalAccountProductsAddResponse)