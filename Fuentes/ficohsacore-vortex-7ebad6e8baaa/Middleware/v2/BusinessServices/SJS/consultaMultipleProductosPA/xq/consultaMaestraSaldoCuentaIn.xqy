xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultiplesProductosPA" element="ns0:sjConsultaMultiplesProductosPA" location="../xsd/sjConsultaMultipleProductosPA.xsd" ::)
(:: pragma  parameter="$productosxTipo" type="anyType" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../ABKPA/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultiplesProductosPA";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaMaestraSaldoCuentaIn/";

declare function xf:consultaMaestraSaldoCuentaIn( $ID as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_ACCOUNT_NUMBER>{ $ID }</ns1:PV_ACCOUNT_NUMBER>
        </ns1:InputParameters>
};

declare variable $ID as xs:string external;

xf:consultaMaestraSaldoCuentaIn(
    $ID)