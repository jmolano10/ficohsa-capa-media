(:: pragma bea:global-element-parameter parameter="$consultaRecaudoResponse" element="ns0:consultaRecaudoResponse" location="../../xsds/ConsultaRecaudo/ConsultaRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoAutoBancosResponse" location="../../xsds/ConsultaRecaudoAutoBancos/consultaRecaudoAutoBancos.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAutoBancosTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAutoBancos/consultaRecaudoAutoBancosOut/";

declare function xf:consultaRecaudoAutoBancosOut($consultaRecaudoResponse as element(ns0:consultaRecaudoResponse))
    as element(ns1:consultaRecaudoAutoBancosResponse) {
        <ns1:consultaRecaudoAutoBancosResponse>
            {
                for $CONTRACT_ID in $consultaRecaudoResponse/CONTRACT_ID
                return
                    <CONTRACT_ID>{ data($CONTRACT_ID) }</CONTRACT_ID>
            }
            {
                for $CONTRACT_NAME in $consultaRecaudoResponse/CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($CONTRACT_NAME) }</CONTRACT_NAME>
            }
            {
                for $DEBTOR_CODE in $consultaRecaudoResponse/DEBTOR_CODE
                return
                    <DEBTOR_CODE>{ data($DEBTOR_CODE) }</DEBTOR_CODE>
            }
            {
                for $DEBTOR_NAME in $consultaRecaudoResponse/DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($DEBTOR_NAME) }</DEBTOR_NAME>
            }
            {
                for $BILLS in $consultaRecaudoResponse/BILLS
                return
                    <BILLS>{ $BILLS/@* , $BILLS/node() }</BILLS>
            }
            {
                for $BILL_DETAIL in $consultaRecaudoResponse/BILL_DETAIL
                return
                    <BILL_DETAIL>{ data($BILL_DETAIL) }</BILL_DETAIL>
            }
        </ns1:consultaRecaudoAutoBancosResponse>
};

declare variable $consultaRecaudoResponse as element(ns0:consultaRecaudoResponse) external;

xf:consultaRecaudoAutoBancosOut($consultaRecaudoResponse)