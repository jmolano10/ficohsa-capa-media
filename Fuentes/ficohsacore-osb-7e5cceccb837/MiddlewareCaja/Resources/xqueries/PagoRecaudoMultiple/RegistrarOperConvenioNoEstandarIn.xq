(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoMultiple" element="ns1:pagoRecaudoMultiple" location="../../xsds/PagoRecaudoMultiple/PagoRecaudoMultiple.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/RegistrarOperacionConvenioNoEstandar/FLINK_INT_K_CONVENIOS_NO_ESTANDAR_INT_CV_REGISTRAR_INFO_OPER.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMultipleTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/INT_K_CONVENIOS_NO_ESTANDAR/INT_CV_REGISTRAR_INFO_OPER/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMultiple/RegistrarOperConvenioNoEstandarIn/";

declare function xf:RegistrarOperConvenioNoEstandarIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudoMultiple as element(ns1:pagoRecaudoMultiple),
    $tipoOperacion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CONTRACT_ID>{ data($pagoRecaudoMultiple/CONTRACT_ID) }</ns0:CONTRACT_ID>
            <ns0:DEBTOR_CODE>{ data($pagoRecaudoMultiple/DEBTOR_CODE) }</ns0:DEBTOR_CODE>
            <ns0:CHANNEL_CODE>{ data($autenticacionRequestHeader/UserName) }</ns0:CHANNEL_CODE>
            <ns0:USER_ID>{ data($autenticacionRequestHeader/UserName) }</ns0:USER_ID>
            {
                for $PAYMENT_AMOUNT in $pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                return
                    <ns0:TOTAL_AMOUNT>{ data($PAYMENT_AMOUNT) }</ns0:TOTAL_AMOUNT>
            }
            <ns0:CURRENCY>{ data($pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:CURRENCY>
            <ns0:OPERATION_CODE>{ $tipoOperacion }</ns0:OPERATION_CODE>
            <ns0:ADDITIONAL_INFO>
                {
                    for $DATA in $pagoRecaudoMultiple/ADDITIONAL_INFO/DATA
                    return
                        <ns0:ITEM>{ data($DATA) }</ns0:ITEM>
                }
            </ns0:ADDITIONAL_INFO>
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoMultiple as element(ns1:pagoRecaudoMultiple) external;
declare variable $tipoOperacion as xs:string external;

xf:RegistrarOperConvenioNoEstandarIn($autenticacionRequestHeader,
    $pagoRecaudoMultiple,
    $tipoOperacion)