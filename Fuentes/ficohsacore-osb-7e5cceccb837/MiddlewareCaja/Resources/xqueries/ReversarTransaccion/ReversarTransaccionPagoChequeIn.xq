(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion" element="ns1:reversarTransaccion" location="../../xsds/ReversarTransaccion/ReversarTransaccion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReversiondePagodeCheques" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoChequeIn/";

declare function xf:ReversarTransaccionPagoChequeIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversarTransaccion as element(ns1:reversarTransaccion),
    $uuid as xs:string)
    as element(ns0:ReversiondePagodeCheques) {
        <ns0:ReversiondePagodeCheques>
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
            <FICOHCHQTRANREVERSEINPUTType>
                <Transactionid>{ data($reversarTransaccion/TRANSACTION_ID) }</Transactionid>
            </FICOHCHQTRANREVERSEINPUTType>
        </ns0:ReversiondePagodeCheques>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversarTransaccion as element(ns1:reversarTransaccion) external;
declare variable $uuid as xs:string external;

xf:ReversarTransaccionPagoChequeIn($autenticacionRequestHeader,
    $reversarTransaccion,
    $uuid)