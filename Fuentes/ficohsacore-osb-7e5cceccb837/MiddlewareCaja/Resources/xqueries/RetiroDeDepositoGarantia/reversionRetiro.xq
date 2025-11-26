(:: pragma bea:global-element-return element="ns0:ReversiondetransaccionTT" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeDepositoGarantia/reversionRetiro/";

declare function xf:reversionRetiro($UserName as xs:string,
    $Password as xs:string,
    $TransactionID as xs:string)
    as element(ns0:ReversiondetransaccionTT) {
        <ns0:ReversiondetransaccionTT>
            <WebRequestCommon>
                <userName>{ $UserName }</userName>
                <password>{ $Password }</password>
            </WebRequestCommon>
            <TELLERREVERSEType>
                <transactionId>{ $TransactionID }</transactionId>
            </TELLERREVERSEType>
        </ns0:ReversiondetransaccionTT>
};

declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $TransactionID as xs:string external;

xf:reversionRetiro($UserName,
    $Password,
    $TransactionID)
