(:: pragma bea:global-element-return element="ns0:reversarPagoResponse" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/ReversarPagoInvalidadUsernameOut/";

declare function xf:ReversarPagoInvalidadUsernameOut($estatusConfirmacion as xs:string,
    $mensajeConfirmacion as xs:string)
    as element(ns0:reversarPagoResponse) {
        <ns0:reversarPagoResponse>
            <ns0:reversarPagoResult>
                <ns0:estatusConfirmacion>{ $estatusConfirmacion }</ns0:estatusConfirmacion>
                <ns0:mensajeConfirmacion>{ $mensajeConfirmacion }</ns0:mensajeConfirmacion>
            </ns0:reversarPagoResult>
        </ns0:reversarPagoResponse>
};

declare variable $estatusConfirmacion as xs:string external;
declare variable $mensajeConfirmacion as xs:string external;

xf:ReversarPagoInvalidadUsernameOut($estatusConfirmacion,
    $mensajeConfirmacion)