(:: pragma bea:global-element-parameter parameter="$consultaEstadoCuentaTC1" element="ns0:consultaEstadoCuentaTC" location="consultaEstadoCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultarUltimoEC" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCIn/";

declare function xf:consultaEstadoCuentaTCIn($consultaEstadoCuentaTC1 as element(ns0:consultaEstadoCuentaTC))
    as element(ns1:ConsultarUltimoEC) {
        <ns1:ConsultarUltimoEC>
            <ns1:noTarjetaCredito>{ data($consultaEstadoCuentaTC1/CARD_NUMBER) }</ns1:noTarjetaCredito>
        </ns1:ConsultarUltimoEC>
};

declare variable $consultaEstadoCuentaTC1 as element(ns0:consultaEstadoCuentaTC) external;

xf:consultaEstadoCuentaTCIn($consultaEstadoCuentaTC1)