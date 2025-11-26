<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:consultaPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadHNOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";

declare function xf:consultaPuntosLealtadHNOut($legalId as xs:string,
    $customerName as xs:string,
    $availablePoints as xs:string,
    $cashEquivalent as xs:string?,
    $cashCurrency as xs:string?,
    $isCashEquivalent as xs:string)
    as element(ns0:consultaPuntosLealtadResponse) {
        <ns0:consultaPuntosLealtadResponse>
            <LEGAL_ID>{ $legalId }</LEGAL_ID>
            <CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>                         
    		<BALANCE>{floor(xs:decimal($availablePoints))}</BALANCE>        	
               {
            	
            	 if(string($isCashEquivalent) != "NO") then (
	                if(string($cashEquivalent) != "") then (
		            <CASH_EQUIVALENT>{ fn-bea:format-number(xs:decimal($cashEquivalent),'###0.00')  }</CASH_EQUIVALENT>
		        )else(
		            <CASH_EQUIVALENT>0</CASH_EQUIVALENT>
		         )
		)else()
	      }
              {		           
		  if($cashCurrency != "") then (
		       <CASH_CURRENCY>{ $cashCurrency }</CASH_CURRENCY>
		  ) else ()		            	
              }
        </ns0:consultaPuntosLealtadResponse>
};

declare variable $legalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $availablePoints as xs:string external;
declare variable $cashEquivalent as xs:string? external;
declare variable $cashCurrency as xs:string? external;
declare variable $isCashEquivalent as xs:string external;

xf:consultaPuntosLealtadHNOut($legalId,
    $customerName,
    $availablePoints,
    $cashEquivalent,
    $cashCurrency,
    $isCashEquivalent)]]></con:xquery>
    <con:dependency location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd"/>
</con:xqueryEntry>