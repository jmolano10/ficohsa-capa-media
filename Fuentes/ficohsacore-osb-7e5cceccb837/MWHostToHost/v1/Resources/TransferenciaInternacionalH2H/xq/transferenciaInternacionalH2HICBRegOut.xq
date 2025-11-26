(:: pragma bea:global-element-parameter parameter="$sjTransferenciaInternacionalICBResponse" element="ns0:sjTransferenciaInternacionalICBResponse" location="../../../BusinessServices/SJS/TransferenciaInternacionalH2HICB/xsd/sjTransferenciaInternacionalH2HICB.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaInternacionalH2HResponse" location="../xsd/transferenciaInternacionalH2HTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HICBTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2H/xq/transferenciaInternacionalH2HICBRegOut/";

declare function xf:transferenciaInternacionalH2HICBRegOut($sjTransferenciaInternacionalICBResponse as element(ns0:sjTransferenciaInternacionalICBResponse))
    as element(ns1:transferenciaInternacionalH2HResponse) {
        <ns1:transferenciaInternacionalH2HResponse>
            <TRANSFERS_INT>
                {
                    for $transfer in $sjTransferenciaInternacionalICBResponse/TRANSFERS_INT/TRANSFER_INT
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

declare variable $sjTransferenciaInternacionalICBResponse as element(ns0:sjTransferenciaInternacionalICBResponse) external;

xf:transferenciaInternacionalH2HICBRegOut($sjTransferenciaInternacionalICBResponse)