(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito" element="ns1:consultaDatosTarjetaCredito" location="../xsd/consultaDatosTarjetaCreditoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoCBTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCreditoCB/xq/consultaDatosTarjetaCreditoCBIn/";

declare function xf:consultaDatosTarjetaCreditoCBIn($consultaDatosTarjetaCredito as element(ns1:consultaDatosTarjetaCredito))
    as element(ns0:consultaDatosTarjetaCredito) {
        <ns0:consultaDatosTarjetaCredito>
            <CARD_NUMBER>{ data($consultaDatosTarjetaCredito/CARD_NUMBER) }</CARD_NUMBER>
            {
                for $ORG in $consultaDatosTarjetaCredito/ORG
                return
                    <ORG>{ data($ORG) }</ORG>
            }
        </ns0:consultaDatosTarjetaCredito>
};

declare variable $consultaDatosTarjetaCredito as element(ns1:consultaDatosTarjetaCredito) external;

xf:consultaDatosTarjetaCreditoCBIn($consultaDatosTarjetaCredito)