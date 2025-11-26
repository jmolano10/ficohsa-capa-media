(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadetransaccionhistTT" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboRecaudo/ConsultaTransaccionTTHistIn/";

declare function xf:ConsultaTransaccionTTHistIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $transactionID as xs:string)
    as element(ns0:ConsultadetransaccionhistTT) {
        <ns0:ConsultadetransaccionhistTT>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSTTTRANSACTIONHISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ concat($transactionID, ";1") }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSTTTRANSACTIONHISTType>
        </ns0:ConsultadetransaccionhistTT>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $transactionID as xs:string external;

xf:ConsultaTransaccionTTHistIn($autenticacionRequestHeader,
    $transactionID)