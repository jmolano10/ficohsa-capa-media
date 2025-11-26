(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registrarDevolucionCobroTSP1" element="ns2:registrarDevolucionCobroTSP" location="../xsd/registrarDevolucionCobroTSPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TSP/registrarErrorReversionTSP/xsd/registrarErrorReversionTSP_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/registrarDevolucionCobroTSPTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarErrorReversionTSP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarDevolucionCobroTSP/xq/registrarFalloReversionTSPIn/";

declare function xf:registrarFalloReversionTSPIn($requestHeader1 as element(ns0:RequestHeader),
    $registrarDevolucionCobroTSP1 as element(ns2:registrarDevolucionCobroTSP),
    $errorMessage as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_ID_TRANSACCION>{ data($registrarDevolucionCobroTSP1/TRANSACTION_ID) }</ns1:PV_ID_TRANSACCION>
            <ns1:PV_REF_FT_TT_COBRO>{ data($registrarDevolucionCobroTSP1/TRANSACTION_REFERENCE) }</ns1:PV_REF_FT_TT_COBRO>
            <ns1:PV_USUARIO>{ data($requestHeader1/Authentication/UserName) }</ns1:PV_USUARIO>
            <ns1:PV_ERROR>{ $errorMessage }</ns1:PV_ERROR>
        </ns1:InputParameters>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $registrarDevolucionCobroTSP1 as element(ns2:registrarDevolucionCobroTSP) external;
declare variable $errorMessage as xs:string external;

xf:registrarFalloReversionTSPIn($requestHeader1,
    $registrarDevolucionCobroTSP1,
    $errorMessage)