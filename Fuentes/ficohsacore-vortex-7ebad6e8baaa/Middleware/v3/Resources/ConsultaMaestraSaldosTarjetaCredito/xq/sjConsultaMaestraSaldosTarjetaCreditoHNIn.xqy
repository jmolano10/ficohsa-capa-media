xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../v2/BusinessServices/MasterDataHN/conMaestroSaldos/xsd/ConsultaMaestroSaldosTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaMaestraSaldosTarjetaCredito" location="../../../BusinessServices/SJS/ConsultaMaestraSaldosTarjetaCredito/xsd/sjConsultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/sjConsultaMaestraSaldosTarjetaCreditoHNIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMaestraSaldosTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaMaestroSaldosTarjetaCredito";

declare function xf:sjConsultaMaestraSaldosTarjetaCreditoHNIn($outputParameters as element(ns0:OutputParameters),
    $cardNumber as xs:string,
    $countryCode as xs:string)
    as element(ns1:sjConsultaMaestraSaldosTarjetaCredito) {
          <ns1:sjConsultaMaestraSaldosTarjetaCredito>
            <CARD_NUMBER>{ $cardNumber }</CARD_NUMBER>
            <COUNTRY_CODE>{ $countryCode }</COUNTRY_CODE>
            {
            	for $row in $outputParameters/ns0:RowSet/ns0:Row
            	return(
		            <CARD_INFORMATION>
		                <ACCOUNT_NUMBER>{ data($row/ns0:Column[upper-case(@name) = 'NUMCUENTA']) }</ACCOUNT_NUMBER>
		                <ORG>{ data($row/ns0:Column[upper-case(@name) = 'ORG']) }</ORG>
		            	<CURRENCY>{ data($row/ns0:Column[upper-case(@name) = 'MONEDA']) }</CURRENCY>
		            </CARD_INFORMATION>
	            )
           	}
        </ns1:sjConsultaMaestraSaldosTarjetaCredito>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $cardNumber as xs:string external;
declare variable $countryCode as xs:string external;

xf:sjConsultaMaestraSaldosTarjetaCreditoHNIn($outputParameters,
    $cardNumber,
    $countryCode)