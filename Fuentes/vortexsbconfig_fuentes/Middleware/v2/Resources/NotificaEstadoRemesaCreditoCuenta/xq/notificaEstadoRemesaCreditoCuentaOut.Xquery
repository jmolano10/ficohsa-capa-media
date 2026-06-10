<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse1" element="ns1:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns0:NotificaEstadoRemesaCreditoCuentaResponse" location="../xsd/notificaEstadoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoRemesaCreditoCuentaTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoRemesaCreditoCuenta/xq/notificaEstadoRemesaCreditoCuentaOut/";

declare function xf:notificaEstadoRemesaCreditoCuentaOut($consultadeclienteResponse1 as element(ns1:ConsultadeclienteResponse))
    as element(ns0:NotificaEstadoRemesaCreditoCuentaResponse) {
        &lt;ns0:NotificaEstadoRemesaCreditoCuentaResponse>
            &lt;EMAIL>{ data($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMAIL) }&lt;/EMAIL>
        &lt;/ns0:NotificaEstadoRemesaCreditoCuentaResponse>
};

declare variable $consultadeclienteResponse1 as element(ns1:ConsultadeclienteResponse) external;

xf:notificaEstadoRemesaCreditoCuentaOut($consultadeclienteResponse1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/XMLSchema_1144838292"/>
    </con:dependency>
    <con:dependency location="../xsd/notificaEstadoRemesaCreditoCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/NotificaEstadoRemesaCreditoCuenta/xsd/notificaEstadoRemesaCreditoCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>