(:: pragma bea:global-element-parameter parameter="$consultadedetallederecaudoResponse" element="ns0:ConsultadedetallederecaudoResponse" location="../Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/RegistrarRelacionOperacionRecaudo/xsd/FLINK_OSB_REGISTRAR_OPER_RECAUDO.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REGISTRAR_OPER_RECAUDO/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoRegistrarOperacionRecaudoIn/";

declare function xf:consultaRecaudoRegistrarOperacionRecaudoIn($consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse),
    $estado as xs:string,
    $codigoDeudor as xs:string,
    $nombreDeudor as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $SERVICEID in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICEID
                return
                    <ns1:CODIGO_CONTRATO>{ data($SERVICEID) }</ns1:CODIGO_CONTRATO>
            }
            <ns1:CODIGO_DEUDOR>{ $codigoDeudor }</ns1:CODIGO_DEUDOR>
            <ns1:CODIGO_FACTURA>
                {
                    for $BILLNUMBER in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLNUMBER
                    return
                        <ns1:ITEM>{ data($BILLNUMBER) }</ns1:ITEM>   
                }
            </ns1:CODIGO_FACTURA>
            <ns1:MONEDA_FACTURA>
                {
                    for $BILLCCY in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
                    return
                        <ns1:ITEM>{ data($BILLCCY) }</ns1:ITEM>
                }
            </ns1:MONEDA_FACTURA>
            <ns1:FECHA_FACTURA>
                {
                    for $BILLDATE in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLDATE
                    return
                        <ns1:ITEM>{ data($BILLDATE) }</ns1:ITEM>
                }
            </ns1:FECHA_FACTURA>
            <ns1:FECHA_VENCIMIENTO>
                {
                    for $DUEDATE in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/DUEDATE
                    return
                        <ns1:ITEM>{ data($DUEDATE) }</ns1:ITEM>
                }
            </ns1:FECHA_VENCIMIENTO>
            <ns1:MONTO_FACTURA>
                {
                    for $BILLAMOUNT in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLAMOUNT
                    return
                        <ns1:ITEM>{ data($BILLAMOUNT) }</ns1:ITEM>
                }
            </ns1:MONTO_FACTURA>
            <ns1:MORA>
                {
                    for $LATEFEE in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/LATEFEE
                    return
                        <ns1:ITEM>{ data($LATEFEE) }</ns1:ITEM>
                }
            </ns1:MORA>
            <ns1:MONEDA_SOLICITUD>
                {
                    for $CURRENCY in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/CURRENCY
                    return
                        <ns1:ITEM>{ data($CURRENCY) }</ns1:ITEM>
                }
            </ns1:MONEDA_SOLICITUD>
            <ns1:MONTO_TOTAL>
                {
                    for $TOTALAMOUNT in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/TOTALAMOUNT
                    return
                        <ns1:ITEM>{ data($TOTALAMOUNT) }</ns1:ITEM>
                }
            </ns1:MONTO_TOTAL>
            <ns1:ESTADO>{ $estado }</ns1:ESTADO>
            <ns1:NOMBRE_DEUDOR>{ $nombreDeudor }</ns1:NOMBRE_DEUDOR>
        </ns1:InputParameters>
};

declare variable $consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse) external;
declare variable $estado as xs:string external;
declare variable $codigoDeudor as xs:string external;
declare variable $nombreDeudor as xs:string external;

xf:consultaRecaudoRegistrarOperacionRecaudoIn($consultadedetallederecaudoResponse,
    $estado,
    $codigoDeudor,
    $nombreDeudor)