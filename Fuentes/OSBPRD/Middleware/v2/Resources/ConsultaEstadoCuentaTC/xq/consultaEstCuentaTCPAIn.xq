(:: pragma bea:global-element-parameter parameter="$consultaEstadoCuentaTC1" element="ns0:consultaEstadoCuentaTC" location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultarEstadosCuentaUltimoCorte" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaEstadoCuentaTC/xq/consultaEstadoCuentaTCIn/";

declare function xf:consultaEstadoCuentaTCPAIn($numeroTarjeta as xs:string)
    as element(ns1:ConsultarEstadosCuentaUltimoCorte) {
        <ns1:ConsultarEstadosCuentaUltimoCorte>
            <ns1:noTarjetaCredito>{ data($numeroTarjeta) }</ns1:noTarjetaCredito>
        </ns1:ConsultarEstadosCuentaUltimoCorte>
};

declare variable $numeroTarjeta as xs:string external;

xf:consultaEstadoCuentaTCPAIn($numeroTarjeta)