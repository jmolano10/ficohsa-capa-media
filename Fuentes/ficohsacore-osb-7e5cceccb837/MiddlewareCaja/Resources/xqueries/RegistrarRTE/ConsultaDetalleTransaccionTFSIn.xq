(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadetransaccionTFS" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/ConsultaDetalleTransaccionTFSIn/";

declare function xf:ConsultaDetalleTransaccionTFSIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $transactionID as xs:string)
    as element(ns0:ConsultadetransaccionTFS) {
        <ns0:ConsultadetransaccionTFS>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSTFSTRANSACTIONType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $transactionID }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSTFSTRANSACTIONType>
        </ns0:ConsultadetransaccionTFS>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $transactionID as xs:string external;

xf:ConsultaDetalleTransaccionTFSIn($autenticacionRequestHeader,
    $transactionID)