(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/consultaDatosTarjetaCreditoIn/";

declare function xf:consultaDatosTarjetaCreditoIn($destination as xs:string)
    as element(ns0:consultaDatosTarjetaCredito) {
        <ns0:consultaDatosTarjetaCredito>
            <CARD_NUMBER>{ $destination }</CARD_NUMBER>
        </ns0:consultaDatosTarjetaCredito>
};

declare variable $destination as xs:string external;

xf:consultaDatosTarjetaCreditoIn($destination)