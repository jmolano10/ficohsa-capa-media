(:: pragma bea:global-element-return element="ns0:reversarTransaccion" location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguro/xq/reversaTransaccionHNIn/";

declare function xf:reversaTransaccionHNIn($idTransaccion as xs:string)
    as element(ns0:reversarTransaccion) {
        <ns0:reversarTransaccion>
            <TRANSACTION_ID>{ $idTransaccion }</TRANSACTION_ID>
        </ns0:reversarTransaccion>
};

declare variable $idTransaccion as xs:string external;

xf:reversaTransaccionHNIn($idTransaccion)