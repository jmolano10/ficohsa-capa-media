(:: pragma bea:global-element-parameter parameter="$clientesBancarazionResponse1" element="ns0:ClientesBancarazionResponse" location="../../../BusinessServices/T24/consultaClienteBancarizacion/xsd/svcBancarizacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteBancarizacionResponse" location="../xsd/consultaClienteBancarizacionTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClienteBancarizacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteBancarizacion/xq/ConsultaClienteBancarizacionOut/";

declare function xf:ConsultaClienteBancarizacionOut($clientesBancarazionResponse1 as element(ns0:ClientesBancarazionResponse))
    as element(ns1:consultaClienteBancarizacionResponse) {
        <ns1:consultaClienteBancarizacionResponse>
            <ns1:consultaClienteBancarizacionResponseType>
                {
                    for $mFICOHNBANCCLNTSWSDetailType in $clientesBancarazionResponse1/FICOHNBANCCLNTSWSType[1]/gFICOHNBANCCLNTSWSDetailType/mFICOHNBANCCLNTSWSDetailType
                    return
                        <ns1:consultaClienteBancarizacionResponseRecordType>
                            {
                                for $CUSTID in $mFICOHNBANCCLNTSWSDetailType/CUSTID
                                return
                                    <CUSTOMER_ID>{ data($CUSTID) }</CUSTOMER_ID>
                            }
                            {
                                for $LGLID in $mFICOHNBANCCLNTSWSDetailType/LGLID
                                return
                                    <LEGAL_ID>{ data($LGLID) }</LEGAL_ID>
                            }
                            {
                                for $ACCTID in $mFICOHNBANCCLNTSWSDetailType/ACCTID
                                return
                                    <ACCOUNT_ID>{ data($ACCTID) }</ACCOUNT_ID>
                            }
                            {
                                for $CATEGORY in $mFICOHNBANCCLNTSWSDetailType/CATEGORY
                                return
                                    <CATEGORY>{ data($CATEGORY) }</CATEGORY>
                            }
                            {
                                for $CURRENCY in $mFICOHNBANCCLNTSWSDetailType/CURRENCY
                                return
                                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                            }
                            {
                                for $OPENINGDATE in $mFICOHNBANCCLNTSWSDetailType/OPENINGDATE
                                return
                                    <OPENING_DATE>{ data($OPENINGDATE) }</OPENING_DATE>
                            }
                            {
                                for $CURRENTBALANCE in $mFICOHNBANCCLNTSWSDetailType/CURRENTBALANCE
                                return
                                    <CURRENT_BALANCE>{ data($CURRENTBALANCE) }</CURRENT_BALANCE>
                            }
                        </ns1:consultaClienteBancarizacionResponseRecordType>
                }
            </ns1:consultaClienteBancarizacionResponseType>
        </ns1:consultaClienteBancarizacionResponse>
};

declare variable $clientesBancarazionResponse1 as element(ns0:ClientesBancarazionResponse) external;

xf:ConsultaClienteBancarizacionOut($clientesBancarazionResponse1)