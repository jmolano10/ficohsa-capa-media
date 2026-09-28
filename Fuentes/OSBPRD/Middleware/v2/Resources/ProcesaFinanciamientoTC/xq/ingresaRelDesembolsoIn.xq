(:: pragma bea:global-element-parameter parameter="$procesaFinanciamiento" element="ns2:procesaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/INTFC/ingresaRelDesembolso/xsd/ingresaRelDesembolso_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresaRelDesembolso";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaFinanciamientoTC/xq/ingresaRelDesembolsoIn/";

declare function xf:ingresaRelDesembolsoIn($procesaFinanciamiento as element(ns2:procesaFinanciamiento),
    $requestHeader as element(ns0:RequestHeader),
    $fecha as xs:dateTime,
    $secuencia as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_USUARIO>{ data($requestHeader/Authentication/UserName) }</ns1:PV_USUARIO>
            <ns1:PV_SECUENCIACANAL>{ data($procesaFinanciamiento/INTERFACE_REFERENCE_NO) }</ns1:PV_SECUENCIACANAL>
            <ns1:PV_LINEACREDITO>{ data($procesaFinanciamiento/CREDIT_LINE) }</ns1:PV_LINEACREDITO>
            <ns1:PV_TIPOTASA>{ data($procesaFinanciamiento/RATE_CLASS) }</ns1:PV_TIPOTASA>
            <ns1:PV_SECUENCIABANCO>{ $secuencia }</ns1:PV_SECUENCIABANCO>
            <ns1:PD_FECHAINGRESO>{ data($fecha) }</ns1:PD_FECHAINGRESO>
        </ns1:InputParameters>
};

declare variable $procesaFinanciamiento as element(ns2:procesaFinanciamiento) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $fecha as xs:dateTime external;
declare variable $secuencia as xs:string external;

xf:ingresaRelDesembolsoIn($procesaFinanciamiento,
    $requestHeader,
    $fecha,
    $secuencia)