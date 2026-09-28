(:: pragma bea:global-element-return element="ns0:sjConsultaTipoTarjeta" location="../../BusinessServices/SJS/consultaTipoTarjeta/xsd/sjConsultaTipoTarjeta.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjeta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/consultaTipoTarjetaHNIn/";

declare function xf:consultaTipoTarjetaHNIn($username as xs:string,
    $password as xs:string,
    $binNumber as xs:string)
    as element(ns0:sjConsultaTipoTarjeta) {
        <ns0:sjConsultaTipoTarjeta>
            <ns0:USERNAME>{ $username }</ns0:USERNAME>
            <ns0:PASSWORD>{ $password }</ns0:PASSWORD>
            <ns0:BIN_NUMBER>{ $binNumber }</ns0:BIN_NUMBER>
        </ns0:sjConsultaTipoTarjeta>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $binNumber as xs:string external;

xf:consultaTipoTarjetaHNIn($username,
    $password,
    $binNumber)