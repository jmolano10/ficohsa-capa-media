(:: pragma bea:global-element-return element="ns0:ConsultarSaldosVasa" location="../../../ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/transaccionesAlcanceIn/";

declare function xf:transaccionesAlcanceIn($ID as xs:string)
    as element(ns0:ConsultarSaldosVasa) {
        <ns0:ConsultarSaldosVasa>
            <ns0:noTarjetaCredito>{ $ID }</ns0:noTarjetaCredito>
        </ns0:ConsultarSaldosVasa>
};

declare variable $ID as xs:string external;

xf:transaccionesAlcanceIn($ID)