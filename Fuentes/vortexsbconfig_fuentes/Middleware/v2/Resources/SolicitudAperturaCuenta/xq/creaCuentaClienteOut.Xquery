<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$crearCuentaSimplificadaResponse" element="ns1:CrearCuentaSimplificadaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaCuentaClienteResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudAperturaCuenta/xq/creaCuentaClienteOut/";

declare function xf:creaCuentaClienteOut($crearCuentaSimplificadaResponse as element(ns1:CrearCuentaSimplificadaResponse))
    as element(ns0:creaCuentaClienteResponse) {
        <ns0:creaCuentaClienteResponse>
            <ACCOUNT_INFORMATION>
                {
                    for $transactionId in $crearCuentaSimplificadaResponse/Status/transactionId
                    return
                        <ACCOUNT_NUMBER>{ data($transactionId) }</ACCOUNT_NUMBER>
                }
                {
                    for $successIndicator in $crearCuentaSimplificadaResponse/Status/successIndicator
                    return
                        <SUCCESS_INDICATOR>{ data($successIndicator) }</SUCCESS_INDICATOR>
                }
                {
                    let $result :=
                        for $messages in $crearCuentaSimplificadaResponse/Status/messages
                        return
                            <ERROR_MESSAGE>{ data($messages) }</ERROR_MESSAGE>
                    return
                        $result[1]
                }
            </ACCOUNT_INFORMATION>
        </ns0:creaCuentaClienteResponse>
};

declare variable $crearCuentaSimplificadaResponse as element(ns1:CrearCuentaSimplificadaResponse) external;

xf:creaCuentaClienteOut($crearCuentaSimplificadaResponse)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004"/>
    </con:dependency>
    <con:dependency location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/AperturaProductos/xsd/aperturaProductosTypes"/>
    </con:dependency>
</con:xqueryEntry>