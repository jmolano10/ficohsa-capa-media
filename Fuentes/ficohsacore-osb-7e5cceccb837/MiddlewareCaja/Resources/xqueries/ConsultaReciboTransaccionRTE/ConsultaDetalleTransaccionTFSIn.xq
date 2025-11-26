(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaReciboTransaccionRTE" element="ns1:consultaReciboTransaccionRTE" location="../../xsds/ConsultaReciboTransaccionRTE/ConsultaReciboTransaccionRTE.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadetransaccionTFS" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaReciboTransaccionRTETypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboTransaccionRTE/ConsultaDetalleTransaccionTFSIn/";

declare function xf:ConsultaDetalleTransaccionTFSIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaReciboTransaccionRTE as element(ns1:consultaReciboTransaccionRTE))
    as element(ns0:ConsultadetransaccionTFS) {
        <ns0:ConsultadetransaccionTFS>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSTFSTRANSACTIONType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaReciboTransaccionRTE/TRANSACTION_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSTFSTRANSACTIONType>
        </ns0:ConsultadetransaccionTFS>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaReciboTransaccionRTE as element(ns1:consultaReciboTransaccionRTE) external;

xf:ConsultaDetalleTransaccionTFSIn($autenticacionRequestHeader,
    $consultaReciboTransaccionRTE)