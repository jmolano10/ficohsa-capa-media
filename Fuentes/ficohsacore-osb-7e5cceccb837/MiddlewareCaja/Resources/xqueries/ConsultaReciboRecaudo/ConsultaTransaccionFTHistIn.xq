(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadetransaccionhistFT" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboRecaudo/ConsultaTransaccionFTHistIn/";

declare function xf:ConsultaTransaccionFTHistIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $transactionID as xs:string)
    as element(ns0:ConsultadetransaccionhistFT) {
        <ns0:ConsultadetransaccionhistFT>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSFTTRANSACTIONHISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ concat($transactionID, ";1") }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFTTRANSACTIONHISTType>
        </ns0:ConsultadetransaccionhistFT>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $transactionID as xs:string external;

xf:ConsultaTransaccionFTHistIn($autenticacionRequestHeader,
    $transactionID)