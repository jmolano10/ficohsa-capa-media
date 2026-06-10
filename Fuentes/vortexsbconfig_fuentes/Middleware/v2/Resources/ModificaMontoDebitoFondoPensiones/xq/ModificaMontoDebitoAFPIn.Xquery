<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$modificaMontoDebitoFondoPensionesRequest" element="ns0:modificaMontoDebitoFondoPensionesRequest" location="../xsd/modificaMontoDebitoFondoPensionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/ModificaMontoDebitoAFP/xsd/ModificaMontoDebitoAFP_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ModificaMontoDebitoAFP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/modificaMontoDebitoFondoPensionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaMontoDebitoFondoPensiones/xq/ModificaMontoDebitoAFPIn/";

declare function xf:ModificaMontoDebitoAFPIn($modificaMontoDebitoFondoPensionesRequest as element(ns0:modificaMontoDebitoFondoPensionesRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>        
           
            <ns1:PV_CODIGO_DEUDOR>{ data($modificaMontoDebitoFondoPensionesRequest/ID) }</ns1:PV_CODIGO_DEUDOR>
            <ns1:PN_MONTO>{ fn:number($modificaMontoDebitoFondoPensionesRequest/AMOUNT) }</ns1:PN_MONTO>
             
        </ns1:InputParameters>
};

declare variable $modificaMontoDebitoFondoPensionesRequest as element(ns0:modificaMontoDebitoFondoPensionesRequest) external;

xf:ModificaMontoDebitoAFPIn($modificaMontoDebitoFondoPensionesRequest)]]></con:xquery>
    <con:dependency location="../xsd/modificaMontoDebitoFondoPensionesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ModificaMontoDebitoFondoPensiones/xsd/modificaMontoDebitoFondoPensionesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKHN/FondoPensiones/ModificaMontoDebitoAFP/xsd/ModificaMontoDebitoAFP_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKHN/FondoPensiones/ModificaMontoDebitoAFP/xsd/ModificaMontoDebitoAFP_sp"/>
    </con:dependency>
</con:xqueryEntry>