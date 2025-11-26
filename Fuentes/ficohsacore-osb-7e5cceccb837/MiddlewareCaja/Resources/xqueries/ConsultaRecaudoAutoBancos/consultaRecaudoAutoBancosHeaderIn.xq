(:: pragma bea:global-element-return element="ns0:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAutoBancos/consultaRecaudoAutoBancosHeaderIn/";

declare function xf:consultaRecaudoAutoBancosHeaderIn($usuario as xs:string,
    $password as xs:string)
    as element(ns0:AutenticacionRequestHeader) {
        <ns0:AutenticacionRequestHeader>
            <UserName>{ $usuario }</UserName>
            <Password>{ $password }</Password>
        </ns0:AutenticacionRequestHeader>
};

declare variable $usuario as xs:string external;
declare variable $password as xs:string external;

xf:consultaRecaudoAutoBancosHeaderIn($usuario,
    $password)