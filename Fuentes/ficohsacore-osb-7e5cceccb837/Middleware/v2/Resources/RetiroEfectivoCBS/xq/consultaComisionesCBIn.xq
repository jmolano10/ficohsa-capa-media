(:: pragma bea:global-element-parameter parameter="$retiroEfectivo" element="ns0:retiroEfectivo" location="../xsd/retiroEfectivoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/consultaComisionesCB/xsd/consultaComisionesCB_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoCBTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionesCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoCBS/xq/consultaComisionesCBIn/";

declare function xf:consultaComisionesCBIn($retiroEfectivo as element(ns0:retiroEfectivo),
    $codigoTransaccion as xs:string,
    $usuarioTransaccion as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_MONTO>{ data($retiroEfectivo/AMOUNT) }</ns1:PV_MONTO>
            <ns1:PV_MONEDA>{ data($retiroEfectivo/CURRENCY) }</ns1:PV_MONEDA>
            <ns1:PV_CODIGO_TRANSACCION>{ $codigoTransaccion }</ns1:PV_CODIGO_TRANSACCION>
            <ns1:PV_USUARIO_TRANSACCION>{ upper-case($usuarioTransaccion) }</ns1:PV_USUARIO_TRANSACCION>
        </ns1:InputParameters>
};

declare variable $retiroEfectivo as element(ns0:retiroEfectivo) external;
declare variable $codigoTransaccion as xs:string external;
declare variable $usuarioTransaccion as xs:string external;

xf:consultaComisionesCBIn($retiroEfectivo,
    $codigoTransaccion,
    $usuarioTransaccion)