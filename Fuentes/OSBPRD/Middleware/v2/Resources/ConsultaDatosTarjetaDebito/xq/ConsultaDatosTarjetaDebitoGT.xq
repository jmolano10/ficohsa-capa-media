(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/ABKGT/consultarTarjetaDebito/xsd/consultarTarjetaDebito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarTarjetaDebito";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultaCliente/xq/ConsultaDatosTarjetaDebitoGT/";

declare function xf:consultaTarjetaDebito($numeroTarjeta as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <PV_NUMERO_TARJETA>{ data($numeroTarjeta) }</PV_NUMERO_TARJETA>
        </ns0:InputParameters>
};

declare variable $numeroTarjeta as xs:string external;

xf:consultaTarjetaDebito($numeroTarjeta)