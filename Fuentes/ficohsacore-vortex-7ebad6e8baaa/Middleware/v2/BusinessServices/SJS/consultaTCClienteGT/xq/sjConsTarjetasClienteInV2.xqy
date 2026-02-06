xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultarTarjetasCredito_v2" location="../../../ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCClienteGT/xq/sjConsTarjetasClienteInV2/";

declare function xf:sjConsTarjetasClienteInV2($Tipo as xs:string,
    $Parametro as xs:string,
    $Saldos as xs:string)
    as element(ns0:ConsultarTarjetasCredito_v2) {
        <ns0:ConsultarTarjetasCredito_v2>
            <ns0:Tipo>{ $Tipo }</ns0:Tipo>
            <ns0:Parametro>{ $Parametro }</ns0:Parametro>
            <ns0:Saldos>{ $Saldos }</ns0:Saldos>
        </ns0:ConsultarTarjetasCredito_v2>
};

declare variable $Tipo as xs:string external;
declare variable $Parametro as xs:string external;
declare variable $Saldos as xs:string external;

xf:sjConsTarjetasClienteInV2($Tipo,
    $Parametro,
    $Saldos)