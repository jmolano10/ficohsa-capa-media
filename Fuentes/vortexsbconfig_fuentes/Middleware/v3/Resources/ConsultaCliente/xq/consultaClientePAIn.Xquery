<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaCliente/xsd/consultaCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClientePAIn/";

declare function xf:consultaClientePAIn($tipoBusqueda as xs:string,
    $idCliente as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CUSTOMER_ID>
                {
                    if ($tipoBusqueda = 'CUSTOMER_ID') then
                        (data($idCliente))
                    else 
                        ()
                }
</ns0:PV_CUSTOMER_ID>
            <ns0:PV_LEGAL_ID>
                {
                    if ($tipoBusqueda = 'LEGAL_ID') then
                        (data($idCliente))
                    else 
                        ()
                }
</ns0:PV_LEGAL_ID>
        </ns0:InputParameters>
};

declare variable $tipoBusqueda as xs:string external;
declare variable $idCliente as xs:string external;

xf:consultaClientePAIn($tipoBusqueda,
    $idCliente)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaCliente/xsd/consultaCliente_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/ABKPA/consultaCliente/xsd/consultaCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>