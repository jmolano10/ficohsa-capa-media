(:: pragma bea:global-element-parameter parameter="$sjTransferenciaInternacionalResponse" element="ns0:sjTransferenciaInternacionalResponse" location="../../../BusinessServices/SJS/TransferenciaInternacionalH2H/xsd/sjTransferenciaInternacionalH2H.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaInternacionalH2HResponse" location="../xsd/transferenciaInternacionalH2HTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2H/xq/transferenciaInternacionalH2HOUT/";

declare function xf:transferenciaInternacionalH2HOUT($sjTransferenciaInternacionalResponse as element(ns0:sjTransferenciaInternacionalResponse))
    as element(ns1:transferenciaInternacionalH2HResponse) {
        <ns1:transferenciaInternacionalH2HResponse>
            <TRANSFERS_INT>
                {
                    for $transfer in $sjTransferenciaInternacionalResponse/TRANSFERS_INT/TRANSFER_INT
                    return
                        <TRANSFER_INT>
                            <SUCCESS_INDICATOR>{ data($transfer/SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                            <ERROR_MESSAGE>{ data($transfer/ERROR_MESSAGE) }</ERROR_MESSAGE>
                            <TRACE>{ data($transfer/TRACE) }</TRACE>
                            <TRANSACTION_ID>{ data($transfer/TRANSACTION_ID) }</TRANSACTION_ID>
                            <ORDERING_CUSTOMER>{ data($transfer/ORDERING_CUSTOMER) }</ORDERING_CUSTOMER>
                        </TRANSFER_INT>
                }
            </TRANSFERS_INT>
        </ns1:transferenciaInternacionalH2HResponse>
};

declare variable $sjTransferenciaInternacionalResponse as element(ns0:sjTransferenciaInternacionalResponse) external;

xf:transferenciaInternacionalH2HOUT($sjTransferenciaInternacionalResponse)