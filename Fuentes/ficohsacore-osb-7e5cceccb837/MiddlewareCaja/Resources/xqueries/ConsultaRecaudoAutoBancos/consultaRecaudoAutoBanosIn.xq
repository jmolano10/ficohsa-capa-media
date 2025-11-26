(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAutoBancos" element="ns1:consultaRecaudoAutoBancos" location="../../xsds/ConsultaRecaudoAutoBancos/consultaRecaudoAutoBancos.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRecaudo" location="../../xsds/ConsultaRecaudo/ConsultaRecaudo.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAutoBancosTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAutoBancos/consultaRecaudoAutoBanosIn/";

declare function xf:consultaRecaudoAutoBanosIn($consultaRecaudoAutoBancos as element(ns1:consultaRecaudoAutoBancos))
    as element(ns0:consultaRecaudo) {
        <ns0:consultaRecaudo>
            <CONTRACT_ID>{ data($consultaRecaudoAutoBancos/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($consultaRecaudoAutoBancos/DEBTOR_CODE) }</DEBTOR_CODE>
            <CURRENCY>{ data($consultaRecaudoAutoBancos/CURRENCY) }</CURRENCY>
            {
                for $BILL_AMOUNT in $consultaRecaudoAutoBancos/BILL_AMOUNT
                return
                    <BILL_AMOUNT>{ data($BILL_AMOUNT) }</BILL_AMOUNT>
            }
            {
                for $BILL_DATE in $consultaRecaudoAutoBancos/BILL_DATE
                return
                    <BILL_DATE>{ data($BILL_DATE) }</BILL_DATE>
            }
            {
                for $BILL_RETURN_TYPE in $consultaRecaudoAutoBancos/BILL_RETURN_TYPE
                return
                    <BILL_RETURN_TYPE>{ data($BILL_RETURN_TYPE) }</BILL_RETURN_TYPE>
            }
            {
                for $EXTENDED_COLLECTION_YES_NO in $consultaRecaudoAutoBancos/EXTENDED_COLLECTION_YES_NO
                return
                    <EXTENDED_COLLECTION_YES_NO>{ data($EXTENDED_COLLECTION_YES_NO) }</EXTENDED_COLLECTION_YES_NO>
            }
            {
                for $ADDITIONAL_INFO in $consultaRecaudoAutoBancos/ADDITIONAL_INFO
                return
                    <ADDITIONAL_INFO>
                        {
                            for $DATA in $ADDITIONAL_INFO/DATA
                            return
                                <DATA>{ data($DATA) }</DATA>
                        }
                    </ADDITIONAL_INFO>
            }
        </ns0:consultaRecaudo>
};

declare variable $consultaRecaudoAutoBancos as element(ns1:consultaRecaudoAutoBancos) external;

xf:consultaRecaudoAutoBanosIn($consultaRecaudoAutoBancos)