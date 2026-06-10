<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoderemesaconcredacuentaResponse" element="ns1:PagoderemesaconcredacuentaResponse" location="../Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRemesaCreditoCuentaResponse" location="pagoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaOut/";

declare function xf:pagoRemesaCreditoCuentaOut($pagoderemesaconcredacuentaResponse as element(ns1:PagoderemesaconcredacuentaResponse))
    as element(ns0:pagoRemesaCreditoCuentaResponse) {
        &lt;ns0:pagoRemesaCreditoCuentaResponse>
            {
                for $LRREMITTID in $pagoderemesaconcredacuentaResponse/FUNDSTRANSFERType/LRREMITTID
                return
                    &lt;REMITTANCE_ID>{ data($LRREMITTID) }&lt;/REMITTANCE_ID>
            }
        &lt;/ns0:pagoRemesaCreditoCuentaResponse>
};

declare variable $pagoderemesaconcredacuentaResponse as element(ns1:PagoderemesaconcredacuentaResponse) external;

xf:pagoRemesaCreditoCuentaOut($pagoderemesaconcredacuentaResponse)</con:xquery>
    <con:dependency location="../Resoruces/XMLSchema_-1855765488.xsd">
        <con:schema ref="Middleware/Business_Resources/remesas/Resoruces/XMLSchema_-1855765488"/>
    </con:dependency>
    <con:dependency location="pagoRemesaCreditoCuentaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>