xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse1" element="ns1:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns0:NotificaEstadoRemesaCreditoCuentaResponse" location="../xsd/notificaEstadoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoRemesaCreditoCuentaTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoRemesaCreditoCuenta/xq/notificaEstadoRemesaCreditoCuentaOut/";

declare function xf:notificaEstadoRemesaCreditoCuentaOut($consultadeclienteResponse1 as element(ns1:ConsultadeclienteResponse))
    as element(ns0:NotificaEstadoRemesaCreditoCuentaResponse) {
        <ns0:NotificaEstadoRemesaCreditoCuentaResponse>
            <EMAIL>{ data($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMAIL) }</EMAIL>
        </ns0:NotificaEstadoRemesaCreditoCuentaResponse>
};

declare variable $consultadeclienteResponse1 as element(ns1:ConsultadeclienteResponse) external;

xf:notificaEstadoRemesaCreditoCuentaOut($consultadeclienteResponse1)