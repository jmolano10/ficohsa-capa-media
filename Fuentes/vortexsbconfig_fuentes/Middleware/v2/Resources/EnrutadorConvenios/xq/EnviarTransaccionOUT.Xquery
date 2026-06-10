<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/CNV/enrutadorConveniosDB/xsd/EnviarTransaccion_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:serviceResponse" location="../xsd/enrutadorConveniosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/EnviarTransaccion";
declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnrutadorConvenios/xq/EnviarTransaccionOUT/";

declare function xf:EnviarTransaccionOUT($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:serviceResponse) {
        &lt;ns0:serviceResponse>
            {
                for $PX_XMLOUT in $outputParameters1/ns1:PX_XMLOUT
                return
                    &lt;responseData>{ data($PX_XMLOUT) }&lt;/responseData>
            }
        &lt;/ns0:serviceResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:EnviarTransaccionOUT($outputParameters1)</con:xquery>
    <con:dependency location="../../../BusinessServices/CNV/enrutadorConveniosDB/xsd/EnviarTransaccion_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CNV/enrutadorConveniosDB/xsd/EnviarTransaccion_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/enrutadorConveniosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/EnrutadorConvenios/xsd/enrutadorConveniosTypes"/>
    </con:dependency>
</con:xqueryEntry>