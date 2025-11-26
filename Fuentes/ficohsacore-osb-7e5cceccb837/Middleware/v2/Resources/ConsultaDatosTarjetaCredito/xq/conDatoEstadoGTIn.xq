(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito1" element="ns1:consultaDatosTarjetaCredito" location="../xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataGT/conDatosEstado/xsd/conDatosEstado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosEstado";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/conDatoEstadoGTIn/";

declare function xf:conDatoEstadoGTIn($codigoPais as xs:string,
    $consultaDatosTarjetaCredito1 as element(ns1:consultaDatosTarjetaCredito))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            <ns0:NumTarjeta>{ data($consultaDatosTarjetaCredito1/CARD_NUMBER) }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;
declare variable $consultaDatosTarjetaCredito1 as element(ns1:consultaDatosTarjetaCredito) external;

xf:conDatoEstadoGTIn($codigoPais,
    $consultaDatosTarjetaCredito1)
