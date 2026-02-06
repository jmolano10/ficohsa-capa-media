xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultarTarjetasCredito_v2" location="../../../ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCClientePA/xq/sjConsultaTarjetaClienteV2In/";

declare function xf:sjConsultaTarjetaClienteV2In($TIPO as xs:string,
    $PARAMETRO as xs:string,
    $SALDOS as xs:string)
    as element(ns0:ConsultarTarjetasCredito_v2) {
        <ns0:ConsultarTarjetasCredito_v2>
            <ns0:Tipo>{ $TIPO }</ns0:Tipo>
            <ns0:Parametro>{ $PARAMETRO }</ns0:Parametro>
            <ns0:Saldos>{ $SALDOS }</ns0:Saldos>
        </ns0:ConsultarTarjetasCredito_v2>
};

declare variable $TIPO as xs:string external;
declare variable $PARAMETRO as xs:string external;
declare variable $SALDOS as xs:string external;

xf:sjConsultaTarjetaClienteV2In($TIPO,
    $PARAMETRO,
    $SALDOS)