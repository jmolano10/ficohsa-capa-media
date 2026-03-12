xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
(:: import schema at "../Schemas/wsinfotarjetas.xsd" ::)

declare namespace ns0="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBGT_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare variable $consultaEstadoCuentaTC1  as element() (:: schema-element(ns0:getCreditCardStatement)::) external;

declare function local:consultaEstadoCuentaTCIn($consultaEstadoCuentaTC1 as element() (:: schema-element(ns0:getCreditCardStatement)::))
    as element() (:: schema-element(ns1:ConsultarEstadosCuentaUltimoCorte)::) {
        <ns1:ConsultarEstadosCuentaUltimoCorte>
            <ns1:noTarjetaCredito>{ data($consultaEstadoCuentaTC1/CardNumber) }</ns1:noTarjetaCredito>
        </ns1:ConsultarEstadosCuentaUltimoCorte>
};



local:consultaEstadoCuentaTCIn($consultaEstadoCuentaTC1)