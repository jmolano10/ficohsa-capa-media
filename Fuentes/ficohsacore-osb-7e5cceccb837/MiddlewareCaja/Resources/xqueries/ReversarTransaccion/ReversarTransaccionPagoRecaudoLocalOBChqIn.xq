(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion" element="ns1:reversarTransaccion" location="../../xsds/ReversarTransaccion/ReversarTransaccion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Reversionpagorecaudolineaobchq" location="../../xsds/ReversaTxnRecaudos/XMLSchema_728098728.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoLocalOBChqIn/";

declare function xf:ReversarTransaccionPagoRecaudoLocalOBChqIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversarTransaccion as element(ns1:reversarTransaccion))
    as element(ns0:Reversionpagorecaudolineaobchq) {
        <ns0:Reversionpagorecaudolineaobchq>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <TELLERLATAMOBCHEQUEREVType>
                <transactionId>{ data($reversarTransaccion/TRANSACTION_ID) }</transactionId>
            </TELLERLATAMOBCHEQUEREVType>
        </ns0:Reversionpagorecaudolineaobchq>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversarTransaccion as element(ns1:reversarTransaccion) external;

xf:ReversarTransaccionPagoRecaudoLocalOBChqIn($autenticacionRequestHeader,
    $reversarTransaccion)