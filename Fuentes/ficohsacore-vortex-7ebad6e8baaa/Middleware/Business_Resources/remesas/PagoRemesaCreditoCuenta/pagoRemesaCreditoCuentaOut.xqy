xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoderemesaconcredacuentaResponse" element="ns1:PagoderemesaconcredacuentaResponse" location="../Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRemesaCreditoCuentaResponse" location="pagoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaOut/";

declare function xf:pagoRemesaCreditoCuentaOut($pagoderemesaconcredacuentaResponse as element(ns1:PagoderemesaconcredacuentaResponse))
    as element(ns0:pagoRemesaCreditoCuentaResponse) {
        <ns0:pagoRemesaCreditoCuentaResponse>
            {
                for $LRREMITTID in $pagoderemesaconcredacuentaResponse/FUNDSTRANSFERType/LRREMITTID
                return
                    <REMITTANCE_ID>{ data($LRREMITTID) }</REMITTANCE_ID>
            }
        </ns0:pagoRemesaCreditoCuentaResponse>
};

declare variable $pagoderemesaconcredacuentaResponse as element(ns1:PagoderemesaconcredacuentaResponse) external;

xf:pagoRemesaCreditoCuentaOut($pagoderemesaconcredacuentaResponse)