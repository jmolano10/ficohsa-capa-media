xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:solicitaTDCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/asignaTDIN/";

declare function xf:asignaTDIN($Currency as xs:string,
    $Account as xs:string,
    $CostumerCode as xs:string,
    $TypeCard as xs:string,
    $CardNumber as xs:string)
    as element(ns0:solicitaTDCliente) {
        <ns0:solicitaTDCliente>
            <COSTUMER_CODE>{ $CostumerCode }</COSTUMER_CODE>
            <ACCOUNT_NUMBER>{ $Account }</ACCOUNT_NUMBER>
            <ACCOUNT_CURRENCY>{ $Currency }</ACCOUNT_CURRENCY>
            <CARD_TYPE>{ $TypeCard }</CARD_TYPE>
			<CARD_NUMBER>{ $CardNumber }</CARD_NUMBER>            
        </ns0:solicitaTDCliente>
};

declare variable $Currency as xs:string external;
declare variable $Account as xs:string external;
declare variable $CostumerCode as xs:string external;
declare variable $TypeCard as xs:string external;
declare variable $CardNumber as xs:string external;

xf:asignaTDIN($Currency,
    $Account,
    $CostumerCode,
    $TypeCard,
    $CardNumber)