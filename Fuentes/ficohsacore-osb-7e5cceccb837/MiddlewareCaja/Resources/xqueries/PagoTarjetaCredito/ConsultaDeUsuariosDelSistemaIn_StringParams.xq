(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/ConsultaDeUsuariosDelSistemaIn_StringParams/";

declare function xf:ConsultaDeUsuariosDelSistemaIn_StringParams($User as xs:string,
    $Password as xs:string,
    $Inputter as xs:string)
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            <WebRequestCommon>
                <userName>{ $User }</userName>
                <password>{ $Password }</password>
            </WebRequestCommon>
            <WSUSERType>
                <enquiryInputCollection>
                    <criteriaValue>{ $Inputter }</criteriaValue>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $User as xs:string external;
declare variable $Password as xs:string external;
declare variable $Inputter as xs:string external;

xf:ConsultaDeUsuariosDelSistemaIn_StringParams($User,
    $Password,
    $Inputter)
