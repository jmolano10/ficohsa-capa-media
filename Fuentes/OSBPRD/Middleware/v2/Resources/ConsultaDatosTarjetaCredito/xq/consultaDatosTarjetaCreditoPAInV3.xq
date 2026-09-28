(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito" element="ns0:consultaDatosTarjetaCredito" location="../../../BusinessServices/OSB/ConsultaDatosTarjetaCredito_v2/xsd/XMLSchema_914157276.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataPA/conDatoEstado/xsd/conDatoEstado_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoEstado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoPAInV3/";

declare function xf:consultaDatosTarjetaCreditoPAInV3($consultaDatosTarjetaCredito as element(ns0:consultaDatosTarjetaCredito))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:NumTarjeta>{ data($consultaDatosTarjetaCredito/CARD_NUMBER) }</ns1:NumTarjeta>
        </ns1:InputParameters>
};

declare variable $consultaDatosTarjetaCredito as element(ns0:consultaDatosTarjetaCredito) external;

xf:consultaDatosTarjetaCreditoPAInV3($consultaDatosTarjetaCredito)