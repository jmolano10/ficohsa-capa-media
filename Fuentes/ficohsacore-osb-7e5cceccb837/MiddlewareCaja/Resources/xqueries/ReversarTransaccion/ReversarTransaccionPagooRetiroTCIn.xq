(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion" element="ns1:reversarTransaccion" location="../../xsds/ReversarTransaccion/ReversarTransaccion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReversionpagoTC" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagooRetiroTCIn/";

declare function xf:ReversarTransaccionPagooRetiroTCIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversarTransaccion as element(ns1:reversarTransaccion),
    $uuid as xs:string)
    as element(ns0:ReversionpagoTC) {
        <ns0:ReversionpagoTC>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFINANCIALSERVICESFICOCCARDPAYMENTREVType id = "{ data($reversarTransaccion/TRANSACTION_ID) }"/>
        </ns0:ReversionpagoTC>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversarTransaccion as element(ns1:reversarTransaccion) external;
declare variable $uuid as xs:string external;

xf:ReversarTransaccionPagooRetiroTCIn($autenticacionRequestHeader,
    $reversarTransaccion,
    $uuid)