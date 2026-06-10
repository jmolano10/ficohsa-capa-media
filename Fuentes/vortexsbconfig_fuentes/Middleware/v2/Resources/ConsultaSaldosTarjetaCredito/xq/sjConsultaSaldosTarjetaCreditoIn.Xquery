<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns3:OutputParameters" location="../../../BusinessServices/MasterDataHN/osbConSaldosTCOffLine/xsd/osbConSaldosTCOffLine_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaSaldosTarjetaCredito" location="../../../BusinessServices/SJS/consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConSaldosTCOffLine";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/sjConsultaSaldosTarjetaCreditoIn/";

declare function xf:sjConsultaSaldosTarjetaCreditoIn($countryCode as xs:string,
    $cardNumber as xs:string,
    $outputParameters as element(ns3:OutputParameters))
    as element(ns0:sjConsultaSaldosTarjetaCredito) {
        <ns0:sjConsultaSaldosTarjetaCredito>
            <CARD_NUMBER>{ $cardNumber }</CARD_NUMBER>
            <COUNTRY_CODE>{ $countryCode }</COUNTRY_CODE>
            {
	            for  $row in $outputParameters/ns3:RowSet/ns3:Row
	            return(
	            <CARD_INFORMATION>
	                <ACCOUNT_NUMBER>{ data($row/ns3:Column[upper-case(@name) = 'ACCOUNT_NUMBER']/text()) }</ACCOUNT_NUMBER>
	                <ORG>{ data($row/ns3:Column[upper-case(@name) = 'ORG']/text()) }</ORG>
	                <ORG_TYPE>{ data($row/ns3:Column[upper-case(@name) = 'TYPE_ORG']/text()) }</ORG_TYPE>
	                <CURRENCY>{ data($row/ns3:Column[upper-case(@name) = 'CURRENCY']/text()) }</CURRENCY>
	            </CARD_INFORMATION>
	            )
           	}
        </ns0:sjConsultaSaldosTarjetaCredito>
};

declare variable $countryCode as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $outputParameters as element(ns3:OutputParameters) external;

xf:sjConsultaSaldosTarjetaCreditoIn($countryCode,
    $cardNumber,
    $outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MasterDataHN/osbConSaldosTCOffLine/xsd/osbConSaldosTCOffLine_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataHN/osbConSaldosTCOffLine/xsd/osbConSaldosTCOffLine_sp"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/SJS/consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>