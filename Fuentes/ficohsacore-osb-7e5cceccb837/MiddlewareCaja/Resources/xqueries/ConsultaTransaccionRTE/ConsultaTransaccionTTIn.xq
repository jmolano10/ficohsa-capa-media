(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaTransaccionRTE" element="ns1:consultaTransaccionRTE" location="../../xsds/ConsultaTransaccionRTE/ConsultaTransaccionRTE.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadetransaccionTT" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionRTETypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaTransaccionRTE/ConsultaTransaccionTTIn/";

declare function xf:ConsultaTransaccionTTIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaTransaccionRTE as element(ns1:consultaTransaccionRTE))
    as element(ns0:ConsultadetransaccionTT) {
        <ns0:ConsultadetransaccionTT>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSTTTRANSACTIONType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaTransaccionRTE/TRANSACTION_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSTTTRANSACTIONType>
        </ns0:ConsultadetransaccionTT>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaTransaccionRTE as element(ns1:consultaTransaccionRTE) external;

xf:ConsultaTransaccionTTIn($autenticacionRequestHeader,
    $consultaTransaccionRTE)