(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuenta/xq/validacionCuentaPagoTarjetaCredito_DebitoGTIn/";

declare function xf:validacionCuentaPagoTarjetaCredito_DebitoGTIn($AccountCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:ACCOUNT_NUMBER>{ $AccountCode }</ns0:ACCOUNT_NUMBER>
        </ns0:InputParameters>
};

declare variable $AccountCode as xs:string external;

xf:validacionCuentaPagoTarjetaCredito_DebitoGTIn($AccountCode)
