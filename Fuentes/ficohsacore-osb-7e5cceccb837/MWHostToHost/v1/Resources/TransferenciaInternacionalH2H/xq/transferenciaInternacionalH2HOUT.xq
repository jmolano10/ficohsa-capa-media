(:: pragma bea:global-element-parameter parameter="$sjTransferenciaInternacionalResponse" element="ns0:sjTransferenciaInternacionalResponse" location="../../../BusinessServices/SJS/TransferenciaInternacionalH2H/xsd/sjTransferenciaInternacionalH2H.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaInternacionalH2HResponse" location="../xsd/transferenciaInternacionalH2HTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2H/xq/transferenciaInternacionalH2HOUT/";

declare function xf:transferenciaInternacionalH2HOUT($sjTransferenciaInternacionalResponse as element(ns0:sjTransferenciaInternacionalResponse))
    as element(ns1:transferenciaInternacionalH2HResponse) {
        <ns1:transferenciaInternacionalH2HResponse>
            <TRANSFERS_INT>
                <TRANSFER_INT>
                    {
                        for $SUCCESS_INDICATOR in $sjTransferenciaInternacionalResponse/TRANSFERS_INT/TRANSFER_INT[1]/SUCCESS_INDICATOR
                        return
                            <SUCCESS_INDICATOR>{ data($SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                    }
                    {
                        for $ERROR_MESSAGE in $sjTransferenciaInternacionalResponse/TRANSFERS_INT/TRANSFER_INT[1]/ERROR_MESSAGE
                        return
                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                    }
                    <TRACE>{ data($sjTransferenciaInternacionalResponse/TRANSFERS_INT/TRANSFER_INT[1]/TRACE) }</TRACE>
                    {
                        for $TRANSACTION_ID in $sjTransferenciaInternacionalResponse/TRANSFERS_INT/TRANSFER_INT[1]/TRANSACTION_ID
                        return
                            <TRANSACTION_ID>{ data($TRANSACTION_ID) }</TRANSACTION_ID>
                    }
                    {
                        for $ORDERING_CUSTOMER in $sjTransferenciaInternacionalResponse/TRANSFERS_INT/TRANSFER_INT[1]/ORDERING_CUSTOMER
                        return
                            <ORDERING_CUSTOMER>{ data($ORDERING_CUSTOMER) }</ORDERING_CUSTOMER>
                    }
                </TRANSFER_INT>
            </TRANSFERS_INT>
        </ns1:transferenciaInternacionalH2HResponse>
};

declare variable $sjTransferenciaInternacionalResponse as element(ns0:sjTransferenciaInternacionalResponse) external;

xf:transferenciaInternacionalH2HOUT($sjTransferenciaInternacionalResponse)