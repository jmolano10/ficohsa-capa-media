(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion" element="ns1:reversarTransaccion" location="../../xsds/ReversarTransaccion/ReversarTransaccion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadetransaccionFT" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ConsultaTransaccionFT/";

declare function xf:ConsultaTransaccionFT($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversarTransaccion as element(ns1:reversarTransaccion))
    as element(ns0:ConsultadetransaccionFT) {
        <ns0:ConsultadetransaccionFT>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSFTTRANSACTIONType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($reversarTransaccion/TRANSACTION_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFTTRANSACTIONType>
        </ns0:ConsultadetransaccionFT>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversarTransaccion as element(ns1:reversarTransaccion) external;

xf:ConsultaTransaccionFT($autenticacionRequestHeader,
    $reversarTransaccion)