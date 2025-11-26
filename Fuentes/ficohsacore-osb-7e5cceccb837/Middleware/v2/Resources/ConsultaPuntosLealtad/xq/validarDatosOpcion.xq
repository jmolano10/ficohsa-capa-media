(:: pragma bea:global-element-return element="ns0:validarDatosOpcion" location="../../../BusinessServices/VASA/WSCRS/wsdl/WSCRS.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/validarDatosOpcion/";

declare function xf:validarDatosOpcion($cardNumber as xs:string)
    as element(ns0:validarDatosOpcion) {
        <ns0:validarDatosOpcion>
            <ns0:tarjeta>{ $cardNumber }</ns0:tarjeta>
        </ns0:validarDatosOpcion>
};

declare variable $cardNumber as xs:string external;

xf:validarDatosOpcion($cardNumber)
