(:: pragma bea:global-element-return element="ns0:AutenticacionRequestHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaPagoRecaudo/xq/consultaDetalleTxnHeaderIn/";

declare function xf:consultaDetalleTxnHeaderIn($username as xs:string,
    $password as xs:string)
    as element(ns0:AutenticacionRequestHeader) {
        <ns0:AutenticacionRequestHeader>
            <UserName>{ $username }</UserName>
            <Password>{ $password }</Password>
        </ns0:AutenticacionRequestHeader>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:consultaDetalleTxnHeaderIn($username,
    $password)