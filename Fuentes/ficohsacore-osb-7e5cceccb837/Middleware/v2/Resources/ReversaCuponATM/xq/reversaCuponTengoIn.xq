(:: pragma bea:global-element-return element="ns0:reversioncupon" location="../../../BusinessServices/TENGO/umarketscReversiones/xsd/serviceATM_3.xsd" ::)

declare namespace ns0 = "http://appATM/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaCuponATM/xq/reversaCuponTengoIn/";

declare function xf:reversaCuponTengoIn($transactionId as xs:string)
    as element(ns0:reversioncupon) {
        <ns0:reversioncupon>
            <TrxidTengo>{ $transactionId }</TrxidTengo>
        </ns0:reversioncupon>
};

declare variable $transactionId as xs:string external;

xf:reversaCuponTengoIn($transactionId)
