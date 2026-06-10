<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultarTarjetasCredito_v2" location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCCliente/xq/sjConsTarjetasClienteIn/";

declare function xf:sjConsTarjetasClienteIn($queryType as xs:string,
    $customerId as xs:string,
    $returnBalances as xs:string)
    as element(ns0:ConsultarTarjetasCredito_v2) {
        <ns0:ConsultarTarjetasCredito_v2>
            <ns0:Tipo>{ $queryType }</ns0:Tipo>
            <ns0:Parametro>{ $customerId }</ns0:Parametro>
            <ns0:Saldos>{ $returnBalances }</ns0:Saldos>
        </ns0:ConsultarTarjetasCredito_v2>
};

declare variable $queryType as xs:string external;
declare variable $customerId as xs:string external;
declare variable $returnBalances as xs:string external;

xf:sjConsTarjetasClienteIn($queryType,
    $customerId,
    $returnBalances)]]></con:xquery>
    <con:dependency location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
</con:xqueryEntry>