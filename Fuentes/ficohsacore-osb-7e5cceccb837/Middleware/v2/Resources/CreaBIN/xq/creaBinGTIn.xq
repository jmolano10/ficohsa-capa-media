xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$creaBIN" element="ns1:creaBIN" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/creaBin/xsd/creaBin_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaBIN/xq/creaBinGTIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/creaBin";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";

declare function xf:creaBinGTIn($creaBIN as element(ns1:creaBIN))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_BIN>{ data($creaBIN/BIN) }</ns0:PV_BIN>
            <ns0:PV_COMPANY>{ data($creaBIN/COMPANY) }</ns0:PV_COMPANY>
            <ns0:PV_PRODUCT_DESCRIPTION>{ data($creaBIN/PRODUCT_DESCRIPTION) }</ns0:PV_PRODUCT_DESCRIPTION>
            <ns0:PV_SERVICE_CODE>{ data($creaBIN/SERVICE_CODE) }</ns0:PV_SERVICE_CODE>
        </ns0:InputParameters>
};

declare variable $creaBIN as element(ns1:creaBIN) external;

xf:creaBinGTIn($creaBIN)