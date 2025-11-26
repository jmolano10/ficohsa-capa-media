(:: pragma bea:global-element-parameter parameter="$consultadedetrecaudomigracionResponse" element="ns1:ConsultadedetrecaudomigracionResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/RegistrarRelacionOperacionRecaudoMigracion/FLINK_OSB_REG_OPER_RECAUDO_MIGRACION.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REG_OPER_RECAUDO_MIGRACION/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMigracion/ConsultaRecaudoMigracionRegistrarOperRecaudoMigracionIn/";

declare function xf:ConsultaRecaudoMigracionRegistrarOperRecaudoMigracionIn($consultadedetrecaudomigracionResponse as element(ns1:ConsultadedetrecaudomigracionResponse))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $NATIONALID in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/NATIONALID
                return
                    <ns0:NUMERO_IDENTIDAD>{ data($NATIONALID) }</ns0:NUMERO_IDENTIDAD>
            }
            {
                for $PAYCONFIRMATIONNO in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/PAYCONFIRMATIONNO
                return
                    <ns0:NO_CONFIRMACION>{ data($PAYCONFIRMATIONNO) }</ns0:NO_CONFIRMACION>
            }
            {
                for $APPOINTMENTNO in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/APPOINTMENTNO
                return
                    <ns0:NUMERO_CITA>{ data($APPOINTMENTNO) }</ns0:NUMERO_CITA>
            }
            {
                for $APPOINTMENTDATE in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/APPOINTMENTDATE
                return
                    <ns0:FECHA_CITA>{ data($APPOINTMENTDATE) }</ns0:FECHA_CITA>
            }
            {
                for $APPOINTMENTTIME in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/APPOINTMENTTIME
                return
                    <ns0:HORA_CITA>{ data($APPOINTMENTTIME) }</ns0:HORA_CITA>
            }
            {
                for $CURRENCY in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/CURRENCY,
                    $TOTALAMOUNT in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/TOTALAMOUNT
                return
                    <ns0:VALOR_CITA_FCY>{ concat($CURRENCY , $TOTALAMOUNT) }</ns0:VALOR_CITA_FCY>
            }
            {
                for $PAYMENTCURRENCY in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/PAYMENTCURRENCY
                return
                    <ns0:MONEDA_PAGO>{ data($PAYMENTCURRENCY) }</ns0:MONEDA_PAGO>
            }
            {
                for $AMOUNTTOPAY in $consultadedetrecaudomigracionResponse/LATAMAGEPPORTAPPOINTMENTType[1]/gLATAMAGEPPORTAPPOINTMENTDetailType/mLATAMAGEPPORTAPPOINTMENTDetailType[1]/AMOUNTTOPAY
                return
                    <ns0:MONTO_PAGO>{ data($AMOUNTTOPAY) }</ns0:MONTO_PAGO>
            }
            <ns0:ESTADO>1</ns0:ESTADO>
        </ns0:InputParameters>
};

declare variable $consultadedetrecaudomigracionResponse as element(ns1:ConsultadedetrecaudomigracionResponse) external;

xf:ConsultaRecaudoMigracionRegistrarOperRecaudoMigracionIn($consultadedetrecaudomigracionResponse)