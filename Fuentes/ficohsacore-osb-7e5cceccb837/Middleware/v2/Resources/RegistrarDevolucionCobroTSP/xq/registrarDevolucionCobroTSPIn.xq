(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registrarDevolucionCobroTSP" element="ns2:registrarDevolucionCobroTSP" location="../xsd/registrarDevolucionCobroTSPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TSP/registrarDevolucionCobroTSP/xsd/registrarDevolucionCobroTSP_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarDevolucionCobroTSP";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/registrarDevolucionCobroTSPTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarDevolucionCobroTSP/xq/registrarDevolucionCobroTSPIn/";

declare function xf:registrarDevolucionCobroTSPIn($requestHeader as element(ns1:RequestHeader),
    $registrarDevolucionCobroTSP as element(ns2:registrarDevolucionCobroTSP))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $TRANSACTION_ID in $registrarDevolucionCobroTSP/TRANSACTION_ID
                return
                    <ns0:PV_ID_TRANSACCION>{ data($TRANSACTION_ID) }</ns0:PV_ID_TRANSACCION>
            }
            {
                for $TRANSACTION_REFERENCE in $registrarDevolucionCobroTSP/TRANSACTION_REFERENCE
                return
                    <ns0:PV_REF_FT_TT_COBRO>{ data($TRANSACTION_REFERENCE) }</ns0:PV_REF_FT_TT_COBRO>
            }
            <ns0:PV_USUARIO>{ data($requestHeader/Authentication/UserName) }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $registrarDevolucionCobroTSP as element(ns2:registrarDevolucionCobroTSP) external;

xf:registrarDevolucionCobroTSPIn($requestHeader,
    $registrarDevolucionCobroTSP)