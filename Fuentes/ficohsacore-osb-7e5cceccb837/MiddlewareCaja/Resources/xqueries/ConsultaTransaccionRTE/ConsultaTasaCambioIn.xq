(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetasadecambiolcy" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaTransaccionRTE/ConsultaTasaCambioIn/";

declare function xf:ConsultaTasaCambioIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader))
    as element(ns0:Consultadetasadecambiolcy) {
        <ns0:Consultadetasadecambiolcy>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSLCYEXCHRATEType>
                <enquiryInputCollection>
                    <columnName>CURRENCY.CODE</columnName>
                    <criteriaValue>USD</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSLCYEXCHRATEType>
        </ns0:Consultadetasadecambiolcy>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;

xf:ConsultaTasaCambioIn($autenticacionRequestHeader)