(:: pragma bea:global-element-return element="ns0:registrarPagoResponse" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/RegistrarPagoInvalidUserNameOut/";

declare function xf:RegistrarPagoInvalidUserNameOut($estatusConfirmacion as xs:string,
    $mensajeConfirmacion as xs:string)
    as element(ns0:registrarPagoResponse) {
        <ns0:registrarPagoResponse>
            <ns0:registrarPagoResult>
                <ns0:estatusConfirmacion>{ $estatusConfirmacion }</ns0:estatusConfirmacion>
                <ns0:mensajeConfirmacion>{ $mensajeConfirmacion }</ns0:mensajeConfirmacion>
            </ns0:registrarPagoResult>
        </ns0:registrarPagoResponse>
};

declare variable $estatusConfirmacion as xs:string external;
declare variable $mensajeConfirmacion as xs:string external;

xf:RegistrarPagoInvalidUserNameOut($estatusConfirmacion,
    $mensajeConfirmacion)