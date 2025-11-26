(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion" element="ns1:reversarTransaccion" location="../../xsds/ReversarTransaccion/ReversarTransaccion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Reversionpagorecaudolineachqintl" location="../../xsds/ReversaTxnRecaudos/XMLSchema_728098728.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoLocalIntChqIn/";

declare function xf:ReversarTransaccionPagoRecaudoLocalIntChqIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversarTransaccion as element(ns1:reversarTransaccion))
    as element(ns0:Reversionpagorecaudolineachqintl) {
        <ns0:Reversionpagorecaudolineachqintl>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <TELLERLATAMDIRCHQINTLREVType>
                <transactionId>{ data($reversarTransaccion/TRANSACTION_ID) }</transactionId>
            </TELLERLATAMDIRCHQINTLREVType>
        </ns0:Reversionpagorecaudolineachqintl>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversarTransaccion as element(ns1:reversarTransaccion) external;

xf:ReversarTransaccionPagoRecaudoLocalIntChqIn($autenticacionRequestHeader,
    $reversarTransaccion)