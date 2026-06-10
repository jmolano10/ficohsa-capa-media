<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse" element="ns0:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaFondoPensiones/xsd/consultaFondoPensiones_sp.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFondoPensiones";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondoPensiones/xq/consultaFondoPensionesIn/";

declare function xf:consultaFondoPensionesIn($consultadeclienteResponse as element(ns0:ConsultadeclienteResponse))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            {
                for $LEGALID in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALID
                return
                    &lt;ns1:PV_IDENTIFICACION>{ data($LEGALID) }&lt;/ns1:PV_IDENTIFICACION>
            }
        &lt;/ns1:InputParameters>
};

declare variable $consultadeclienteResponse as element(ns0:ConsultadeclienteResponse) external;

xf:consultaFondoPensionesIn($consultadeclienteResponse)</con:xquery>
    <con:dependency location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/XMLSchema_1144838292"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ConsultaFondoPensiones/xsd/consultaFondoPensiones_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ConsultaFondoPensiones/xsd/consultaFondoPensiones_sp"/>
    </con:dependency>
</con:xqueryEntry>