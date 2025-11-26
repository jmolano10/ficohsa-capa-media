(:: pragma bea:global-element-return element="ns0:consultaCuentasAfiliadasTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/consultaCuentasAfiliadasTarjetaDebito/consultaCuentasAfiliadasTarjetaDebitoTypes.xsd" ::)
(:: jgarcia - 31102017 :)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasAfiliadasTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaRetiroEfectivoCB/xq/consultaCuentaAfiliadaTarjetaDebitoIn/";

declare function xf:consultaCuentaAfiliadaTarjetaDebitoIn($productNumber as xs:string)
    as element(ns0:consultaCuentasAfiliadasTarjetaDebito) {
        <ns0:consultaCuentasAfiliadasTarjetaDebito>
            <DEBIT_CARD_NUMBER>{ $productNumber }</DEBIT_CARD_NUMBER>
        </ns0:consultaCuentasAfiliadasTarjetaDebito>
};


declare variable $productNumber as xs:string external;

xf:consultaCuentaAfiliadaTarjetaDebitoIn($productNumber)