xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$valoresDeGuiaPagoRequest" element="ns0:valoresDeGuiaPagoRequest" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/valoresDeGuiaPago/xsd/valoresDeGuiaPago_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/valoresDeGuiaPago";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValoresDeGuiaPagoDEI/xq/valoresDeGuiaPagoDEIIn/";

declare function xf:valoresDeGuiaPagoDEIIn($requestHeader as element(ns2:RequestHeader),
    $valoresDeGuiaPagoRequest as element(ns0:valoresDeGuiaPagoRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_AUDITORIA>
                <ns1:RTN>{ data($valoresDeGuiaPagoRequest/RTN) }</ns1:RTN>
                <ns1:USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns1:USUARIO_SERVICIO>
                <ns1:PROCESO_ORIGEN_ERROR>TributosDEI.valoresDeGuiaPago</ns1:PROCESO_ORIGEN_ERROR>
            </ns1:PT_AUDITORIA>
            <ns1:PV_IDCONTRATO>{ data($valoresDeGuiaPagoRequest/CONTRACT_NUMBER) }</ns1:PV_IDCONTRATO>
            <ns1:PV_GUIAPAGO>{ data($valoresDeGuiaPagoRequest/PAYMENT_GUIDE) }</ns1:PV_GUIAPAGO>
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $valoresDeGuiaPagoRequest as element(ns0:valoresDeGuiaPagoRequest) external;

xf:valoresDeGuiaPagoDEIIn($requestHeader,
    $valoresDeGuiaPagoRequest)