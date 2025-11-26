(:: pragma bea:global-element-return element="ns0:procesaTransaccionesGenericasResponse" location="../xsd/procesaTransaccionesGenericasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaTransaccionesGenericasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasTengoEEH/ProcesarTransaccionesGenericaCB/xq/procesaTransaccionGenericaOut/";

declare function xf:procesaTransaccionGenericaOut($REFERENCIA_T24 as xs:string,
    $UUID as xs:string)
    as element(ns0:procesaTransaccionesGenericasResponse) {
        <ns0:procesaTransaccionesGenericasResponse>
            <REFERENCIA_T24>{ $REFERENCIA_T24 }</REFERENCIA_T24>
            <UUID>{ $UUID }</UUID>
        </ns0:procesaTransaccionesGenericasResponse>
};

declare variable $REFERENCIA_T24 as xs:string external;
declare variable $UUID as xs:string external;

xf:procesaTransaccionGenericaOut($REFERENCIA_T24,
    $UUID)