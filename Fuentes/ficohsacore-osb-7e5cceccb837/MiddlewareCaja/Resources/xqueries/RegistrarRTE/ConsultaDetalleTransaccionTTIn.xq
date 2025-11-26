(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadetransaccionTT" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/ConsultaDetalleTransaccionTTIn/";

declare function xf:ConsultaDetalleTransaccionTTIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $transactionID as xs:string)
    as element(ns0:ConsultadetransaccionTT) {
        <ns0:ConsultadetransaccionTT>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSTTTRANSACTIONType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $transactionID }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSTTTRANSACTIONType>
        </ns0:ConsultadetransaccionTT>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $transactionID as xs:string external;

xf:ConsultaDetalleTransaccionTTIn($autenticacionRequestHeader,
    $transactionID)