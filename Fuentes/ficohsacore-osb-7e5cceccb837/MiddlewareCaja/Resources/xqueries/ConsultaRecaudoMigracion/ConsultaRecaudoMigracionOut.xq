(:: pragma bea:global-element-parameter parameter="$consultadedetrecaudomigracionResponse" element="ns0:ConsultadedetrecaudomigracionResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoMigracionResponse" location="../../xsds/ConsultaRecaudoMigracion/ConsultaRecaudoMigracion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMigracionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMigracion/ConsultaRecaudoMigracionOut/";

declare function xf:ConsultaRecaudoMigracionOut($consultadedetrecaudomigracionResponse as element(ns0:ConsultadedetrecaudomigracionResponse))
    as element(ns1:consultaRecaudoMigracionResponse) {
        <ns1:consultaRecaudoMigracionResponse>
            {
                for $NATIONALID in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/NATIONALID
                return
                    <ORD_PARTY_ID>{ data($NATIONALID) }</ORD_PARTY_ID>
            }
            {
                for $APPOINTMENTNO in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/APPOINTMENTNO
                return
                    <APPOINTMENT_NUMBER>{ data($APPOINTMENTNO) }</APPOINTMENT_NUMBER>
            }
            {
                for $APPOINTMENTDATE in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/APPOINTMENTDATE,
                    $APPOINTMENTTIME in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/APPOINTMENTTIME
                return
                    <APPOINTMENT_DATE_TIME>{ concat($APPOINTMENTDATE , " ", $APPOINTMENTTIME) }</APPOINTMENT_DATE_TIME>
            }
            {
                for $CURRENCY in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/CURRENCY,
                    $TOTALAMOUNT in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/TOTALAMOUNT
                return
                    <AMOUNT_FCY>{ concat($CURRENCY , " ", $TOTALAMOUNT) }</AMOUNT_FCY>
            }
            {
                for $PAYMENTCURRENCY in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/PAYMENTCURRENCY,
                    $AMOUNTTOPAY in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/AMOUNTTOPAY
                return
                    <AMOUNT_LCY>{ concat($PAYMENTCURRENCY , " ", $AMOUNTTOPAY) }</AMOUNT_LCY>
            }
        </ns1:consultaRecaudoMigracionResponse>
};

declare variable $consultadedetrecaudomigracionResponse as element(ns0:ConsultadedetrecaudomigracionResponse) external;

xf:ConsultaRecaudoMigracionOut($consultadedetrecaudomigracionResponse)