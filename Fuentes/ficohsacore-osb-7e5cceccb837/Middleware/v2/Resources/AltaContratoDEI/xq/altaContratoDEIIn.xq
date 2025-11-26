(:: pragma bea:global-element-parameter parameter="$altaContrato" element="ns2:altaContrato" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/altaContrato/xsd/altaContrato_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/altaContrato";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AltaContratoDEI/xq/altaContratoDEIIn/";

declare function xf:altaContratoDEIIn($altaContrato as element(ns2:altaContrato),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_AUDITORIAINFO>
                <ns1:RTN>{ data($altaContrato/RTN) }</ns1:RTN>
                <ns1:USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns1:USUARIO_SERVICIO>
                <ns1:PROCESO_ORIGEN_ERROR>TributosDEI.altaContrato</ns1:PROCESO_ORIGEN_ERROR>
            </ns1:PT_AUDITORIAINFO>
            <ns1:PV_NUMEROCONTRATO>{ data($altaContrato/CONTRACT_NUMBER) }</ns1:PV_NUMEROCONTRATO>
        </ns1:InputParameters>
};

declare variable $altaContrato as element(ns2:altaContrato) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:altaContratoDEIIn($altaContrato,
    $requestHeader)