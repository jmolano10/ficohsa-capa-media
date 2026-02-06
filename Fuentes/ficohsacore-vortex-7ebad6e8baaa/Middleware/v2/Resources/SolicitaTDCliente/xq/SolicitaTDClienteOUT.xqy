xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:solicitaTDClienteResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaTDCliente/xq/SolicitaTDClienteOUT/";

declare function xf:SolicitaTDClienteOUT($CostumerCode as xs:string,
    $LastCardNumber as xs:string)
    as element(ns0:solicitaTDClienteResponse) {
        <ns0:solicitaTDClienteResponse>
            <COSTUMER_CODE>{ $CostumerCode }</COSTUMER_CODE>
            <LAST_CARD_NUMBER>{ $LastCardNumber }</LAST_CARD_NUMBER>
        </ns0:solicitaTDClienteResponse>
};

declare variable $CostumerCode as xs:string external;
declare variable $LastCardNumber as xs:string external;

xf:SolicitaTDClienteOUT($CostumerCode,
    $LastCardNumber)