xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito1" element="ns0:consultaDatosTarjetaCredito" location="consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InformacionTarjeta" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns2 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoTarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoIn/";

declare function xf:consultaDatosTarjetaCreditoIn($consultaDatosTarjetaCredito1 as element(ns0:consultaDatosTarjetaCredito),
    $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader))
    as element(ns2:InformacionTarjeta) {
        <ns2:InformacionTarjeta>
            <ns2:noTarjetaCredito>{ data($consultaDatosTarjetaCredito1/CARD_NUMBER) }</ns2:noTarjetaCredito>
        </ns2:InformacionTarjeta>
};

declare variable $consultaDatosTarjetaCredito1 as element(ns0:consultaDatosTarjetaCredito) external;
declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;

xf:consultaDatosTarjetaCreditoIn($consultaDatosTarjetaCredito1,
    $autenticacionRequestHeader1)