<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InformacionTarjeta" location="../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaTDCporCliente2/";
declare namespace ns2 = "http://tempuri.org/";

declare function xf:consultaTDCporCliente2($noTarjetaCredito1 as xs:string)
    as element(ns2:InformacionTarjeta) {
         &lt;ns2:InformacionTarjeta>
          {
        	let $messageList := fn:tokenize($noTarjetaCredito1,"@FM")
        	return(
         &lt;ns2:noTarjetaCredito>{data($messageList[1])}&lt;/ns2:noTarjetaCredito>
            )
          }
        &lt;/ns2:InformacionTarjeta>
};

declare variable $noTarjetaCredito1 as xs:string external;

xf:consultaTDCporCliente2($noTarjetaCredito1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl">
        <con:wsdl ref="Middleware/Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito"/>
    </con:dependency>
</con:xqueryEntry>