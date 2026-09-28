(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTC1" element="ns1:sjConsultaSaldosTC" location="../xsd/sjConsultaSaldosTC.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultarSaldos" location="../../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosTC/xq/sjConsultaSaldosTCIn/";

declare function xf:sjConsultaSaldosTCIn($sjConsultaSaldosTC1 as element(ns1:sjConsultaSaldosTC))
    as element(ns0:consultarSaldos) {
        <ns0:consultarSaldos>
            <ns0:noTarjetaCredito>{ data($sjConsultaSaldosTC1/CARD_NUMBER) }</ns0:noTarjetaCredito>
        </ns0:consultarSaldos>
};

declare variable $sjConsultaSaldosTC1 as element(ns1:sjConsultaSaldosTC) external;

xf:sjConsultaSaldosTCIn($sjConsultaSaldosTC1)