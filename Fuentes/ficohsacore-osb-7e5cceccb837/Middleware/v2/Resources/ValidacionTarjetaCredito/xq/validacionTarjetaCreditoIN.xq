(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validacionTarjetaCredito1" element="ns1:validacionTarjetaCredito" location="../xsd/validacionTarjetaCreditoType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ValidacionTarjetaCredito/xsd/ConsultaDatosTarjetaCredito_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionTarjetaCreditoType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDatosTarjetaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionTarjetaCredito/xq/validacionTarjetaCreditoIN/";

declare function xf:validacionTarjetaCreditoIN($requestHeader1 as element(ns2:RequestHeader),
    $validacionTarjetaCredito1 as element(ns1:validacionTarjetaCredito),
    $Pais as xs:string,
    $org as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $Pais }</ns0:Pais>            
            <ns0:NumTarjeta>{ data($validacionTarjetaCredito1/CREDIT_CARD_NUMBER) }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $validacionTarjetaCredito1 as element(ns1:validacionTarjetaCredito) external;
declare variable $Pais as xs:string external;
declare variable $org as xs:string external;

xf:validacionTarjetaCreditoIN($requestHeader1,
    $validacionTarjetaCredito1,
    $Pais,
    $org)
