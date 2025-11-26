xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/getRemittances.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $parametersOut as element(*) external;
declare variable $GetRemittancesFieldsResponse as element(*) external;

declare function local:func($uuid as xs:string, 
                            $parametersOut as element(*), 
                            $GetRemittancesFieldsResponse as element(*)) 
                            as element() (:: schema-element(ns1:getRemittancesResponse) ::) {
                            
    let $codigoContrato := $GetRemittancesFieldsResponse/CODIGOCONTRATO
    let $claveRemesadora := $GetRemittancesFieldsResponse/CLAVEREMESA
    let $moneda := $GetRemittancesFieldsResponse/MONEDA
    let $fechaRemesa := $GetRemittancesFieldsResponse/FECHAREMESA
    let $monto := $GetRemittancesFieldsResponse/MONTO
    let $montoLocal := $GetRemittancesFieldsResponse/MONTOLOCAL
    let $tasaCambio := $GetRemittancesFieldsResponse/TASACAMBIO
    let $remitente := $GetRemittancesFieldsResponse/REMITENTE
    let $beneficiario := $GetRemittancesFieldsResponse/BENEFICIARIO
    let $paisOrigen := $GetRemittancesFieldsResponse/PAISORIGEN
    return
	    
       if (fn:string($parametersOut/errorCode/text()) = ("0", "2")) then (
        <ns1:getRemittancesResponse>
            <ns1:getRemittancesResponseType>
                <ns1:getRemittancesResponseRecordTypes>
                        <RemittanceId>{ data($parametersOut/primaryKey/text()) }</RemittanceId>       							              
                        <RemitterId>{ data($parametersOut/moreParameters/data[@fieldName=$codigoContrato ]/text()) }</RemitterId>
                        <RemitterName>{data($parametersOut/moreParameters/data[@fieldName=$remitente]/text())}</RemitterName>              	
                        <BeneficiaryName>{data($parametersOut/moreParameters/data[@fieldName=$beneficiario]/text()) }</BeneficiaryName>
                        {
                                if (data($parametersOut/errorCode/text()) = 0) then
                                ( 		               		
                                        <PaymentDate/>
                                )
                                else if (data($parametersOut/errorCode/text()) = 2) then
                                (
                                        <PaymentDate>{data($parametersOut/moreParameters/data[@fieldName=$fechaRemesa]/text()) }</PaymentDate>
                                )
                                else
                                (
                                        <PaymentDate/>
                                )		               	
		               	}	
               			<Currency>{data($parametersOut/moreParameters/data[@fieldName=$moneda]/text())}</Currency>
               			<ExchangeRate>{data($parametersOut/moreParameters/data[@fieldName=$tasaCambio]/text()) }</ExchangeRate>
		               	{
		               		if (data($parametersOut/errorCode/text()) = 0) then
		               		( 		               		
		               			<RemittanceStatus>DISPONIBLE</RemittanceStatus>
		               		)
		               		else if (data($parametersOut/errorCode/text()) = 2) then
		               		(
		               			<RemittanceStatus>PAGADA</RemittanceStatus>
		               		)
		               		else
		               		(
		               		    <RemittanceStatus>{ data($parametersOut/errorMessage/text()) }</RemittanceStatus>
		               		)		               	
		               	}
               		    <RemittanceAmount>{ data($parametersOut/totalAmount/text()) }</RemittanceAmount>
               		    <RemittanceSourceAmount>{ data($parametersOut/moreParameters/data[@fieldName=$montoLocal]/text())}</RemittanceSourceAmount>
               		    <OriginCountry>{data($parametersOut/moreParameters/data[@fieldName=$paisOrigen]/text()) }</OriginCountry>
	                </ns1:getRemittancesResponseRecordTypes>
	            </ns1:getRemittancesResponseType>
                    <ns1:StatusInfo>
                      <com:Status>Success</com:Status>
                      <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
                      <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
                      <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
                    </ns1:StatusInfo>
	        </ns1:getRemittancesResponse>
	    ) else (
	    	<ns1:getRemittancesResponse/>
	    )     
};

local:func($uuid, $parametersOut, $GetRemittancesFieldsResponse)
