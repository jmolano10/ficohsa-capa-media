xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraInfoTransaccionesTCRequest1" element="ns0:consultaMaestraInfoTransaccionesTC" location="../xsd/consultaMaestraInfoTransaccionesTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaMaestraInfoTransaccionesTC/xsd/ConMaestraInfoTransaccionesTC_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConMaestraInfoTransaccionesTC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraInfoTransaccionesTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraInfoTransaccionesTC/xq/consultaMaestraInfoTransaccionesTCIn/";

declare function xf:consultaMaestraInfoTransaccionesTCIn($consultaMaestraInfoTransaccionesTCRequest1 as element(ns0:consultaMaestraInfoTransaccionesTC),
    $country as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $country }</ns1:Pais>
            {
                for $ORG in $consultaMaestraInfoTransaccionesTCRequest1/ORG
                return
                    <ns1:Org>{ data($ORG) }</ns1:Org>
            }
            <ns1:NumCuenta>{ data($consultaMaestraInfoTransaccionesTCRequest1/PRODUCT_VALUE) }</ns1:NumCuenta>
            <ns1:Tipo>{ data($consultaMaestraInfoTransaccionesTCRequest1/PRODUCT_TYPE) }</ns1:Tipo>
            <ns1:CodServicio>{ data($consultaMaestraInfoTransaccionesTCRequest1/PROCESS_ID) }</ns1:CodServicio>
            <ns1:Mes>{ data($consultaMaestraInfoTransaccionesTCRequest1/MONTH) }</ns1:Mes>
            <ns1:Anio>{ data($consultaMaestraInfoTransaccionesTCRequest1/YEAR) }</ns1:Anio>
        </ns1:InputParameters>
};

declare variable $consultaMaestraInfoTransaccionesTCRequest1 as element(ns0:consultaMaestraInfoTransaccionesTC) external;
declare variable $country as xs:string external;

xf:consultaMaestraInfoTransaccionesTCIn($consultaMaestraInfoTransaccionesTCRequest1,
    $country)